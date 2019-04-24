//
//  ViewModel.swift
//  PracticeMVVMRxSwift
//
//  Created by daeun on 24/04/2019.
//  Copyright © 2019 daeun. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import RxAlamofire
import Alamofire

class ViewModel {
    let data: Driver<[Model]>

    init() {
        data = RxAlamofire.requestData(.get, "http://52.199.207.14/main/bla", parameters: nil, encoding: URLEncoding.queryString, headers: ["Content-Type" : "application/json"]).map { (_, data) -> [Model] in
            
            guard let model = try? JSONDecoder().decode([Model].self, from: data) else {
                return ([])
            }
            
            return model
        }.asDriver(onErrorJustReturn: [])
    }
}
