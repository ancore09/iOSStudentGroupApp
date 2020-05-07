//
//  MemberData.swift
//  Mercury
//
//  Created by Andrey  Grechko on 06.05.2020.
//  Copyright © 2020 Andrey Grechko. All rights reserved.
//

import Foundation

class MemberData: Decodable, Encodable {
    var nick: String
    var color: String
    
    init(nick: String, color: String) {
        self.nick = nick
        self.color = color
    }
}
