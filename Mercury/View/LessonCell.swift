//
//  LessonCell.swift
//  Mercury
//
//  Created by Andrey  Grechko on 06.05.2020.
//  Copyright © 2020 Andrey Grechko. All rights reserved.
//

import UIKit

class LessonCell: UICollectionViewCell {
    //MARK: Properties
    
    var lesson: Lesson? {
        didSet { configure() }
    }
    
    private let groupTextView: UITextView = {
        let tv = UITextView()
        tv.backgroundColor = .clear
        tv.font = UIFont.systemFont(ofSize: 16)
        tv.isScrollEnabled = false
        tv.isEditable = false
        tv.textColor = .black
        return tv
    }()
    
    private let themeTextView: UITextView = {
        let tv = UITextView()
        tv.backgroundColor = .clear
        tv.font = UIFont.systemFont(ofSize: 16)
        tv.isScrollEnabled = false
        tv.isEditable = false
        tv.textColor = .black
        return tv
    }()
    
    private let dateTextView: UITextView = {
        let tv = UITextView()
        tv.backgroundColor = .clear
        tv.font = UIFont.systemFont(ofSize: 16)
        tv.isScrollEnabled = false
        tv.isEditable = false
        tv.textColor = .black
        return tv
    }()
    
    private let timeTextView: UITextView = {
        let tv = UITextView()
        tv.backgroundColor = .clear
        tv.font = UIFont.systemFont(ofSize: 16)
        tv.isScrollEnabled = false
        tv.isEditable = false
        tv.textColor = .black
        return tv
    }()
    
    //MARK: Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Selectors
    
    //MARK: Helpers
    
    func configureView() {
        addSubview(groupTextView)
        groupTextView.centerX(inView: self)
        groupTextView.anchor(top: topAnchor, paddingTop: 2)
        
        addSubview(dateTextView)
        dateTextView.anchor(top: groupTextView.bottomAnchor, right: rightAnchor, paddingTop: 0, paddingRight: 4)
        
        addSubview(themeTextView)
        themeTextView.anchor(top: groupTextView.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: dateTextView.leftAnchor, paddingTop: 0, paddingLeft: 4, paddingBottom: 0)
        
        addSubview(timeTextView)
        timeTextView.anchor(top: dateTextView.bottomAnchor, bottom: bottomAnchor, right: rightAnchor, paddingBottom: 2, paddingRight: 4)
    }
    
    func configure() {
//        groupTextView.text = String(lesson!.group_id)
        groupTextView.text = lesson?.groupName
        themeTextView.text = lesson?.theme
        dateTextView.text = lesson?.datedmy
        timeTextView.text = lesson?.times
    }
    
    //MARK: API
}

