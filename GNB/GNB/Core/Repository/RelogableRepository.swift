//
//  RelogableRepository.swift
//  GNB
//
//  Created by Jorge Morán on 4/3/21.
//  Copyright © 2021 Jorge Morán. All rights reserved.
//

import RxSwift

protocol RelogableRepository {
    func relogableRequest<T>(_ request: Single<T>) -> Single<T>
}
