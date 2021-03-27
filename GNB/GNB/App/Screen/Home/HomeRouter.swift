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
                                                 getTrades: injector.getTradesUseCase)
        navigate(to: viewController, mode: .new)
    }
    
    func navigateToTrade(trades: [TradeElement], tradeSelected: TradeElement){
        TradeDetailsRouter(trades: trades, tradeSelected: tradeSelected)
    }
}

