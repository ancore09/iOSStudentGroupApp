//
//  LessonDetailsController.swift
//  Mercury
//
//  Created by Andrey  Grechko on 06.05.2020.
//  Copyright © 2020 Andrey Grechko. All rights reserved.
//

import UIKit

class LessonDetailsController: UIViewController {
    //MARK: Properties
    
    private let lesson: Lesson
    
    //MARK: Lifecycle
    
    init(lesson: Lesson) {
        self.lesson = lesson
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemPink
        configureNavigationBar(withTitle: lesson.datedmy, prefersLargeTitles: true)
    }
    
    //MARK: Selectors
    
    //MARK: Helpers
    
    //MARK: API
}
