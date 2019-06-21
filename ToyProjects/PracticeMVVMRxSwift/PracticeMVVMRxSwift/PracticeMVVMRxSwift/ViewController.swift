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
        
        //viewModel에서 받은 데이터를 tableview와 bind합니다
        viewModel.data
            .drive(tableView.rx.items(cellIdentifier: "siteCell", cellType: SiteCell.self)) { _, data, cell in
                cell.siteImageView.kf.setImage(with: URL(string: data.historicalSiteImagePath), options: [(.processor(BlurImageProcessor(blurRadius: 4))),.processor(ResizingImageProcessor(referenceSize: CGSize(width: 52, height: 16), mode: .aspectFill))])
                cell.siteNameLabel.text = data.historicalSiteName
                cell.siteAddressLabel.text = data.historicalSiteLocation
            }
            .disposed(by: disposeBag)
        
        //tableview item을 select하면 다음 VC로 이동합니다
        tableView.rx.itemSelected.subscribe { [weak self] indexPath in
            self?.performSegue(withIdentifier: "next", sender: nil)
        }.disposed(by: disposeBag)
        
        //tableview item을 select한 indexPath를 viewModel의 indexpath와 bind합니다
        tableView.rx.itemSelected.bind(to: viewModel.selectedImagePath).disposed(by: disposeBag)
    }
    
    //ViewController와 NextViewController는 같은 ViewModel을 공유합니다.
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
    
    func configure(data: Model) {
        siteNameLabel.text = data.historicalSiteName
    }
}
