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
    
    func fetchLessons(forGroups: [Group], forUserId: Int, completion: @escaping([Lesson]) -> Void) {
        var url = "http://194.67.92.182:3000/getLessons?loginid=\(forUserId)"
        forGroups.forEach { (group) in
            url += "&groupid=\(group.ID)"
        }
        let urlRequest = URLRequest(url: URL(string: url)!)
        let session = URLSession(configuration: .default)
        let dataTask = session.dataTask(with: urlRequest) { (data, response, error) in
            let responseL = try! JSONDecoder().decode([Lesson].self, from: data!)
            
            forGroups.forEach { (group) in
                responseL.forEach { (lesson) in
                    if group.ID == lesson.group_id {
                        lesson.groupName = group.NameInfo
                    }
                }
            }
            
            let url = "http://194.67.92.182:3000/getEvaluation?login=\(DataRepository.shared.user!.Login)"
            let urlRequest = URLRequest(url: URL(string: url)!)
            let session = URLSession(configuration: .default)
            let dataTask = session.dataTask(with: urlRequest) { (data, response, error) in
                let responseE = try! JSONDecoder().decode([Evaluation].self, from: data!)
                
                var url = "http://194.67.92.182:3000/getUserMarks?login=\(DataRepository.shared.user!.Login)"
                responseE.forEach { (evaluation) in
                    url += "&lessonsids=\(evaluation.lesson_id)"
                }
                let urlRequest = URLRequest(url: URL(string: url)!)
                let session = URLSession(configuration: .default)
                let dataTask = session.dataTask(with: urlRequest) { (data, response, error) in
                    let responseM = try! JSONDecoder().decode([Mark].self, from: data!)
                    
                    responseE.forEach { (evaluation) in
                        responseL.forEach { (lesson) in
                            responseM.forEach { (mark) in
                                if (evaluation.lesson_id == lesson.ID && evaluation.mark_id == mark.ID) {
                                    lesson.mark = mark
                                }
                            }
                        }
                    }
                }
                dataTask.resume()
            }
            dataTask.resume()
            
            DispatchQueue.main.async {
                completion(responseL)
            }
        }
        dataTask.resume()
    }
}
