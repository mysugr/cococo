//
//  XCResultExamples.swift
//  cococoKitTests
//
//  Created by Michael Heinzl on 14.01.20.
//  Copyright © 2020 mySugr GmbH. All rights reserved.
//

import Foundation

private class Token {}
let testBundle = Bundle(for: Token.self)

struct XCResultExamples {
	
	static let example = testBundle.path(forResource: "Example", ofType: "xcresult")!
	static let exampleResult = URL(fileURLWithPath: testBundle.path(forResource: "ExampleResult", ofType: "xml")!)
	
}
