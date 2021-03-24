//
//  BankRepositoryImpl.swift
//  GNB
//
//  Created by Jorge Morán on 24/3/21.
//  Copyright © 2021 Jorge Morán. All rights reserved.
//

import Foundation
import RxSwift

class BankRepositoryImpl: BankRepository {
    let network: BankNetwork
    let relogable: RelogableRepository
    
    init(network: BankNetwork, relogable: RelogableRepository) {
        self.network = network
        self.relogable = relogable
    }
    
    func getTradeRates() -> Single<[TradeRate]> {
        return relogable.relogableRequest(network.getTradeRates())
    }
    
    func getTrades() -> Single<[TradeElement]> {
        return relogable.relogableRequest(network.getTrades())
    }
    
    
}
