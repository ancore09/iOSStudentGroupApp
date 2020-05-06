//
//  New.swift
//  Mercury
//
//  Created by Andrey  Grechko on 06.05.2020.
//  Copyright © 2020 Andrey Grechko. All rights reserved.
//

import Foundation

class New: Decodable {
    var ID: Int
    var title: String
    var body: String
    var epilogue: String
    var datedmy: String
    var filehash: String
    
    init(id: Int, title: String, body: String, epil: String, date: String, filehash: String) {
        self.ID = id
        self.title = title
        self.body = body
        self.epilogue = epil
        self.datedmy = date
        self.filehash = filehash
    }
}
