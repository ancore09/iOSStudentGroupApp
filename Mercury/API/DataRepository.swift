//
//  DataRepository.swift
//  Mercury
//
//  Created by Andrey  Grechko on 06.05.2020.
//  Copyright © 2020 Andrey Grechko. All rights reserved.
//

import SocketIO
import SwiftyJSON

class DataRepository {
    static let shared = DataRepository()
    
    var news: [New]?
    var lessons: [Lesson]?
    var user: User?
    var groups: [Group]?
    var messages: [Message]?
    
    var manager: SocketManager?
    var socket: SocketIOClient?
    
    func initSocket(completion: @escaping(Message) -> Void) {
        let result = groups![0].NameInfo.replacingOccurrences(of: "\\s", with: "", options: .regularExpression)
        print(result)
        manager = SocketManager(socketURL: URL(string: "http://194.67.92.182:3000")!, config: [.log(false), .compress])
        socket = manager?.defaultSocket
        
        socket!.on(clientEvent: .connect) {data, ack in
            print("socket connected")
            self.socket?.emit("changeRoom", ["new_id": result])
        }
        
        socket?.on("message", callback: { (data, ack) in
            let dataArray = data as NSArray
            let dataString = dataArray[0] as! String
            let dataNewNow = dataString.data(using: String.Encoding.utf8, allowLossyConversion: false)!
            do {
                let json = try JSONSerialization.jsonObject(with: dataNewNow, options: []) as! [String:AnyObject]
                let mm = json["memberData"]
                let memberData = MemberData(nick: mm!["nick"]!! as! String, color: mm!["color"]!! as! String)
                let message = Message(id: json["ID"] as! NSInteger, body: json["body"] as! String, memberData: memberData)
                self.messages?.append(message)
                completion(message)
                print(message.body)

            } catch let error as NSError {
                print("Failed to load: \(error.localizedDescription)")
            }
            print(data)
        })
        
        socket?.connect()
    }
    
    func authUser(login: String, hash: String, completion: @escaping(User) -> Void) {
        // fetching user
        let url = "http://194.67.92.182:3000/auth?login=\(login)&passwordhash=\(hash)"
        let urlRequest = URLRequest(url: URL(string: url)!)
        let session = URLSession(configuration: .default)
        let dataTask = session.dataTask(with: urlRequest) { (data, response, error) in
            let responseU = try! JSONDecoder().decode(User.self, from: data!)
            
            
            // fetching user's memberdata
            let url = "http://194.67.92.182:3000/getMemberData?id=\(responseU.memberdata_ID)"
            let urlRequest = URLRequest(url: URL(string: url)!)
            let session = URLSession(configuration: .default)
            let dataTask = session.dataTask(with: urlRequest) { (data, response, error) in
                let responseMD = try! JSONDecoder().decode(MemberData.self, from: data!)
                responseU.memberData = responseMD
                self.user = responseU
                
                //fetching gropings
                let url = "http://194.67.92.182:3000/getGrouping?userid=\(responseU.ID)"
                let urlRequest = URLRequest(url: URL(string: url)!)
                let session = URLSession(configuration: .default)
                let dataTask = session.dataTask(with: urlRequest) { (data, response, error) in
                    let responseGg = try! JSONDecoder().decode([Grouping].self, from: data!)
                    var ids = [Int]()
                    responseGg.forEach { (grouping) in
                        ids.append(grouping.Group_ID)
                    }
                    
                    // fetching groups
                    var url = "http://194.67.92.182:3000/getGroup?"
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
    
    func fetchMessages(completion: @escaping([Message]) -> Void) {
        var messages = [Message]()
        let url = "http://194.67.92.182:3000/getMessages"
        let urlRequest = URLRequest(url: URL(string: url)!)
        let session = URLSession(configuration: .default)
        let dataTask = session.dataTask(with: urlRequest) { (data, response, error) in
            do {
                let json = try JSON(data: data!)
                print(json[0]["body"])
                
                for (key, subJson):(String, JSON) in json {
                   print(subJson)
                    let mm = subJson["memberData"]
                    let memberData = MemberData(nick: mm["nick"].stringValue, color: mm["color"].stringValue)
                    let message = Message(id: subJson["ID"].int!, body: subJson["body"].stringValue, memberData: memberData)
                    messages.append(message)
                }
            } catch let error {
                print(error.localizedDescription)
            }
            DispatchQueue.main.async {
                completion(messages)
            }
        }
        dataTask.resume()
    }
    
    func sendMessage(message: Message) {
        do {
            let jsonEncoder = JSONEncoder()
            let jsonData = try jsonEncoder.encode(message)
            let json = String(data: jsonData, encoding: .utf8)
            socket?.emit("message", ["room": "SamsungITSchool", "mes": json])
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    
}
