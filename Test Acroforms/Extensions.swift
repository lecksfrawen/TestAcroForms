//
//  Extensions.swift
//  Test Acroforms
//
//  Created by Hector De Diego on 4/4/18.
//  Copyright © 2018 Lecksfrawen. All rights reserved.
//

import Foundation
import UIKit
import PDFKit

extension String {
    // To ISO88591
    func encodeFromUTF8ToLatin() -> String {
        if let utfData = self.data(using: String.Encoding.utf8) {
            if let utf = String(data: utfData, encoding: String.Encoding.isoLatin1) {
                return utf
            }
        }
        return self
    }
    
    // From ISO88591
    func decodeFromLatinToUTF8() -> String {
        if let utfData = self.data(using: String.Encoding.isoLatin1) {
            if let utf = String(data: utfData, encoding: String.Encoding.utf8) {
                return utf
            }
        }
        return self
    }
    
    // Why do I even have to do this... just boggles my mind, but it works.
    func hardcoreNonsensicalDecoding() -> String {
        return self
            .decodeFromLatinToUTF8()
            .decodeFromLatinToUTF8()
            .decodeFromLatinToUTF8()
            .decodeFromLatinToUTF8()
            .decodeFromLatinToUTF8()
    }
}
extension PDFWidgetControlType {
    func pretty() -> String {
        switch self {
        case .unknownControl: return "unknownControl"
        case .pushButtonControl: return "pushButtonControl"
        case .radioButtonControl: return "radioButtonControl"
        case .checkBoxControl: return "checkBoxControl"
        }
    }
}

extension PDFAnnotationWidgetSubtype {
    func pretty() -> String {
        switch self.rawValue {
        case "/Btn": return "button"
        case "/Ch": return "choice"
        case "/Tx": return "text"
        default: return "unknown"
        }
    }
}

extension PDFAnnotation {
    
    func toCodableObject() -> CodablePDFForm {
        
        self.widgetStringValue = self.widgetStringValue?.hardcoreNonsensicalDecoding() ?? ""
        
        return CodablePDFForm(
            name: self.fieldName ?? "no fieldName",
            value: self.widgetStringValue ?? "no widget string value",
            controlType: self.widgetControlType.pretty(),
            fieldType: self.widgetFieldType.pretty()
        )
    }
    
    func pretty() {
        var o = ""
        o += "# Printing annotation data:\n"
        
        o += "\n## Important Data:\n"
        o += "\tPDFAnnotation.widgetFieldType: \(self.widgetFieldType.rawValue )\n"
        o += "\tPDFAnnotation.fieldName: \(self.fieldName ?? "no fieldName")\n"
        o += "\tPDFAnnotation.widgetStringValue: \(self.widgetStringValue ?? "no widget string value")\n"
        o += "\tPDFAnnotation.widgetControlType: \(self.widgetControlType.pretty())\n"
        o += "\tPDFAnnotation.caption: \(self.caption ?? "no caption")\n"
        
//        o += "\n## Other Data:\n"
//        o += "\tPDFAnnotation.type: \(self.type ?? "no type")\n"
//        o += "\tPDFAnnotation.widgetDefaultStringValue: \(self.widgetDefaultStringValue ?? "no default string value for widget")\n"

//        o += "\tPDFAnnotation.contents: \(self.contents ?? "no contents")\n"
//        o += "\tPDFAnnotation.isListChoice: \(self.isListChoice)\n"
//        o += "\tPDFAnnotation.isOpen: \(self.isOpen)\n"
//        o += "\tPDFAnnotation.isReadOnly: \(self.isReadOnly)\n"
//        o += "\tPDFAnnotation.isMultiline: \(self.isMultiline)\n"
        
        var choiceNumber = 0
        for choice in self.choices ?? [] {
            o += "\tPDFAnnotation.choices.choice[\(choiceNumber)]: \(choice)\n"
            choiceNumber = choiceNumber + 1
        }
        
        var valueNumber = 0
        for value in self.values ?? [] {
            o += "\tPDFAnnotation.values.value[\(valueNumber)]: \(value)\n"
            valueNumber = valueNumber + 1
        }
        print(o)
    }
}
