//
//  DataRepository.swift
//  Mercury
//
//  Created by Andrey  Grechko on 06.05.2020.
//  Copyright © 2020 Andrey Grechko. All rights reserved.
//

import Foundation

class DataRepository {
    static let shared = DataRepository()
    
    var news: [New]?
    var lessons: [Lesson]?
    var user: User?
    var groups: [Group]?
    
    func authUser(login: String, hash: String, completion: @escaping(User) -> Void) {
        let url = "http://194.67.92.182:3000/auth?login=\(login)&passwordhash=\(hash)"
        let urlRequest = URLRequest(url: URL(string: url)!)
        let session = URLSession(configuration: .default)
        let dataTask = session.dataTask(with: urlRequest) { (data, response, error) in
            let responseU = try! JSONDecoder().decode(User.self, from: data!)
            
            
            
            
            
            let url = "http://194.67.92.182:3000/getMemberData?id=\(responseU.memberdata_ID)"
            let urlRequest = URLRequest(url: URL(string: url)!)
            let session = URLSession(configuration: .default)
            let dataTask = session.dataTask(with: urlRequest) { (data, response, error) in
                let responseMD = try! JSONDecoder().decode(MemberData.self, from: data!)
                responseU.memberData = responseMD
                
                
                
                let url = "http://194.67.92.182:3000/getGrouping?userid=\(responseU.ID)"
                let urlRequest = URLRequest(url: URL(string: url)!)
                let session = URLSession(configuration: .default)
                let dataTask = session.dataTask(with: urlRequest) { (data, response, error) in
                    let responseGg = try! JSONDecoder().decode([Grouping].self, from: data!)
                    var ids = [Int]()
                    responseGg.forEach { (grouping) in
                        ids.append(grouping.Group_ID)
                    }
                    
                    var url = "http://194.67.92.182:3000/getLessons?"
                    ids.forEach { (id) in
                        url += "id=\(id)&"
                    }
                    
                    let urlRequest = URLRequest(url: URL(string: url)!)
                    let session = URLSession(configuration: .default)
                    let dataTask = session.dataTask(with: urlRequest) { (data, response, error) in
                        let responseG = try! JSONDecoder().decode([Group].self, from: data!)
                        self.groups = responseG
                        
                        DispatchQueue.main.async {
                            completion(responseU)
                        }
                    }
                    dataTask.resume()
                }
                dataTask.resume()
            }
            dataTask.resume()
        }
        dataTask.resume()

    }
}
