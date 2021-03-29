//
//  AppInjector.swift
//  GNB
//
//  Created by Jorge Morán on 29/3/21.
//  Copyright © 2021 Jorge Morán. All rights reserved.
//

import Foundation
import Swinject

final class AppInjector {
    let container: Container
    static let shared: AppInjector = AppInjector()
    
    private init() {
        container = Container()
        setup()
    }
    
    private var network: SessionNetwork & BankNetwork {
        switch AppEnvironment.shared.scheme {
        case .production:
            return NetworkClient(with: Downloader())
        case .mock:
            return NetworkMockClient()
        case .dev:
            return NetworkClient(with: Downloader())
        }
    }
    
    private func setup() {
        
        // MARK: - Client
        container.register(KeyChain.self) { r in
            KeyChainImpl()
        }
        
        container.register(UserData.self) { r in
            UserDataImpl(keyChain: r.resolve(KeyChain.self))
        }
        
        container.register(SessionRepository.self) { r in
            SessionRepositoryImpl(network: self.network,
                                  userData: r.resolve(UserData.self)!)
        }
        
        container.register(RelogableRepository.self) { r in
            SessionRepositoryImpl(network: self.network,
                                  userData: r.resolve(UserData.self)!)
        }
        
        container.register(BankRepository.self) { r in
            BankRepositoryImpl(network: self.network,
                               relogable: r.resolve(RelogableRepository.self)!)
        }
        
        // MARK: - UseCases
        container.register(LoginUseCase.self) { r in
            LoginUseCase(repository: r.resolve(SessionRepository.self)!)
        }
        
        container.register(GetTradesRatesUseCase.self) { r in
            GetTradesRatesUseCase(repository: r.resolve(BankRepository.self)!)
        }
        
        container.register(GetTradesUseCase.self) { r in
            GetTradesUseCase(repository: r.resolve(BankRepository.self)!)
        }
        
        // MARK: - ViewModels
        container.register(SplashViewModel.self) { r, router in
            SplashViewModel(router: router)
        }
        
        container.register(LoginViewModel.self) { r, router in
            LoginViewModel(loginUseCase: r.resolve(LoginUseCase.self)!,
                           router: router)
        }
        
        container.register(HomeViewModel.self) { r, router in
            HomeViewModel(router: router, getTrades: r.resolve(GetTradesUseCase.self)!)
        }
        
        container.register(TradeDetailsViewModel.self) { r, router, trades, tradesSelected in
            TradeDetailsViewModel(router: router,
                                  getTradeRates: r.resolve(GetTradesRatesUseCase.self)!,
                                  trades: trades,
                                  tradeSelected: tradesSelected)
        }

    }
}
