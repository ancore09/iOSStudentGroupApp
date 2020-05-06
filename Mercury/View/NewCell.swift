//
//  NewCell.swift
//  Mercury
//
//  Created by Andrey  Grechko on 06.05.2020.
//  Copyright © 2020 Andrey Grechko. All rights reserved.
//

import UIKit

class NewCell: UICollectionViewCell {
    //MARK: Properties
    
    var new: New? {
        didSet { configure() }
    }
    
    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .systemGray
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    private let titleTextView: UITextView = {
        let tv = UITextView()
        tv.backgroundColor = .clear
        tv.font = UIFont.systemFont(ofSize: 16)
        tv.isScrollEnabled = false
        tv.isEditable = false
        tv.textColor = .black
        return tv
    }()
    
    private let bodyTextView: UITextView = {
        let tv = UITextView()
        tv.backgroundColor = .clear
        tv.font = UIFont.systemFont(ofSize: 16)
        tv.isScrollEnabled = false
        tv.isEditable = false
        tv.textColor = .black
        return tv
    }()
    
    private let epilTextView: UITextView = {
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
        addSubview(imageView)
        imageView.anchor(top: topAnchor, left: leftAnchor, right: rightAnchor, height: 200)
        
        addSubview(titleTextView)
        titleTextView.anchor(top: imageView.bottomAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 4)
        //titleTextView.backgroundColor = .gray
        
        addSubview(bodyTextView)
        bodyTextView.anchor(top: titleTextView.bottomAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 4)
        //bodyTextView.backgroundColor = .gray
        
        addSubview(epilTextView)
        epilTextView.anchor(top: bodyTextView.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 4)
        //epilTextView.backgroundColor = .gray
    }
    
    func configure() {
        titleTextView.text = new?.title
        bodyTextView.text = new?.body
        epilTextView.text = new?.epilogue
    }
    
    //MARK: API
}
