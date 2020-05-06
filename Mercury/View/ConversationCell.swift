//
//  ConversationCell.swift
//  ChatApp
//
//  Created by Andrey  Grechko on 05.05.2020.
//  Copyright © 2020 Andrey Grechko. All rights reserved.
//

import UIKit

class ConversationCell: UITableViewCell {
    
    //MARK: Properties
    
    var group: Group? {
        didSet { configure() }
    }
    
    private let profileImgeView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .systemGray
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    private let timestampLabel: UILabel = {
        let label = UILabel()
        label.text = "2h"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .darkGray
        return label
    }()
    
    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    private let messageTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    //MARK: Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(profileImgeView)
        profileImgeView.anchor(left: leftAnchor, paddingLeft: 12)
        profileImgeView.setDimensions(height: 50, width: 50)
        profileImgeView.layer.cornerRadius = 50 / 2
        profileImgeView.centerY(inView: self)
        
        let stack = UIStackView(arrangedSubviews: [usernameLabel, messageTextLabel])
        stack.axis = .vertical
        stack.spacing = 4
        
        addSubview(stack)
        stack.centerY(inView: profileImgeView)
        stack.anchor(left: profileImgeView.rightAnchor, right: rightAnchor, paddingLeft: 12, paddingRight: 16)
        
        addSubview(timestampLabel)
        timestampLabel.anchor(top: topAnchor, right: rightAnchor, paddingTop: 20, paddingRight: 12)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Helpers
    
    func configure() {
        usernameLabel.text = group?.NameInfo
    }
    
}
