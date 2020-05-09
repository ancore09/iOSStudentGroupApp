//
//  NewAdditionFromController.swift
//  Mercury
//
//  Created by Andrey  Grechko on 09.05.2020.
//  Copyright © 2020 Andrey Grechko. All rights reserved.
//

import Eureka

class NewAdditionFromController: FormViewController {
    //MARK: Properties
    
    //MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        configureNavigationBar(withTitle: "Post News", prefersLargeTitles: false)
        
        form +++ Section("Meta")
            <<< TextRow(){ row in
                row.tag = "groupName"
                row.title = "Group"
                row.placeholder = "Name"
            }
            <<< DateRow(){
                $0.tag = "date"
                $0.title = "Date"
                $0.value = Date(timeIntervalSinceReferenceDate: 0)
            }
        +++ Section("Information")
            <<< ImageRow() { row in
                row.title = "Image"
            }
            <<< TextRow(){ row in
                row.tag = "title"
                row.title = "Title"
                row.placeholder = "Text"
            }
            <<< TextAreaRow(){ row in
                row.tag = "body"
                row.title = "Body"
                row.placeholder = "Body"
            }
            <<< TextRow(){ row in
                row.tag = "epilogue"
                row.title = "Epilogue"
                row.placeholder = "Text"
            }
        +++ Section("Confirm")
            <<< ButtonRow() {
                $0.title = "Post"
            }.onCellSelection({ (cellOf, row) in
                self.postNew()
            })
    }
    
    //MARK: Selectors
    
    //MARK: Helpers
    
    //MARK: API
    
    func postNew() {
        let dict = self.form.values()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy"
        var dateString = dateFormatter.string(from: dict["date"] as! Date)
        dateString = dateString.replacingOccurrences(of: "-", with: ".")
        print(dateString)
        let newToPost = New(id: 0, title: dict["title"] as! String, body: dict["body"] as! String, epil: dict["epilogue"] as! String, date: dateString, filehash: dict["filehash"] as? String)
        
        NewsService.shared.postNew(forGroupId: 1, new: newToPost) { (new) in
            print("Success")
        }
    }
}
