//
//  Extensions.swift
//  Test Acroforms
//
//  Created by Hector De Diego on 4/4/18.
//  Copyright © 2018 Lecksfrawen. All rights reserved.
//

import Foundation
import UIKit
import ILPDFKit

extension String {
    func encodeToISO88591() -> String {
        if let utfData = self.data(using: String.Encoding.utf8) {
            if let utf = String(data: utfData, encoding: String.Encoding.isoLatin1) {
                return utf
            }
        }
        return self
    }
    
    func decodeISO88591() -> String {
        if let utfData = self.data(using: String.Encoding.isoLatin1) {
            if let utf = String(data: utfData, encoding: String.Encoding.utf8) {
                return utf
            }
        }
        return self
    }
}


extension ILPDFFormContainer: Sequence {
    public func makeIterator() -> NSFastEnumerationIterator {
        return NSFastEnumerationIterator(self as NSFastEnumeration)
    }
}

extension ILPDFForm {
    func toCodableObject() -> CodablePDFForm {
        let newValue = self.value?.decodeISO88591() ?? "n/a"
        return CodablePDFForm(
            name: self.name,
            value: newValue,
            uname: self.uname ?? "n/a",
            form_type: formType.toString()
        )
    }
}

extension ILPDFFormType {
    func toString() -> String {
        let stringValue: String!
        switch self {
        case .none: stringValue = "none"
        case .text: stringValue = "textField"
        case .button: stringValue = "radioButton"
        case .choice: stringValue = "comboBox"
        case .signature: stringValue = "signature"
        case .numberOfFormTypes: stringValue = "numberOfFormTypes"
        }
        return stringValue
    }
}
