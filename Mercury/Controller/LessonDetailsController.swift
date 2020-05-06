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
    
    private let themeTextView: UITextView = {
        let tv = UITextView()
        tv.backgroundColor = .clear
        tv.font = UIFont.boldSystemFont(ofSize: 20)
        tv.isScrollEnabled = false
        tv.isEditable = false
        tv.textColor = .black
        tv.text = "Theme:"
        return tv
    }()
    
    private lazy var themeInfoTextView: UITextView = {
        let tv = UITextView()
        tv.backgroundColor = .clear
        tv.font = UIFont.systemFont(ofSize: 16)
        tv.isScrollEnabled = false
        tv.isEditable = false
        tv.textColor = .black
        tv.text = self.lesson.theme
        return tv
    }()
    
    private let homeworkTextView: UITextView = {
        let tv = UITextView()
        tv.backgroundColor = .clear
        tv.font = UIFont.boldSystemFont(ofSize: 20)
        tv.isScrollEnabled = false
        tv.isEditable = false
        tv.textColor = .black
        tv.text = "Homework"
        return tv
    }()
    
    private lazy var homeworkInfoTextView: UITextView = {
        let tv = UITextView()
        tv.backgroundColor = .clear
        tv.font = UIFont.systemFont(ofSize: 16)
        tv.isScrollEnabled = false
        tv.isEditable = false
        tv.textColor = .black
        tv.text = self.lesson.homework
        return tv
    }()
    
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
        view.backgroundColor = .white
        navigationItem.title = lesson.datedmy
        configureUI()
    }
    
    //MARK: Selectors
    
    //MARK: Helpers
    
    func configureUI() {
        view.addSubview(themeTextView)
        themeTextView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 16, paddingLeft: 4, paddingRight: 4)
        
        view.addSubview(themeInfoTextView)
        themeInfoTextView.anchor(top: themeTextView.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 4, paddingRight: 4)
        
        view.addSubview(homeworkTextView)
        homeworkTextView.anchor(top: themeInfoTextView.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 16, paddingLeft: 4, paddingRight: 4)
        
        view.addSubview(homeworkInfoTextView)
        homeworkInfoTextView.anchor(top: (homeworkTextView).bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 4, paddingRight: 4)

    }
    
    //MARK: API
}
