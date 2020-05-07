//
//  MessageCell.swift
//  ChatApp
//
//  Created by Andrey  Grechko on 05.05.2020.
//  Copyright © 2020 Andrey Grechko. All rights reserved.
//

import UIKit
import SDWebImage

class MessageCell: UICollectionViewCell {
    
    //MARK: Properties
    var message: Message? {
        didSet { configure() }
    }
    
    var bubbleLeftAnchor: NSLayoutConstraint!
    var bubbleLRightAnchor: NSLayoutConstraint!
    
    private lazy var profileImgeView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .gray
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    private let textView: UITextView = {
        let tv = UITextView()
        tv.backgroundColor = .clear
        tv.font = UIFont.systemFont(ofSize: 16)
        tv.isScrollEnabled = false
        tv.isEditable = false
        tv.textColor = .white
        return tv
    }()
    
    private let usernameTextView: UITextView = {
        let tv = UITextView()
        tv.backgroundColor = .clear
        tv.font = UIFont.systemFont(ofSize: 9)
        tv.isScrollEnabled = false
        tv.isEditable = false
        tv.textColor = .systemPurple
        return tv
    }()
    
    private let bubbleContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .systemPurple
        return view
    }()
    
    //MARK: Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //backgroundColor = .red
        
        addSubview(profileImgeView)
        profileImgeView.anchor(left: leftAnchor, bottom: bottomAnchor, paddingLeft: 8, paddingBottom: -4)
        profileImgeView.setDimensions(height: 32, width: 32)
        profileImgeView.layer.cornerRadius = 32 / 2
        
        addSubview(bubbleContainer)
        bubbleContainer.layer.cornerRadius = 12
        bubbleContainer.anchor(top: topAnchor, bottom: bottomAnchor)
        bubbleContainer.widthAnchor.constraint(lessThanOrEqualToConstant: 250).isActive = true
        
        bubbleLeftAnchor = bubbleContainer.leftAnchor.constraint(equalTo: profileImgeView.rightAnchor, constant: 12)
        bubbleLeftAnchor.isActive = false
        bubbleLRightAnchor = bubbleContainer.rightAnchor.constraint(equalTo: rightAnchor, constant: -12)
        bubbleLRightAnchor.isActive = false
        
        bubbleContainer.addSubview(usernameTextView)
        usernameTextView.anchor(top: bubbleContainer.topAnchor, left: bubbleContainer.leftAnchor, right: bubbleContainer.rightAnchor, paddingTop: -19, paddingLeft: 4, paddingRight: 12)
        
        bubbleContainer.addSubview(textView)
        textView.anchor(top: bubbleContainer.topAnchor, left: bubbleContainer.leftAnchor, bottom: bubbleContainer.bottomAnchor, right: bubbleContainer.rightAnchor, paddingTop: 4, paddingLeft: 12, paddingBottom: 4, paddingRight: 12)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Helpers
    
    func configure() {
        guard let message = message else { return }
        let viewModel = MessageViewModel(message: message)
        
        bubbleContainer.backgroundColor = viewModel.messageBackgroundColor
        textView.textColor = viewModel.messageTextColor
        textView.text = message.body
        
        bubbleLeftAnchor.isActive = viewModel.leftAnchorActive
        bubbleLRightAnchor.isActive = viewModel.rightAnchorActive
        
        profileImgeView.isHidden = viewModel.shouldHideProfileImage
        var color = self.message?.memberData.color
        color! += "ff"
        profileImgeView.backgroundColor = UIColor(hex: color!)
        //profileImgeView.sd_setImage(with: viewModel.profileImageUrl, completed: nil)
        
        usernameTextView.text = message.memberData.nick
        if viewModel.shouldHideProfileImage {
            usernameTextView.removeFromSuperview()
        }
    }
}
