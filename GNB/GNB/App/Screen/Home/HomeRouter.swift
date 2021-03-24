//
//  HomeRouter.swift
//  GNB
//
//  Created by Jorge Morán
//

import Foundation

class HomeRouter: Router {
    
    @discardableResult
    override init() {
        super.init()
        let viewController = HomeViewController()
        viewController.viewModel = HomeViewModel(router: self,
                                                 getTradeRates: injector.getTradesRatesUseCase,
                                                 getTrades: injector.getTradesUseCase)
        navigate(to: viewController, mode: .new)
    }
}

