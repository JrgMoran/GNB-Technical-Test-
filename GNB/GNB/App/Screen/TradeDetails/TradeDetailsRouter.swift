//
//  TradeDetailsRouter.swift
//  GNB
//
//  Created by Jorge Morán on 25/3/21.
//

import Foundation

class TradeDetailsRouter: Router {
    
    @discardableResult
    override init() {
        super.init()
        let viewController = TradeDetailsViewController()
        viewController.viewModel = TradeDetailsViewModel(router: self,
                                                         getTradeRates: injector.getTradesRatesUseCase)
        
        navigate(to: viewController, mode: .push)
    }
}

