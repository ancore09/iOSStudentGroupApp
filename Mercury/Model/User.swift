//
//  User.swift
//  Mercury
//
//  Created by Andrey  Grechko on 06.05.2020.
//  Copyright © 2020 Andrey Grechko. All rights reserved.
//

import Foundation

class User: Decodable {
    var ID: Int
    var Login: String
    var memberdata_ID: Int
    var memberData: MemberData?
}
