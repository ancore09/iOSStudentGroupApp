//
//  LessonAdditionFromController.swift
//  Mercury
//
//  Created by Andrey  Grechko on 10.05.2020.
//  Copyright © 2020 Andrey Grechko. All rights reserved.
//

import Eureka

class LessonAdditionFromController: FormViewController {
    //MARK: Properties
    
    //MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        configureNavigationBar(withTitle: "Post Lesson", prefersLargeTitles: false)
        
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
            <<< TimeRow(){ row in
                row.tag = "from"
                row.title = "From"
            }
            <<< TimeRow(){ row in
                row.tag = "to"
                row.title = "To"
            }
        +++ Section("Information")
            <<< TextRow(){ row in
                row.tag = "theme"
                row.title = "Theme"
                row.placeholder = "Text"
            }
            <<< TextAreaRow(){ row in
                row.tag = "homework"
                row.title = "Homework"
                row.placeholder = "Homework"
            }
            <<< TextRow(){ row in
                row.tag = "comment"
                row.title = "Comment"
                row.placeholder = "Text"
            }
        +++ Section("Confirm")
            <<< ButtonRow() {
                $0.title = "Post"
            }.onCellSelection({ (cellOf, row) in
                self.postLesson()
            })
    }
    
    //MARK: Selectors
    
    //MARK: Helpers
    
    //MARK: API
    
    func postLesson() {
        let dict = self.form.values()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy"
        var dateString = dateFormatter.string(from: dict["date"] as! Date)
        dateString = dateString.replacingOccurrences(of: "-", with: ".")
        print(dict)
        
    }
}
