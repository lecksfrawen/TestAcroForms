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

struct CodablePDFForm: Codable, Hashable {
    var name: String
    var value: String
    var controlType: String
    var fieldType: String
}
