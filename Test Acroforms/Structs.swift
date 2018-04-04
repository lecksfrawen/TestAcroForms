//
//  Structs.swift
//  Test Acroforms
//
//  Created by Hector De Diego on 4/4/18.
//  Copyright © 2018 Lecksfrawen. All rights reserved.
//

import Foundation
import UIKit


struct CodablePDFForms: Codable {
    var forms: [CodablePDFForm]
}

struct CodablePDFForm: Codable {
    var name: String
    var value: String
    var uname: String
    var form_type: String
}
