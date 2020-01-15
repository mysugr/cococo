//
//  BashTests.swift
//  cococoLibraryTests
//
//  Created by Michael Heinzl on 14.01.20.
//  Copyright © 2020 mySugr GmbH. All rights reserved.
//

import XCTest
@testable import cococoLibrary

class BashTests: XCTestCase {

	var sut: Bash!
	
    override func setUp() {
		super.setUp()
		
		sut = Bash()
    }
	
	func testSimpleCommand() throws {
		let output = try sut.execute(commandName: "echo", arguments: ["asdf"])
		XCTAssertEqual(output.trimmingCharacters(in: .whitespacesAndNewlines), "asdf")
	}
	
	func testUnkownCommand() {
		XCTAssertThrowsError(try sut.execute(commandName: "fooBarUnkownCommand")) { (error) in
			XCTAssertEqual(error as! Bash.Error, Bash.Error.failed(terminationStatus: 1))
        }
	}

}
