//
//  NextViewController.swift
//  PracticeMVVMRxSwift
//
//  Created by daeun on 26/04/2019.
//  Copyright © 2019 daeun. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class NextViewController: UIViewController {
    
    @IBOutlet weak var siteNameLabel: UILabel!
    var viewModel = ViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.selectedSiteName.bind(to: siteNameLabel.rx.text).disposed(by: disposeBag
        )
    }
}
