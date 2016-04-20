//
//  ViewController.swift
//  Calculator
//
//  Created by Pavel Zayko on 20.04.16.
//  Copyright © 2016 Pavel Zayko. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var displayResultLabel: UILabel!
    
    var stillTyping = false
    var firstOperand : Double = 0
    var secondOperand : Double = 0
    var operationSign : String = ""
    var dotIsPlased = false
    
    var currentInput : Double {
        get {
            return Double(displayResultLabel.text!)!
        }
        
        set {
            let value = "\(newValue)"
            let valueArray =  value.componentsSeparatedByString(".")
            if valueArray[1] == "0" {
                displayResultLabel.text = "\(valueArray[0])"
            } else {
                displayResultLabel.text = "\(newValue)"
            }
            
            displayResultLabel.text = "\(newValue)"
            stillTyping = false
        }
    }

    @IBAction func numberPressed(sender: UIButton) {
        
        let number = sender.currentTitle!
        
        if stillTyping {
            if displayResultLabel.text?.characters.count < 20 {
                displayResultLabel.text = displayResultLabel.text! + number
            }
        } else {
            displayResultLabel.text = number
            stillTyping = true
        }
    }
    @IBAction func twoOperandsSingPressed(sender: UIButton) {
        operationSign = sender.currentTitle!
        firstOperand = currentInput
        stillTyping = false
        dotIsPlased = false
    }
    
    func operateWithTwoOperands(operation: (Double, Double) -> Double) {
        currentInput = operation(firstOperand, secondOperand)
        stillTyping = false
        dotIsPlased = false
    }
    
    @IBAction func equalitySignPressed(sender: UIButton) {
        
        if stillTyping {
            secondOperand = currentInput
        }
        
        dotIsPlased = false
        
        switch operationSign {
            case "+":
                operateWithTwoOperands{$0 + $1}
            case "-":
                operateWithTwoOperands{$0 - $1}
            case "×":
                operateWithTwoOperands{$0 * $1}
            case "÷":
                operateWithTwoOperands{$0 / $1}
            default: break
        }
        
    }
    
    @IBAction func clearButtonPressed(sender: AnyObject) {
        firstOperand = 0
        secondOperand = 0
        currentInput = 0
        displayResultLabel.text = "0"
        stillTyping = false
        dotIsPlased = false
        operationSign = ""
    }

    @IBAction func plusMinusButtonPressed(sender: UIButton) {
        currentInput = -currentInput
    }
    
    @IBAction func persentageButtonPressed(sender: UIButton) {
        if firstOperand == 0 {
            currentInput = currentInput / 100
        } else {
            secondOperand = firstOperand * currentInput / 100
        }
    }
    
    @IBAction func squareButtonPressed(sender: UIButton) {
        currentInput = sqrt(currentInput)
    }
    
    @IBAction func dotButtonPressed(sender: UIButton) {
        if stillTyping && !dotIsPlased {
            displayResultLabel.text = displayResultLabel.text! + "."
            dotIsPlased = true
        } else if !stillTyping && !dotIsPlased {
            displayResultLabel.text = "0."
        }
    }
    
}

