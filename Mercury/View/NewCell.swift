//
//  NewCell.swift
//  Mercury
//
//  Created by Andrey  Grechko on 06.05.2020.
//  Copyright © 2020 Andrey Grechko. All rights reserved.
//

import UIKit
import SDWebImage
import Nuke

class NewCell: UICollectionViewCell {
    //MARK: Properties
    
    var new: New? {
        didSet { configure() }
    }
    
    private let imageView: UIImageView = {
        let iv = UIImageView()
        //iv.backgroundColor = .systemGray
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    private let titleTextView: UITextView = {
        let tv = UITextView()
        tv.backgroundColor = .clear
        tv.font = UIFont.boldSystemFont(ofSize: 18)
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
        
        addSubview(bodyTextView)
        bodyTextView.anchor(top: titleTextView.bottomAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 4)
        
        addSubview(epilTextView)
        epilTextView.anchor(top: bodyTextView.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 4)
    }
    
    func configure() {
        titleTextView.text = new?.title
        bodyTextView.text = new?.body
        epilTextView.text = new?.epilogue
        
        if (!(new?.filehash!.isEmpty)!) {
            let url = "http://194.67.92.182:3001/\(new!.filehash!)"
            //imageView.sd_setImage(with: URL(string: url), completed: nil)
            Nuke.loadImage(with: URL(string: url)!, into: imageView)
        } else {
            imageView.image = nil
            imageView.backgroundColor = .gray
        }
    }
    
    //MARK: API
}
