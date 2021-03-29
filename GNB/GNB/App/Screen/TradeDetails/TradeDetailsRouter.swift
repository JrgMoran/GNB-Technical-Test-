//
//  TradeDetailsRouter.swift
//  GNB
//
//  Created by Jorge Morán on 25/3/21.
//

import Foundation

class TradeDetailsRouter: Router {
    
    @discardableResult
    init(trades: [TradeElement], tradeSelected: TradeElement) {
        super.init()
        let viewController = TradeDetailsViewController()
        viewController.viewModel = injector.container.resolve(TradeDetailsViewModel.self, arguments: self,trades,tradeSelected)
        
        navigate(to: viewController, mode: .push)
    }
}

