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
    
    struct Input {
        let trigger: Observable<Void>
    }
    
    struct Output { }
    
    // MARK: init & deinit
    init(router: TradeDetailsRouter,
         getTradeRates: GetTradesRatesUseCase) {
        self.router = router
        self.getTradeRates = getTradeRates
        super.init(router: router)
    }
    
    // MARK: Binding
    func transform(input: Input) -> Output {
        input.trigger.subscribe { [weak self](_) in
            guard let weakSelf = self else { return }
            weakSelf.showLoading()
            weakSelf.getTradeRates().subscribe(onSuccess: { (tradesRates) in
                // TODO:
                weakSelf.hideLoading()
            }, onError: { (error) in
                weakSelf.process(error: error)
            }).disposed(by: weakSelf.disposeBag)
            
        }.disposed(by: disposeBag)
        
        return Output()
    }
    
    // MARK: Logic
}

