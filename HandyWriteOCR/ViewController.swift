//
//  ViewController.swift
//  HandyWriteOCR
//
//  Created by MekeFactory on 2019/06/12.
//  Copyright © 2019 MekeFactory. All rights reserved.
//

import UIKit
import ACEDrawingView
import SwiftyTesseract

class ViewController: UIViewController {
    @IBOutlet weak var drawingView: ACEDrawingView!
    @IBOutlet weak var label: UILabel!
    
    let swiftyTesseract = SwiftyTesseract(language: .english)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        drawingView.delegate = self
        drawingView.lineWidth = 5
        
    }
    
    @IBAction func onClearButton(_ sender: Any) {
        drawingView.clear()
        self.label.text = ""
    }
}

extension ViewController: ACEDrawingViewDelegate {
    func drawingView(_ view: ACEDrawingView!, didEndDrawUsing tool: ACEDrawingTool!) {
        swiftyTesseract.performOCR(on: view.image) { recognizedString in
            guard let text = recognizedString else { return }
            self.label.text = text
        }
    }
}
