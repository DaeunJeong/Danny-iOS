//
//  ViewController.swift
//  PracticeTest
//
//  Created by daeun on 21/06/2019.
//  Copyright © 2019 daeun. All rights reserved.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    var num: Int = 0
    let _numLabel = numLabel
    let _plusButton = plusButton
    let _resetButton = resetButton
    
    func setUpViews() {
        self.view.addSubview(_numLabel)
        self.view.addSubview(_plusButton)
        self.view.addSubview(_resetButton)
        
        _plusButton.snp.makeConstraints { make in
            make.center.equalTo(self.view)
        }
        _plusButton.addTarget(self, action: #selector(clickPlusButton), for: .touchUpInside)
        
        _numLabel.snp.makeConstraints { make in
            make.bottom.equalTo(_plusButton.snp.top).offset(4)
            make.centerX.equalTo(self.view)
        }
        
        _resetButton.snp.makeConstraints { make in
            make.top.equalTo(_plusButton.snp.bottom).offset(4)
            make.centerX.equalTo(self.view)
        }
        _resetButton.addTarget(self, action: #selector(clickResetButton), for: .touchUpInside)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        setUpViews()
    }

    @objc func clickPlusButton(sender: UIButton!) {
        num += 1
        _numLabel.text = "\(num)"
    }
    
    @objc func clickResetButton(sender: UIButton!) {
        num = 0
        _numLabel.text = "\(num)"
    }
}
