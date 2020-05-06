//
//  LoginViewModel.swift
//  ChatApp
//
//  Created by Andrey  Grechko on 04.05.2020.
//  Copyright © 2020 Andrey Grechko. All rights reserved.
//

import Foundation

protocol AuthenticationProtocol {
    var formIsValid: Bool { get }
}

struct LoginViewModel: AuthenticationProtocol {
    var email: String?
    var password: String?
    
    var formIsValid: Bool {
        return email?.isEmpty == false &&
            password?.isEmpty == false
    }
}

