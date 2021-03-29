//
//  LoginRequest.swift
//  GNB
//
//  Created by Jorge Morán on 19/3/21.
//  Copyright © 2021 Jorge Morán. All rights reserved.
//

import Foundation

struct LoginRequest: AppRequest {
    var user: String
    var pass: String

    init(user: String, pass: String){
        self.user = user
        self.pass = pass
    }
    
    var endpoint: AppEndpoint = AppEndpoint.login
    var method: AppRequestMethod = AppRequestMethod.post
    var body: [String : Any]? {
        ["user": user,
         "pass": pass]
    }
    
}
