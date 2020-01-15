//
//  XMLEscaper.swift
//  cococoKit
//
//  Created by Michael Heinzl on 14.01.20.
//  Copyright © 2020 mySugr GmbH. All rights reserved.
//

import Foundation

/// Escapes text for XML
internal class XMLEscaper {

	internal init() {}
	
	/// Escapes string by replacing illegal characters
	func escape(_ string: String) -> String {
		var result = string
		result = result.replacingOccurrences(of:"&", with: "&amp;")
		result = result.replacingOccurrences(of:"'", with: "&apos;")
		result = result.replacingOccurrences(of:"\"", with: "&quot;")
		result = result.replacingOccurrences(of:"<", with: "&lt;")
		result = result.replacingOccurrences(of:">", with: "&gt;")
		return result
	}
	
}
