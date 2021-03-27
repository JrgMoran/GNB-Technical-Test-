//
//  TradeDetailsViewModel.swift
//  GNB
//
//  Created by Jorge Morán on 25/3/21.
//  Copyright (c) 2021 Jorge Morán. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class TradeDetailsViewModel: ViewModel, ViewModelType {
    
    let router: TradeDetailsRouter
    fileprivate let getTradeRates: GetTradesRatesUseCase
    
    fileprivate let trades: [TradeElement]
    fileprivate var sameTrades: [TradeElement] = []
    fileprivate let tradeSelected: TradeElement
    fileprivate var tradesRates: [TradeRate] = [] {
        didSet {
            self.tradesRates.completeTradesRates()
        }
    }
    
    struct Input {
        let trigger: Observable<Void>
    }
    
    struct Output { }
    
    // MARK: init & deinit
    init(router: TradeDetailsRouter, getTradeRates: GetTradesRatesUseCase,
         trades: [TradeElement], tradeSelected: TradeElement) {
        self.router = router
        self.getTradeRates = getTradeRates
        self.trades = trades
        self.tradeSelected = tradeSelected
        super.init(router: router)
        getSameTrades()
    }
    
    // MARK: Binding
    func transform(input: Input) -> Output {
        input.trigger.subscribe { [weak self](_) in
            guard let weakSelf = self else { return }
            weakSelf.showLoading()
            weakSelf.getTradeRates().subscribe(onSuccess: { (tradesRates) in
                weakSelf.tradesRates = tradesRates
                weakSelf.hideLoading()
            }, onError: { (error) in
                weakSelf.process(error: error)
            }).disposed(by: weakSelf.disposeBag)
            
        }.disposed(by: disposeBag)
        
        return Output()
    }
    
    // MARK: Logic
    private func getSameTrades() {
        sameTrades = trades.filter({ $0.sku == tradeSelected.sku })
    }
}

