//
//  NewsService.swift
//  Mercury
//
//  Created by Andrey  Grechko on 06.05.2020.
//  Copyright © 2020 Andrey Grechko. All rights reserved.
//

import Foundation

struct NewsService {
    static let shared = NewsService()
    
    func fetchNews(forGroupIds: [Int], completion: @escaping([New]) -> Void) {
        var url = "http://194.67.92.182:3000/getNews?"
        forGroupIds.forEach { (id) in
            url += "groupid=\(id)&"
        }
        let urlRequest = URLRequest(url: URL(string: url)!)
        let session = URLSession(configuration: .default)
        let dataTask = session.dataTask(with: urlRequest) { (data, response, error) in
            let responseObject = try! JSONDecoder().decode([New].self, from: data!)
            
            DispatchQueue.main.async {
                completion(responseObject)
            }
        }
        dataTask.resume()
    }
    
    func postNew(forGroupId: Int, new: New, completion: @escaping(New) -> Void) {
        var url = "http://194.67.92.182:3000/postNew?groupid=\(forGroupId)"
        var components = URLComponents(url: URL(string: url)!, resolvingAgainstBaseURL: false)!

        components.queryItems = [
            URLQueryItem(name: "datedmy", value: new.datedmy),
            URLQueryItem(name: "title", value: new.title),
            URLQueryItem(name: "body", value: new.body),
            URLQueryItem(name: "epilogue", value: new.epilogue),
            URLQueryItem(name: "filehash", value: new.filehash)
        ]

        let query = components.url!.query

        var urlRequest = URLRequest(url: URL(string: url)!)
        urlRequest.httpMethod = "POST"
        urlRequest.httpBody = Data(query!.utf8)
        let session = URLSession(configuration: .default)
        let dataTask = session.dataTask(with: urlRequest) { (data, response, error) in
            //let responseObject = try! JSONDecoder().decode([New].self, from: data!)
            
            DispatchQueue.main.async {
                completion(new)
            }
        }
        dataTask.resume()
    }
}
