//
//  XMLEscaperTests.swift
//  cococoKitTests
//
//  Created by Michael Heinzl on 14.01.20.
//  Copyright © 2020 mySugr GmbH. All rights reserved.
//

import XCTest
@testable import cococoLibrary

class XMLEscaperTests: XCTestCase {

	var sut: XMLEscaper!
	
    override func setUp() {
		super.setUp()
		
		sut = XMLEscaper()
    }
	
    func testSingleReplacments() {
		XCTAssertEqual(sut.escape("&"), "&amp;")
		XCTAssertEqual(sut.escape("'"), "&apos;")
		XCTAssertEqual(sut.escape("\""), "&quot;")
		XCTAssertEqual(sut.escape("<"), "&lt;")
		XCTAssertEqual(sut.escape(">"), "&gt;")
    }
	
	func testLongExampleText() {
		XCTAssertEqual(sut.escape(XMLEscaperExamples.longExample), XMLEscaperExamples.longEscapedExample)
	}

}
