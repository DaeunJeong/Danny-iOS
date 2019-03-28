//
//  ViewController.swift
//  HelloWorldApp
//
//  Created by daeun on 29/10/2018.
//  Copyright © 2018 daeun. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var lblHelloText: UILabel!
    @IBOutlet weak var textName: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func buttonOk(_ sender: UIButton) {
        lblHelloText.text = "Hello, \(textName.text!)"
    }
}
