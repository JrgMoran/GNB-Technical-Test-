//
//  SplashViewModel.swift
//  GNB
//
//  Created by Jorge Morán on 10/3/21.
//  Copyright (c) 2021 Jorge Morán. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class SplashViewModel: ViewModel, ViewModelType {
    
    let router: SplashRouter
    
    struct Input {
        let trigger: Observable<Void>
    }
    
    struct Output { }
    
    // MARK: init
    init(router: SplashRouter) {
        self.router = router
        super.init(router: router)
    }
    
    // MARK: Binding
    func transform(input: Input) -> Output {
        input.trigger.delay(.seconds(2), scheduler: MainScheduler.instance).subscribe { [weak self] (_) in
            self?.router.navigateToHome()
        }.disposed(by: disposeBag)
        return Output()
    }
    
    // MARK: Logic
}

