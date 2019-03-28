//
//  ViewController.swift
//  PracticeRxswift2
//
//  Created by daeun on 22/03/2019.
//  Copyright © 2019 daeun. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    @IBOutlet weak var idField: UITextField!
    @IBOutlet weak var pwField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var idValidView: UIView!
    @IBOutlet weak var pwValidView: UIView!
    
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        idField.rx.text
            .orEmpty
            .map(checkIdValid)
            .subscribe(onNext: { isId in
                self.idValidView.isHidden = isId
            }).disposed(by: disposeBag)
        
        pwField.rx.text
            .orEmpty
            .map(checkPwValid)
            .subscribe(onNext: { isPw in
                self.pwValidView.isHidden = isPw
            }).disposed(by: disposeBag)
        Observable.combineLatest(idField.rx.text.orEmpty.map(checkIdValid),
                                 pwField.rx.text.orEmpty.map(checkPwValid),
                                 resultSelector: { s1, s2 in s1 && s2})
            .subscribe(onNext:{ isEnableLogin in
                self.loginButton.isEnabled = isEnableLogin
            }).disposed(by: disposeBag)
    }
    
    func checkIdValid(_ email: String) -> Bool {
        return email.contains("@") && email.contains(".")
    }
    
    func checkPwValid(_ password: String) -> Bool {
        return password.count > 5
    }
}
