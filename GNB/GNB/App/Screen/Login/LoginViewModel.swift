//
//  LoginViewModel.swift
//  GNB
//
//  Created by Jorge Morán on 05/09/2020.
//  Copyright © 2020 Jorge Morán. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class LoginViewModel: ViewModel, ViewModelType {
    
    struct Input {
        let trigger: Observable<Void>
        let doLogin: Driver<Void>
        let doRegister: Driver<Void>
    }
    
    struct Output {
        let loginEnabled: Driver<Bool>
    }
    
    let user = BehaviorRelay(value: "")
    let password = BehaviorRelay(value: "")
    let rememberPassword: BehaviorRelay<Bool> = BehaviorRelay(value: false)
    
    let loginUseCase: LoginUseCase
    let router: LoginRouter
    
    init(loginUseCase: LoginUseCase, router: LoginRouter) {
        self.loginUseCase = loginUseCase
        self.router = router
        super.init(router: router)
    }
    
    func transform(input: LoginViewModel.Input) -> LoginViewModel.Output {
        input.doLogin.drive(onNext: { [weak self] () in
            if let weakSelf = self, !weakSelf.user.value.isEmpty, !weakSelf.password.value.isEmpty {
                
                weakSelf.showLoading()
                weakSelf.loginUseCase(user: weakSelf.user.value,
                                      pass: weakSelf.password.value,
                                      saveUser: weakSelf.rememberPassword.value).subscribe(onSuccess: { session in
                                        weakSelf.router.toMovements()
                                              }) { (error) in
                                        weakSelf.process(error: error)
                }.disposed(by: weakSelf.disposeBag)
                
            }
        }).disposed(by: disposeBag)
        
        let loginEnabled: Driver<Bool> = BehaviorRelay.combineLatest(user, password) {
            return !$0.isEmpty && !$1.isEmpty
        }.asDriver(onErrorJustReturn: false)
        
        return Output(loginEnabled: loginEnabled)
    }
}
