//
//  Converter.swift
//  cococo
//
//  Created by Michael Heinzl on 10.01.20.
//  Copyright © 2020 mySugr GmbH. All rights reserved.
//

import Foundation

/// Converts a xcresult archive to SonarQube's generic code coverage format
public class Converter {
	
	private let io = IO()
	private let arrayWriteQueue = DispatchQueue(label: "write-queue", attributes: .concurrent)
	private let xmlEscaper = XMLEscaper()
	
	public init() {}

    /// Converts an array of xcresult archives to SonarQube's generic code coverage format
    ///
    /// - Parameters:
    ///   - archivePaths: Paths to the xcresult archives to be processed
    /// - Returns: The converted XML string
    public func convert(_ archivePaths: [String], excludedFileExtensions: [String]?) throws -> String {
        var finalOutput = [String?]()
        try archivePaths.forEach {
            try finalOutput += convert($0, excludedFileExtensions: excludedFileExtensions)
        }
        finalOutput.insert("<coverage version=\"1\">", at: 0)
            finalOutput.append("</coverage>\n")

            return finalOutput
                .lazy
                .compactMap { $0 }
                .joined(separator: "\n")
    }
	
	/// Converts an xcresult archive to SonarQube's generic code coverage format
	///
	/// - Parameters:
	///   - archivePath: Path to the xcresult archive
	/// - Returns: An array containing converted XML nodes for the archive at the given path
	internal func convert(_ archivePath: String, excludedFileExtensions: [String]?) throws -> [String?] {
		let bash = Bash()
		let listOutput = try bash.execute(
			commandName: "xcrun",
			arguments: ["xccov", "view", "--archive", "--file-list", archivePath]
		)
		
		var fileList = listOutput
			.components(separatedBy: .newlines)
			.filter({ !$0.isEmpty })

		if let excludedFileExtensions = excludedFileExtensions {
			fileList = filterFilePaths(fileList, excludedFileExtensions: excludedFileExtensions)
		}
		
		var finalOutput = Array<String?>(repeating: nil, count: fileList.count)
		DispatchQueue.concurrentPerform(iterations: fileList.count) { (i) in
			let filePath = String(fileList[i])
			io.print("\(i)/\(fileList.count) \(filePath)", to: .error)
			do {
				let output = try convertFile(filePath, archivePath: archivePath)
				arrayWriteQueue.async(flags: .barrier) {
					finalOutput[i] = output
				}
			} catch {
				io.print("Conversion failed for: \(filePath)", to: .error)
			}
		}
        return finalOutput
	}

    /// Converts a single code coverage file to SonarQube's generic code coverage format
    ///
    /// - Parameters:
    ///   - filePath: Path to the code coverage file
    ///   - archivePath: Path to the xcresult archive
    /// - Returns: The resulting XML string for the given file
    internal func convertFile(_ filePath: String, archivePath: String) throws -> String {
        let bash = Bash()
        let viewOutput = try bash.execute(commandName: "xcrun", arguments: ["xccov", "view", "--archive", "--file", filePath, archivePath])
        let lines = viewOutput.split(separator: "\n")

        var output = [String]()
        let escapedPath = xmlEscaper.escape(filePath)
        output.append("  <file path=\"\(escapedPath)\">")

        for line in lines {
            if line.hasSuffix("*") {
                continue
            }
            let components = line.components(separatedBy: ": ")
            guard components.count == 2 else {
                continue
            }
            let lineNumber = components[0].trimmingCharacters(in: .whitespaces)
            let isTested = components[1].hasPrefix("0") ? "false" : "true"
            output.append("    <lineToCover lineNumber=\"\(lineNumber)\" covered=\"\(isTested)\"/>")
        }
        output.append("  </file>")
        return output.joined(separator: "\n")
    }
	
	internal func filterFilePaths(_ paths: [String], excludedFileExtensions: [String]) -> [String] {
		return paths.filter({ (filePath) -> Bool in
			let containsExcludedFileExtensions = excludedFileExtensions.contains { (fileExtensions) -> Bool in
				filePath.hasSuffix(fileExtensions)
			}
			return !containsExcludedFileExtensions
		})
	}
	
}
