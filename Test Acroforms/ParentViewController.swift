//
//  ParentViewController.swif
//  Test Acroforms
//
//  Created by Hector De Diego on 4/4/18.
//  Copyright © 2018 Lecksfrawen. All rights reserved.
//

import UIKit
import PDFKit

class ParentViewController: UIViewController {
    
    @IBOutlet weak var pdfView: PDFView!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        loadPDF()
    }
    
    fileprivate func loadPDF() {
        if let path = Bundle.main.path(forResource: "PruebaAsesoramientoAdobe", ofType: "pdf") {
            let url = URL(fileURLWithPath: path)
            if let pdfDocument = PDFDocument(url: url) {
                pdfView.displayMode = .singlePageContinuous
                pdfView.autoScales = true
                pdfView.document = pdfDocument
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    fileprivate func getFormsFromSinglePage(_ pdfDocument: PDFDocument, _ pageIndex: Int) -> [CodablePDFForm] {
        var singlePageData: [CodablePDFForm] = []
        if let page = pdfDocument.page(at: pageIndex) {
            let annotations = page.annotations
            for anAnnotation in annotations {
                singlePageData.append(anAnnotation.toCodableObject())
            }
        }
        return singlePageData
    }
    
    fileprivate func printJSONFromAnnotations(_ pdfDocument: PDFDocument) {
        let pageCount = pdfDocument.pageCount
        
        var pageIndex = 0
        
        // Should be careful not to name multiple fields with the same name, since I'm using a set instead of an array.
        var allPagesData: Set<CodablePDFForm> = Set.init()
        repeat {
            print("Obteniendo datos de página no. \(pageIndex)")
            let singlePageData = getFormsFromSinglePage(pdfDocument, pageIndex)
            allPagesData = allPagesData.union(singlePageData)
            pageIndex = pageIndex + 1
        } while pageIndex < pageCount
        
        let allPagesCodableObject: CodablePDFForms = CodablePDFForms(forms: Array(allPagesData))
        
        do {
            let encoder = JSONEncoder()
            let jsonData = try encoder.encode(allPagesCodableObject)
            let plainTextJSON = String(data: jsonData, encoding: .utf8)
            print(plainTextJSON ?? "... where is my data")
            
        } catch {
            dump(error)
        }
    }
    
    @IBAction func readPDFDataAction(_ sender: UIButton) {
        
        guard let pdfDocument = pdfView.document else {
            print("Where is my pdfDocument!??!")
            return
        }
        
        printJSONFromAnnotations(pdfDocument)
    }
    
}
