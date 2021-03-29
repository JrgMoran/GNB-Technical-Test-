//
//  BankNetwork.swift
//  GNB
//
//  Created by Jorge Morán on 24/3/21.
//  Copyright © 2021 Jorge Morán. All rights reserved.
//

import RxSwift

protocol BankNetwork {
    func getTradeRates() -> Single<[TradeRate]>
    func getTrades() -> Single<[TradeElement]>
}
