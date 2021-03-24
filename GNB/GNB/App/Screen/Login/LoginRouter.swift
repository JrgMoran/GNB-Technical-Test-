//
//  LoginRoute.swift
//  GNB
//
//  Created by Jorge Morán on 05/09/2020.
//  Copyright © 2020 Jorge Morán. All rights reserved.
//

import Foundation

class LoginRouter: Router {
    
    @discardableResult
    override init() {
        super.init()
        let vc = LoginViewController()
        vc.viewModel = LoginViewModel(loginUseCase: injector.loginUseCase, router: self)
        navigate(to: vc, mode: .new)
    }
    
    func toMovements() {
        HomeRouter()
    }
    
}
