//
//  Lesson.swift
//  Mercury
//
//  Created by Andrey  Grechko on 06.05.2020.
//  Copyright © 2020 Andrey Grechko. All rights reserved.
//

import Foundation

class Lesson: Decodable {
    var theme: String
    var homework: String
    var group_id: Int
    var datedmy: String
    var times: String
}
