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
                siteCell?.siteImageView.kf.setImage(with: URL(string: data.historicalSiteImagePath), options: [(.processor(BlurImageProcessor(blurRadius: 4))),.processor(ResizingImageProcessor(referenceSize: CGSize(width: 52, height: 16), mode: .aspectFill))])
                siteCell?.siteNameLabel.text = data.historicalSiteName
                siteCell?.siteAddressLabel.text = data.historicalSiteLocation
            }
            .disposed(by: disposeBag)
        
        tableView.rx.itemSelected.subscribe { [weak self] indexPath in
            self?.performSegue(withIdentifier: "next", sender: nil)
        }.disposed(by: disposeBag)
        
        tableView.rx.itemSelected.bind(to: viewModel.selectedImagePath).disposed(by: disposeBag)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "next" {
            let nextVC = segue.destination as? NextViewController
            nextVC?.viewModel = viewModel
        }
    }
}

class SiteCell: UITableViewCell {
    @IBOutlet weak var siteImageView: UIImageView!
    @IBOutlet weak var siteNameLabel: UILabel!
    @IBOutlet weak var siteAddressLabel: UILabel!
}
