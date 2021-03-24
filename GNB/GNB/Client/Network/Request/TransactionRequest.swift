//
//  TransactionRequest.swift
//  GNB
//
//  Created by Jorge Morán on 24/3/21.
//  Copyright © 2021 Jorge Morán. All rights reserved.
//

import Foundation
struct TransactionRequest: AppRequest {
    var endpoint: AppEndpoint { AppEndpoint.transaction }
    
    var method: AppRequestMethod { .get }
}
