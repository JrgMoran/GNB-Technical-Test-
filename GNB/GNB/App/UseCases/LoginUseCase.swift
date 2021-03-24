//
//  LoginUseCase.swift
//  GNB
//
//  Created by Jorge Morán on 06/09/2020.
//  Copyright © 2020 Jorge Morán. All rights reserved.
//

import Foundation
import RxSwift

class LoginUseCase {
    var repository: SessionRepository
    
    init(repository: SessionRepository) {
        self.repository = repository
    }
    
    deinit {
        print("- deinit: \(self)")
    }
    
    func callAsFunction(user: String, pass: String, saveUser: Bool) -> Single<Void> {
        return repository.login(user: user, pass: pass, saveUser: saveUser).observeOn(MainScheduler.instance)
    }
    
}
