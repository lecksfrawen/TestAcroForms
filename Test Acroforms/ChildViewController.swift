//
//  ChildViewController.swift
//  Test Acroforms
//
//  Created by Hector De Diego on 4/4/18.
//  Copyright © 2018 Lecksfrawen. All rights reserved.
//

import UIKit
import ILPDFKit


class ChildViewController: ILPDFViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Se muestran encimados los controles en la primera hoja.
        // HDB: Agregar PDF al proyecto y cambiar aquí el nombre:
        document = ILPDFDocument(resource: "NombrePDF")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    fileprivate func handleTextForm(form: ILPDFForm) -> CodablePDFForm {
        // TODO: Implement TextField validation here
        return form.toCodableObject()
    }
    
    fileprivate func handleRadioButtonForm(form: ILPDFForm) -> CodablePDFForm {
        // TODO: Implement RadioButton validation here
        return form.toCodableObject()
    }
    
    fileprivate func handleComboBoxForm(form: ILPDFForm) -> CodablePDFForm {
        // TODO: Implement ComboBox validation here
        return form.toCodableObject()
    }
    
    func readPDF() throws -> CodablePDFForms {
        guard let loadedDocument = document else {
            throw GlobalError.pdfFileNotLoaded
        }
        
        var forms: [CodablePDFForm] = []
        
        for singleForm in loadedDocument.forms {
            if let form = singleForm as? ILPDFForm {
                
                let codedForm: CodablePDFForm?
                
                switch form.formType {
                    
                // Handled
                case .text: codedForm = handleTextForm(form: form)
                case .button: codedForm = handleRadioButtonForm(form: form)
                case .choice: codedForm = handleComboBoxForm(form: form)
                    
                // Not handled
                default: codedForm = nil
                }
                
                if let handledCodedForm = codedForm {
                    forms.append(handledCodedForm)
                }
            }
        }
        
        let codedForms: CodablePDFForms = CodablePDFForms(forms: forms)
        return codedForms
    }


}

