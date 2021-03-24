//
//  SplashRouter.swift
//  GNB
//
//  Created by Jorge Morán on 10/3/21.
//

import Foundation

class SplashRouter: Router {
    
    @discardableResult
    override init() {
        super.init()
    }
    
    func navigateToLogin() {
        LoginRouter()
    }
}

