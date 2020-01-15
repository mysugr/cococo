//
//  XMLEscaperExamples.swift
//  cococoKitTests
//
//  Created by Michael Heinzl on 14.01.20.
//  Copyright © 2020 mySugr GmbH. All rights reserved.
//

import Foundation

struct XMLEscaperExamples {
	
	static let longExample = """
	<employees>
	<employee>
	<id>1</id>
	<photo>http://1.bp.foobar.com/-zvS_6Q1IzR8/T5l6qvnRmcI/AAAAAAAABcc/HXO7HDEJKo0/</photo>
	</employee>
	<employee>
	<id>2</id>
	<firstName>John</firstName>
	<lastName>Doe</lastName>
	<photo>http://4.bp.foobar.com/_xR71w9-qx9E/SrAz--pu0MI/AAAAAAAAC38/2ZP28rVEFKc/s200/</photo>
	</employee>
	<employee>
	<id>3</id>
	<photo>http://asdf.com/files/234234.jpg</photo>
	</employee>
	</employees>
	"""
	
	static let longEscapedExample = """
	&lt;employees&gt;
	&lt;employee&gt;
	&lt;id&gt;1&lt;/id&gt;
	&lt;photo&gt;http://1.bp.foobar.com/-zvS_6Q1IzR8/T5l6qvnRmcI/AAAAAAAABcc/HXO7HDEJKo0/&lt;/photo&gt;
	&lt;/employee&gt;
	&lt;employee&gt;
	&lt;id&gt;2&lt;/id&gt;
	&lt;firstName&gt;John&lt;/firstName&gt;
	&lt;lastName&gt;Doe&lt;/lastName&gt;
	&lt;photo&gt;http://4.bp.foobar.com/_xR71w9-qx9E/SrAz--pu0MI/AAAAAAAAC38/2ZP28rVEFKc/s200/&lt;/photo&gt;
	&lt;/employee&gt;
	&lt;employee&gt;
	&lt;id&gt;3&lt;/id&gt;
	&lt;photo&gt;http://asdf.com/files/234234.jpg&lt;/photo&gt;
	&lt;/employee&gt;
	&lt;/employees&gt;
	"""
	
}
