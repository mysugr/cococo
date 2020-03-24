//
//  ConverterTests.swift
//  cococoKitTests
//
//  Created by Michael Heinzl on 14.01.20.
//  Copyright © 2020 mySugr GmbH. All rights reserved.
//

import XCTest
@testable import cococoLibrary

class ConverterTests: XCTestCase {

	var sut: Converter!
	
    override func setUp() {
		super.setUp()
		
		sut = Converter()
    }
	
	func testExample() throws {
        let result = try sut.convert([XCResultExamples.example], excludedFileExtensions: nil)
		let expectedResult = try String(contentsOf: XCResultExamples.exampleResult)
		XCTAssertEqual(result, expectedResult)
	}
	
	func testExcludeSingleFilePaths() {
		let filePaths = [
			"foo/bar/file1.swift",
			"asdf/foo.h",
			"asdf/foo.m",
			"asdf/bar.m",
			"file2.swift"
		]
		let excludedFileExtensions = [".swift"]
		let expectedPaths = [
			"asdf/foo.h",
			"asdf/foo.m",
			"asdf/bar.m"
		]
		let resultingPaths = sut.filterFilePaths(filePaths, excludedFileExtensions: excludedFileExtensions)
		XCTAssertEqual(resultingPaths, expectedPaths)
	}
	
	func testExcludeMultipleFilePaths() {
		let filePaths = [
			"foo/bar/file1.swift",
			"asdf/foo.h",
			"asdf/foo.m",
			"asdf/bar.m",
			"file2.swift"
		]
		let excludedFileExtensions = [".m", ".h"]
		let expectedPaths = [
			"foo/bar/file1.swift",
			"file2.swift",
		]
		let resultingPaths = sut.filterFilePaths(filePaths, excludedFileExtensions: excludedFileExtensions)
		XCTAssertEqual(resultingPaths, expectedPaths)
	}

}
