//
//  NetworkMockClient.swift
//  GNB
//
//  Created by Jorge Morán on 4/3/21.
//  Copyright © 2021 Jorge Morán. All rights reserved.
//

import RxSwift

class NetworkMockClient: Network{
    
}

extension NetworkMockClient: SessionNetwork {
    func login(user: String, pass: String) -> Single<Session> {
        let json = """
        {"token":"eyJzdWIiOiI1NGE4Y2U2MThlOTFiMGIxMzY2NWUyZjkiLCJpYXQiOiIxNDI0MTgwNDg0IiwiZXhwIjoiMTQyNTM5MDE0MiJ9"}
        """
        return decoder(from: Data(json.utf8))
    }
}

extension NetworkMockClient: BankNetwork {
    func getTradeRates() -> Single<[TradeRate]> {
        let json = """
        [{"from":"CAD","to":"AUD","rate":"0.98"},{"from":"AUD","to":"CAD","rate":"1.02"},{"from":"CAD","to":"USD","rate":"1.41"},{"from":"USD","to":"CAD","rate":"0.71"},{"from":"AUD","to":"EUR","rate":"1.28"},{"from":"EUR","to":"AUD","rate":"0.78"}]
        """
        return decoderArray(from: Data(json.utf8))
    }
    
    func getTrades() -> Single<[TradeElement]> {
        let json = """
        [{"sku":"U2287","amount":"32.0","currency":"EUR"},{"sku":"U7513","amount":"15.8","currency":"AUD"},{"sku":"A7763","amount":"17.2","currency":"EUR"},{"sku":"G0199","amount":"19.6","currency":"EUR"},{"sku":"O5790","amount":"22.7","currency":"CAD"},{"sku":"U7513","amount":"21.2","currency":"EUR"},{"sku":"Q1433","amount":"27.7","currency":"USD"},{"sku":"Y6228","amount":"27.3","currency":"AUD"},{"sku":"M3871","amount":"16.0","currency":"EUR"},{"sku":"M5366","amount":"30.3","currency":"EUR"},{"sku":"N1535","amount":"21.4","currency":"AUD"},{"sku":"N1535","amount":"25.6","currency":"USD"},{"sku":"U2287","amount":"34.0","currency":"CAD"},{"sku":"W1244","amount":"17.0","currency":"AUD"},{"sku":"S6203","amount":"20.3","currency":"EUR"},{"sku":"S8454","amount":"30.3","currency":"AUD"},{"sku":"G0199","amount":"18.9","currency":"CAD"},{"sku":"M3871","amount":"34.9","currency":"CAD"},{"sku":"N1535","amount":"33.5","currency":"CAD"},{"sku":"A7763","amount":"23.6","currency":"USD"},{"sku":"S6203","amount":"34.6","currency":"CAD"},{"sku":"W1244","amount":"28.0","currency":"USD"},{"sku":"Y6228","amount":"24.6","currency":"EUR"},{"sku":"S8454","amount":"17.8","currency":"USD"},{"sku":"S8454","amount":"28.1","currency":"EUR"},{"sku":"W1244","amount":"34.0","currency":"CAD"},{"sku":"M3871","amount":"16.1","currency":"USD"},{"sku":"U7513","amount":"16.7","currency":"EUR"},{"sku":"O5790","amount":"19.1","currency":"EUR"},{"sku":"A7763","amount":"33.9","currency":"AUD"},{"sku":"U7513","amount":"31.9","currency":"EUR"},{"sku":"S6203","amount":"16.0","currency":"EUR"},{"sku":"M3871","amount":"24.5","currency":"AUD"},{"sku":"Y6228","amount":"21.6","currency":"AUD"},{"sku":"O5790","amount":"15.1","currency":"AUD"},{"sku":"W1244","amount":"19.7","currency":"CAD"},{"sku":"M5366","amount":"20.0","currency":"AUD"},{"sku":"O5790","amount":"26.1","currency":"CAD"},{"sku":"G0199","amount":"32.5","currency":"EUR"},{"sku":"U7513","amount":"15.0","currency":"EUR"},{"sku":"M5366","amount":"34.4","currency":"EUR"},{"sku":"U7513","amount":"24.9","currency":"USD"},{"sku":"Y6228","amount":"15.6","currency":"EUR"},{"sku":"O5790","amount":"18.4","currency":"EUR"},{"sku":"S6203","amount":"19.1","currency":"CAD"},{"sku":"S8454","amount":"25.0","currency":"USD"},{"sku":"G0199","amount":"26.3","currency":"AUD"},{"sku":"S8454","amount":"17.8","currency":"CAD"},{"sku":"W1244","amount":"18.2","currency":"USD"},{"sku":"U7513","amount":"30.0","currency":"USD"},{"sku":"M3871","amount":"27.8","currency":"EUR"},{"sku":"Y6228","amount":"20.4","currency":"AUD"}]
        """
        return decoderArray(from: Data(json.utf8))
    }
}
