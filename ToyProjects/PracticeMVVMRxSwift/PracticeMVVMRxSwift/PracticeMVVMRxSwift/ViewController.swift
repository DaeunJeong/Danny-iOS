//
//  ViewController.swift
//  PracticeMVVMRxSwift
//
//  Created by daeun on 19/04/2019.
//  Copyright © 2019 daeun. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Kingfisher

var viewModel: ViewModel!
let disposeBag = DisposeBag()

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = ViewModel()
        
        viewModel.data
            .drive(tableView.rx.items(cellIdentifier: "siteCell")) { _, data, cell in
                let siteCell = cell as? SiteCell
                siteCell?.siteImageView.kf.setImage(with: URL(string: data.historicalSiteImagePath))
                siteCell?.siteNameLabel.text = data.historicalSiteName
                siteCell?.siteAddressLabel.text = data.historicalSiteLocation
            }
            .disposed(by: disposeBag)
        
        tableView.rx.itemSelected.subscribe { [weak self] indexPath in
            self?.performSegue(withIdentifier: "next", sender: nil)
        }.disposed(by: disposeBag)
    }
}

class SiteCell: UITableViewCell {
    @IBOutlet weak var siteImageView: UIImageView!
    @IBOutlet weak var siteNameLabel: UILabel!
    @IBOutlet weak var siteAddressLabel: UILabel!
}
