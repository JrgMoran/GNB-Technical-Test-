//
//  GetTradesRatesUseCase.swift
//  GNB
//
//  Created by Jorge Morán on 24/3/21.
//  Copyright © 2021 Jorge Morán. All rights reserved.
//

import Foundation
import RxSwift

class GetTradesRatesUseCase {
    var repository: BankRepository
    
    init(repository: BankRepository) {
        self.repository = repository
    }
    
    deinit {
        print("- deinit: \(self)")
    }
    
    func callAsFunction() -> Single<[TradeRate]> {
        return repository.getTradeRates().observeOn(MainScheduler.instance)
    }
    
}
