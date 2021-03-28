//
//  TradeRate+Extensions.swift
//  GNB
//
//  Created by Jorge Morán on 27/3/21.
//  Copyright © 2021 Jorge Morán. All rights reserved.
//

import Foundation

extension Array where Element == TradeRate {
    mutating func completeTradesRates() {
        
        for (index, currency) in allCurrencies.enumerated() {
            
            if (index+1) < allCurrencies.count && (!exist(from: currency, to: allCurrencies[index+1]) || !exist(from: allCurrencies[index+1], to: currency)) {
                generateTradeRates(between: currency, and: allCurrencies[index+1]).forEach { (tradeRate) in
                    if !contains(where: {$0 == tradeRate}) {
                        self.append(tradeRate)
                    }
                }
            }
        }
    }
    
    var allCurrencies: [String] {
        var allCurrencies: [String] = []
        self.forEach { (tradeRate) in
            if !allCurrencies.contains(tradeRate.from) {
                allCurrencies.append(tradeRate.from)
            }
            
            if !allCurrencies.contains(tradeRate.to) {
                allCurrencies.append(tradeRate.to)
            }
        }
        return allCurrencies
    }
    
    func allCurrencies(of trade: TradeElement) -> [Amount]?{
        if allCurrencies.contains(where: {$0 == trade.currency}) {
            return allCurrencies.filter({$0 != trade.currency }).map { (currency) -> Amount in
                return tradeCurrency(currency, of: trade)
            }
        } else {
            return nil
        }
    }
    
    func tradeCurrency(_ currency: String, of trade: TradeElement) -> Amount {
        if trade.currency == currency {
            return Amount(from: trade)
        } else if let tradeRate = find(from: trade.currency, to: currency),
           let rate = Double(tradeRate.rate),
           let tradeAmount = Double(trade.amount){
            return Amount(value: tradeAmount * rate, currency: tradeRate.to)
        }
        
        return Amount(value: nil, currency: currency)
    }
    
    private func exist(from fromCurrency: String, to toCurrency: String) -> Bool{
        return self.filter({ $0.from == fromCurrency && $0.to == toCurrency }).count > 0
    }
    
    private func find(from fromCurrency: String, to toCurrency: String)  -> TradeRate? {
        self.filter({ $0.from == fromCurrency && $0.to == toCurrency }).first
    }
    
    private func find(to toCurrency: String) -> [TradeRate]{
        self.filter({$0.to == toCurrency})
    }
    
    private func generateTradeRates(between currency1: String, and currency2: String) -> [TradeRate] {
        var tradeRates: [TradeRate] = []
        if let tradeRate = find(from: currency1, to: currency2) {
            tradeRates.append(tradeRate)
        } else if let tradeRate = find(from: currency2, to: currency1), let rate = Float(tradeRate.rate){
            tradeRates.append(tradeRate)
            let rate = "\(1 / rate)"
            tradeRates.append(TradeRate(from: currency1, to: currency2, rate: rate))
        } else {
            tradeRates.append(contentsOf: superFinder(from: currency1, to: currency2))
        }
        
        return tradeRates
    }
    
    private func superFinder(from fromCurrency: String, to toCurrency: String) -> [TradeRate] {
        if let tradeRate = find(from: fromCurrency, to: toCurrency) {
            var tradeRates: [TradeRate] = [tradeRate]
            let rate = 1 / (Float(tradeRate.rate) ?? 1)
            tradeRates.append(TradeRate(from: tradeRate.to, to: tradeRate.from, rate: "\(rate)"))
            return [tradeRate]
            
        } else {
            var tradeRates: [TradeRate] = []
            find(to: toCurrency).forEach { (posibleTradeRate) in
                if let tradeRateFirst = find(from: fromCurrency, to: posibleTradeRate.from) {
                    let rate = (Float(tradeRateFirst.rate) ?? 1) * (Float(posibleTradeRate.rate) ?? 1)
                    
                    if rate != 0 {
                        tradeRates.append(TradeRate(from: fromCurrency, to: toCurrency, rate: "\(rate)"))
                        tradeRates.append(TradeRate(from: toCurrency, to: fromCurrency, rate: "\(1/rate)"))
                        return
                    }
                }
            }
            if tradeRates.count > 0 {
                return tradeRates
            } else {
                find(to: toCurrency).forEach { (posibleTradeRate) in
                    tradeRates.append(contentsOf:superFinder(from: fromCurrency, to: posibleTradeRate.from))
                }
                return tradeRates
            }
        }
    }
    
}

extension TradeRate: Equatable {
    static func == (lhs: TradeRate, rhs: TradeRate) -> Bool {
        return lhs.from == rhs.from &&
            lhs.to == rhs.to &&
            lhs.rate == rhs.rate
    }
}
