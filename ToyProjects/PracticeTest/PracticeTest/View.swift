//
//  View.swift
//  PracticeTest
//
//  Created by daeun on 21/06/2019.
//  Copyright © 2019 daeun. All rights reserved.
//

import Foundation
import UIKit

let numLabel: UILabel = {
    let label = UILabel()
    label.text = "0"
    label.textColor = .black
    label.font = label.font.withSize(20)
    return label
} ()

let plusButton: UIButton = {
    let button = UIButton()
    button.setTitle("click!!", for: .normal)
    button.titleLabel?.font = button.titleLabel?.font.withSize(20)
    button.setTitleColor(.blue, for: .normal)
    return button
} ()

let resetButton: UIButton = {
    let button = UIButton()
    button.setTitle("reset", for: .normal)
    button.titleLabel?.font = button.titleLabel?.font.withSize(13)
    button.setTitleColor(.blue, for: .normal)
    return button
} ()
