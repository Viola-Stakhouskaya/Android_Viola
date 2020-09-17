//
//  ViewController.swift
//  Calculator
//
//  Created by Viola on 9/17/20.
//  Copyright © 2020 Viola Stakhouskaya. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    var processor: Processor! {
        
        didSet {
            
            textField.text = processor.exitString
        }
    }
    
    @IBOutlet weak var textField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        processor = Processor()
    }

    @IBAction func digitTabbed(_ sender: UIButton) {
        processor.appendDigit(sender.currentTitle!) // передаем цифру, которая написана на кнопке, ! что цифра написана на кнопке
    }
    
    @IBAction func pointTabbed(_ sender: UIButton) {
        processor.appendPoint()
    }
    @IBAction func operatorTabbed(_ sender: UIButton) {
        if let processorOperator = ProcessorOperator(rawValue: sender.currentTitle!) {
            processor.appendOperator(processorOperator)
        }
    }
    @IBAction func leftBracketTabbed(_ sender: UIButton) {
        processor.addLeftBracket()
    }
    @IBAction func rightBracketTabbed(_ sender: UIButton) {
        processor.addRightBracket()
    }
    @IBAction func backspaceOneSymbol(_ sender: UIButton) {
        processor.backspace()
    }
    @IBAction func clearAllSymbols(_ sender: UIButton) {
        processor.clearAll()
    }
    @IBAction func equalsAllSum(_ sender: UIButton) {
        processor.calculateResult()
    }
}

