//
//  NetworkClient.swift
//  GNB
//
//  Created by Jorge Morán on 4/3/21.
//  Copyright © 2021 Jorge Morán. All rights reserved.
//

import Foundation
import RxSwift

class NetworkClient: Network {
    var downloader: Downloader
    
    init(with downloader: Downloader) {
        self.downloader = downloader
    }
}

extension NetworkClient: SessionNetwork {
    func login(user: String, pass: String) -> Single<Session> {
        return Single.create{[weak self] (single) -> Disposable in
            self?.downloader.execute(with: LoginRequest(user: user, pass: pass).request, completion: {[weak self] (result) in
                if let weakSelf = self {
                    single(weakSelf.decoderObjectOfSingleEvent(from: result))
                } else {
                    single(SingleEvent.error(AppError.noSelf))
                }
                
            })
            return Disposables.create {}
        }
    }
}

extension NetworkClient: BankNetwork {
    func getTradeRates() -> Single<[TradeRate]> {
        return Single.create{[weak self] (single) -> Disposable in
            self?.downloader.execute(with: TradeRatesRequest().request, completion: {[weak self] (result) in
                if let weakSelf = self {
                    
                    single(weakSelf.decoderObjectsOfSingleEvent(from: result))
                } else {
                    single(SingleEvent.error(AppError.noSelf))
                }
            })
            return Disposables.create {}
        }
    }
    
    func getTrades() -> Single<[TradeElement]> {
        return Single.create{ [weak self] (single) -> Disposable in
            self?.downloader.execute(with: TransactionRequest().request, completion: {[weak self] (result) in
                if let weakSelf = self {
                    single(weakSelf.decoderObjectsOfSingleEvent(from: result))
                } else {
                    single(SingleEvent.error(AppError.noSelf))
                }
            })
            return Disposables.create {}
        }
    }
    
    
}
