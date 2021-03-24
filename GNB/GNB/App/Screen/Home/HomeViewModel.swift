//
//  HomeViewModel.swift
//  GNB
//
//  Created by Jorge Morán on 11/3/21.
//  Copyright (c) 2021 Jorge Morán. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class HomeViewModel: ViewModel, ViewModelType {
    
    let router: HomeRouter
    fileprivate let getTradeRates: GetTradesRatesUseCase
    fileprivate let getTrades: GetTradesUseCase
    
    fileprivate var trades: [TradeElement]? {
        didSet{
            print(trades?.count)
        }
    }
    
    struct Input {
        let trigger: Observable<Void>
    }
    
    struct Output { }
    
    // MARK: init & deinit
    init(router: HomeRouter,
         getTradeRates: GetTradesRatesUseCase, getTrades: GetTradesUseCase) {
        self.router = router
        self.getTradeRates = getTradeRates
        self.getTrades = getTrades
        super.init(router: router)
    }
    
    // MARK: Binding
    func transform(input: Input) -> Output {
        input.trigger.subscribe { [weak self](_) in
            guard let disposeBag = self?.disposeBag else { return }
            
            self?.getTradeRates().subscribe(onSuccess: { (tradesRates) in
                // TODO:
            }, onError: { (error) in
                self?.process(error: error)
            }).disposed(by: disposeBag)
            
            self?.getTrades().subscribe(onSuccess: { (trades) in
                // TODO:
            }, onError: { (error) in
                self?.process(error: error)
            }).disposed(by: disposeBag)
            
        }.disposed(by: disposeBag)
        return Output()
    }
    
    // MARK: Logic
}

