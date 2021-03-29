//
//  GetTradesUseCase.swift
//  GNB
//
//  Created by Jorge Morán on 24/3/21.
//  Copyright © 2021 Jorge Morán. All rights reserved.
//

import Foundation
import RxSwift

class GetTradesUseCase {
    var repository: BankRepository
    
    init(repository: BankRepository) {
        self.repository = repository
    }
    
    deinit {
        print("- deinit: \(self)")
    }
    
    func callAsFunction() -> Single<[TradeElement]> {
        return repository.getTrades().observeOn(MainScheduler.instance)
    }
    
}
