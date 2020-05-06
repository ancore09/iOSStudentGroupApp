//
//  Message.swift
//  Mercury
//
//  Created by Andrey  Grechko on 06.05.2020.
//  Copyright © 2020 Andrey Grechko. All rights reserved.
//

import Foundation

class Message: Decodable {
    var ID: Int
    var body: String
    var memberData: MemberData
    var belongsToCurrentUser: Bool = false
    var filehash: String = ""
    
    init(id: Int, body: String, memberData: MemberData) {
        self.ID = id
        self.body = body
        self.memberData = memberData
    }
}
