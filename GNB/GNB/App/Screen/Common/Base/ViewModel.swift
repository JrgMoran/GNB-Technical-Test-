//
//  ViewModel.swift
//  GNB
//
//  Created by Jorge Morán on 04/08/2020.
//  Copyright © 2020 Jorge Morán. All rights reserved.
//

import Foundation
import RxSwift
import ProgressHUD

protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}

class ViewModel {
    var disposeBag: DisposeBag = DisposeBag()
    
    fileprivate var router: Router?
    
    init(router: Router?){
        self.router = router
    }
    
    deinit {
        print("- deinit: \(self)")
    }
    
    func process(error: Error?) {
        hideLoading()
        guard let errorUnw = error else { return }
        let error = errorUnw as? AppError ?? AppError.unknown(message:nil)
        
        switch error {
        case .unautorized:
            // TODO
            break;
        case .notFound:
            // TODO
            break;
        case .serverError(message: let message):
            // TODO
            break;
        case .unknown(message: let message):
            // TODO
            break;
        case .badJson:
            // TODO
            break;
        case .badArrayJson:
            // TODO
            break;
        case .noSelf:
            // TODO
            break;
        case .other(error: let error):
            // TODO
            break;
        }
        // TODO: presentar error
        
    }
    
    func showLoading(){
        ProgressHUD.show()
    }
    
    func hideLoading() {
        ProgressHUD.dismiss()
    }
    
    func showAlert(){
        // TODO:
    }
}

