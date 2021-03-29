//
//  SessionRepository.swift
//  GNB
//
//  Created by Jorge Morán on 4/3/21.
//  Copyright © 2021 Jorge Morán. All rights reserved.
//

import Foundation
import RxSwift

protocol SessionRepository {
    func login(user: String, pass: String, saveUser: Bool) -> Single<Void>
}
