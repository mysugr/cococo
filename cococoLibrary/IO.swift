//
//  IO.swift
//  cococo
//
//  Created by Michael Heinzl on 10.01.20.
//  Copyright © 2020 mySugr GmbH. All rights reserved.
//

import Foundation

public class IO {
	
	public init() {}
	
	public enum OutputType {
		case error
		case standard
	}
	
	public func print(_ message: String, to: OutputType = .standard) {
		switch to {
		case .standard:
			Swift.print("\(message)")
		case .error:
			fputs("\(message)\n", stderr)
		}
	}
	
}
