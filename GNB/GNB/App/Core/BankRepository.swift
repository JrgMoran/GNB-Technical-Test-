//
//  BankRepository.swift
//  GNB
//
//  Created by Jorge Morán on 24/3/21.
//  Copyright © 2021 Jorge Morán. All rights reserved.
//

import Foundation
import RxSwift

protocol BankRepository {
    func getTradeRates() -> Single<[TradeRate]>
    func getTrades() -> Single<[TradeElement]>
}
