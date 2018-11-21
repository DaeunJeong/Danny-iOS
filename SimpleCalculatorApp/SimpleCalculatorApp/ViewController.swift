//
//  ViewController.swift
//  SimpleCalculatorApp
//
//  Created by daeun on 20/11/2018.
//  Copyright © 2018 daeun. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var resultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    var isTypingNumber = false
    var isPlus = false
    var isMinus = false
    
    var sum: Int = 0
    var num: Int = 0
    
    @IBAction func numberClick(_ numberBtn: UIButton) {
        var number = numberBtn.titleLabel?.text
        if isTypingNumber {
            resultLabel.text = resultLabel.text! + number!
        } else {
            resultLabel.text = number!
            isTypingNumber = true
        }
    }
    
    @IBAction func calculatePlus(_ sender: UIButton) {
        if !isPlus {
            sum = Int((resultLabel?.text)!)! + sum
            isTypingNumber = false
            isPlus = true
        }
    }
    
    @IBAction func calculateMinus(_ sender: UIButton) {
        if !isMinus {
            sum = Int((resultLabel?.text)!)! - sum
            isTypingNumber = false
            isMinus = true
        }
    }
    
    @IBAction func showResult(_ sender: UIButton) {
        if isPlus {
            sum = sum + (Int(resultLabel.text!)!)
            isPlus = false
        } else if isMinus {
            sum = sum - (Int(resultLabel.text!)!)
            isMinus = false
        } else {
            sum = Int(resultLabel.text!)!
        }
        resultLabel.text = String(sum)
        sum = 0
        isTypingNumber = false
    }
    
    @IBAction func clear(_ sender: UIButton) {
        sum = 0
        num = 0
        resultLabel.text = ""
        isTypingNumber = false
        isMinus = false
        isPlus = false
        
    }
    
    @IBAction func deleteNumber(_ sender: UIButton) {
        resultLabel.text = String((resultLabel.text?.dropLast())!)
    }
    

}

