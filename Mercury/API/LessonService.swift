//
//  LessonService.swift
//  Mercury
//
//  Created by Andrey  Grechko on 06.05.2020.
//  Copyright © 2020 Andrey Grechko. All rights reserved.
//

import Foundation

struct LessonService {
    static let shared = LessonService()
    
    func fetchLessons(forGroupId: Int, forUserId: Int, completion: @escaping([Lesson]) -> Void) {
        let url = "http://194.67.92.182:3000/getLessons?groupid=\(forGroupId)&loginid=\(forUserId)"
        let urlRequest = URLRequest(url: URL(string: url)!)
        
        let session = URLSession(configuration: .default)
        
        let dataTask = session.dataTask(with: urlRequest) { (data, response, error) in
            let responseObject = try! JSONDecoder().decode([Lesson].self, from: data!)
            
            DispatchQueue.main.async {
                completion(responseObject)
            }
        }
        dataTask.resume()
    }
}
