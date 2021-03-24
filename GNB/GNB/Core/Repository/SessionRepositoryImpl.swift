//
//  SessionRepository.swift
//  GNB
//
//  Created by Jorge Morán on 06/09/2020.
//  Copyright © 2020 Jorge Morán. All rights reserved.
//

import Foundation
import RxSwift

class SessionRepositoryImpl: SessionRepository {
    
    let network: SessionNetwork
    let userData: UserData
    
    init(network: SessionNetwork, userData: UserData) {
        self.network = network
        self.userData = userData
    }
    
    func login(user: String, pass: String, saveUser: Bool) -> Single<Void> {
        return network.login(user: user, pass: pass).map {[weak self] (session) -> Void in
            if saveUser {
                self?.userData.save(value: user, for: UserPreferencesKey.user)
                self?.userData.save(value: pass, for: UserPreferencesKey.pass)
            } else {
                self?.userData.deleteKeyChain()
            }
            return
        }
    }
}

extension SessionRepositoryImpl: RelogableRepository {
    
    func relogin() -> Single<Void> {
        guard let user = userData.load(for: UserPreferencesKey.user),
              let pass = userData.load(for: UserPreferencesKey.pass) else {
            return Single.error(AppError.notFound)
        }
        return login(user: user, pass: pass, saveUser: true)
    }

    func relogableRequest<T>(_ request: Single<T>) -> Single<T> {
        return request.catchError { [weak self] (error) -> Single<T> in
            if let error = error as? AppError, error == AppError.unautorized, let weakSelf = self {
                return weakSelf.relogin().flatMap { (_) -> Single<T> in
                    return request
                }
            }
            return request
        }
    }
}
