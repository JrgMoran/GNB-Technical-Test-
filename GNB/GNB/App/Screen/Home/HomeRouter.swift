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
        viewController.viewModel = injector.container.resolve(HomeViewModel.self, argument: self)
        navigate(to: viewController, mode: .new)
    }
    
    func navigateToTrade(trades: [TradeElement], tradeSelected: TradeElement){
        TradeDetailsRouter(trades: trades, tradeSelected: tradeSelected)
    }
}

