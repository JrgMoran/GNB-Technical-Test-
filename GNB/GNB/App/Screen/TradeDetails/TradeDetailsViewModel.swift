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
    fileprivate let tradeSelected: TradeElement
    
    fileprivate var tradesRates: [TradeRate] = [] {
        didSet {
            self.tradesRates.completeTradesRates()
            
            let sameTrades = trades.filter({ $0.sku == tradeSelected.sku })
            var superSameTrades: TradeElement = TradeElement(sku: tradeSelected.sku, amount: "0", currency: tradeSelected.currency)
            
            sameTrades.forEach { (tradeElemnt) in
                if let amount = Double(tradeElemnt.amount),
                   let superAmount = Double(superSameTrades.amount){
                    superSameTrades = TradeElement(sku: tradeSelected.sku, amount: String(amount + superAmount), currency: tradeSelected.currency)
                }
            }
            allSameTrades.accept(superSameTrades)
            tradesInAllCurrencies.accept(tradesRates.allCurrencies(of: tradeSelected)?.map({$0.formatedValue}).filter({$0 != nil}) as! [String])
        }
    }
    
    
    fileprivate lazy var allSameTrades: BehaviorRelay<TradeElement> =  BehaviorRelay.init(value: tradeSelected)
    fileprivate lazy var tradesInAllCurrencies: BehaviorRelay<[String]> =  BehaviorRelay.init(value: [])
    
    struct Input {
        let trigger: Observable<Void>
    }
    
    struct Output {
        let sku: Observable<String>
        let amount: Observable<String>
        let totalTradeEuro: Observable<String>
        let tradesInAllCurrencies: Observable<[String]>
    }
    
    // MARK: init & deinit
    init(router: TradeDetailsRouter, getTradeRates: GetTradesRatesUseCase,
         trades: [TradeElement], tradeSelected: TradeElement) {
        self.router = router
        self.getTradeRates = getTradeRates
        self.trades = trades
        self.tradeSelected = tradeSelected
        super.init(router: router)
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
        
        let totalTradeEuro = allSameTrades.asObservable().map {[weak self] (trade) -> String in
            if let weakSelf = self {
                let eurTotal = weakSelf.tradesRates.tradeCurrency("EUR", of: weakSelf.allSameTrades.value)
                return "\(R.text.totalInEur) \(eurTotal.formatedValue ?? "")"
            }
            return ""
        }
        
        return Output(sku: Observable.just(tradeSelected.sku),
                      amount: Observable.just(Amount(from: tradeSelected).formatedValue ?? ""),
                      totalTradeEuro: totalTradeEuro,
                      tradesInAllCurrencies: tradesInAllCurrencies.asObservable())
    }
    
    // MARK: Logic

}

