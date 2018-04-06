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
    var controlType: String
    var fieldType: String
}

extension CodablePDFForm: Equatable {
    static func == (lhs: CodablePDFForm, rhs: CodablePDFForm) -> Bool {
        return lhs.name == rhs.name &&
            lhs.value == rhs.value &&
            lhs.controlType == rhs.controlType &&
            lhs.fieldType == rhs.fieldType
    }
}

extension CodablePDFForm: Hashable {
    var hashValue: Int {
        return name.hashValue ^ value.hashValue ^ controlType.hashValue ^ fieldType.hashValue
    }
}
