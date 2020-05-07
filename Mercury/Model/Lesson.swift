//
//  Lesson.swift
//  Mercury
//
//  Created by Andrey  Grechko on 06.05.2020.
//  Copyright © 2020 Andrey Grechko. All rights reserved.
//

import Foundation

class Lesson: Decodable {
    var ID: Int
    var theme: String
    var homework: String
    var group_id: Int
    var groupName: String?
    var datedmy: String
    var times: String?
    var mark: Mark?
}
