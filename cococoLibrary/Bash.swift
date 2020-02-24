//
//  Bash.swift
//  cococo
//
//  Created by Michael Heinzl on 08.01.20.
//  Copyright © 2020 mySugr GmbH. All rights reserved.
//

import Foundation

/// Executes commands on /bin/bash
public class Bash {
    
	public enum Error: Swift.Error, Equatable {
		case failed(terminationStatus: Int)
	}
	
	/// Executes a command including its parameters
	///
	/// - Parameters:
	///   - commandName: The command to execute e.g. "ls"
	///   - arguments: The command arguments e.g. ["-l", "-a"]
	/// - Returns: The output of the command
    public func execute(commandName: String, arguments: [String] = []) throws -> String {
        let bashCommand = try launchProcess(
			command: "/bin/bash",
			arguments: ["-l", "-c", "which \(commandName)"]
		)
        return try launchProcess(
			command: bashCommand.trimmingCharacters(in: .whitespacesAndNewlines),
			arguments: arguments
		)
    }
    
    private func launchProcess(command: String, arguments: [String]) throws -> String {
        let process = Process()
        process.launchPath = command
        process.arguments = arguments
        
        let pipe = Pipe()
        process.standardOutput = pipe
        process.launch()
		
        let outputData = pipe.fileHandleForReading.readDataToEndOfFile()
        let output = String(data: outputData, encoding: .utf8) ?? ""
		
		process.waitUntilExit()
		pipe.fileHandleForReading.closeFile()
		let status = process.terminationStatus
		if status == 0 {
			return output
		} else {
			throw Error.failed(terminationStatus: Int(status))
		}
    }
	
}
