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
    fileprivate let trades: BehaviorRelay<[TradeElement]> = BehaviorRelay(value: [])
    fileprivate let isHiddenTableView: BehaviorRelay<Bool> = BehaviorRelay(value: false)
    
    
    struct Input {
        let trigger: Observable<Void>
    }
    
    struct Output {
        let isHiddenTableView: Observable<Bool>
        let trades: Observable<[TradeElement]>
    }
    
    // MARK: init & deinit
    init(router: HomeRouter,
         getTradeRates: GetTradesRatesUseCase, getTrades: GetTradesUseCase) {
        self.router = router
        self.getTradeRates = getTradeRates
        self.getTrades = getTrades
        super.init(router: router)
        
        trades.subscribe {[weak self] (trades) in
            self?.isHiddenTableView.accept(trades.element?.count == 0)
        }.disposed(by: disposeBag)
        
    }
    
    // MARK: Binding
    func transform(input: Input) -> Output {
        input.trigger.subscribe { [weak self](_) in
            guard let weakSelf = self else { return }
            weakSelf.showLoading()
            weakSelf.getTradeRates().subscribe(onSuccess: { (tradesRates) in
                // TODO:
            }, onError: { (error) in
//                weakSelf.process(error: error)
            }).disposed(by: weakSelf.disposeBag)
            
            weakSelf.getTrades().subscribe(onSuccess: { (trades) in
                weakSelf.trades.accept(trades)
                weakSelf.hideLoading()
            }, onError: { (error) in
                weakSelf.process(error: error)
            }).disposed(by: weakSelf.disposeBag)
            
        }.disposed(by: disposeBag)
        return Output(isHiddenTableView: isHiddenTableView.asObservable(), trades: trades.asObservable())
    }
    
    // MARK: Logic
}

