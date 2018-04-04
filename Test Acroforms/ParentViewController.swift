//
//  ParentViewController.swif
//  Test Acroforms
//
//  Created by Hector De Diego on 4/4/18.
//  Copyright © 2018 Lecksfrawen. All rights reserved.
//

import UIKit

class ParentViewController: UIViewController {
    
    var pdfVC: ChildViewController?
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let containedVC = segue.destination as? ChildViewController {
            pdfVC = containedVC
        }
    }
    
    @IBAction func readPDFDataAction(_ sender: UIButton) {
        guard let thePdfVC = pdfVC else {
            print("The contained PDF VC is not loaded")
            return
        }
        
        do {
            let result = try thePdfVC.readPDF()
            dump(result)
            let encoder = JSONEncoder()
            let jsonData = try encoder.encode(result)
            print("💣")
            dump(jsonData)
            let plainTextJSON = String(data: jsonData, encoding: .utf8)
            print(plainTextJSON ?? "... where is my data")
            
        } catch let error as GlobalError {
            switch error {
            case .pdfFileNotLoaded: print("PDF File is not loaded")
            }
        } catch {
            dump(error)
        }
    }
    
}
