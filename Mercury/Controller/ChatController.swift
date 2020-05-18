//
//  ChatController.swift
//  Mercury
//
//  Created by Andrey  Grechko on 06.05.2020.
//  Copyright © 2020 Andrey Grechko. All rights reserved.
//

import UIKit
import Nuke

private let reuseId = "MessageCell"

class ChatController: UICollectionViewController {
    
    //MARK: Properties
    
    private let group: Group
    
    private var messages = [Message]()
    private var fromCurrentUser = false
    
    private lazy var customInputView: CustomInputAccessoryView = {
        let iv = CustomInputAccessoryView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 50))
        iv.delegate = self
        return iv
    }()
    
    //MARK: Lifecycle
    
    init(group: Group) {
        self.group = group
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        fetchMessages()
        DataRepository.shared.initSocket(forGroup: group) { (message) in
            self.messages.append(message)
            self.collectionView.reloadData()
            self.collectionView.scrollToItem(at: [0, self.messages.count - 1], at: .bottom, animated: true)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavigationBar(withTitle: group.NameInfo, prefersLargeTitles: false)
    }
    
    override var inputAccessoryView: UIView? {
        get { return customInputView }
    }
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    //MARK: API
    
    func fetchMessages() {
        let result = group.NameInfo.replacingOccurrences(of: "\\s", with: "", options: .regularExpression)
        DataRepository.shared.fetchMessages(forRoom: result) { (messages) in
            self.messages = messages
            self.collectionView.reloadData()
            self.collectionView.scrollToItem(at: [0, self.messages.count - 1], at: .bottom, animated: true)
        }
    }
    
    //MARK: Helpers
    
    func configureUI() {
        overrideUserInterfaceStyle = .light
        collectionView.backgroundColor = .white
        
        collectionView.register(MessageCell.self, forCellWithReuseIdentifier: reuseId)
        collectionView.alwaysBounceVertical = true
        
        collectionView.keyboardDismissMode = .interactive
    }
}

extension ChatController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseId, for: indexPath) as! MessageCell
        cell.message = messages[indexPath.row]
        
        if messages[indexPath.row].fileHash == nil {
            return cell
        } else if messages[indexPath.row].fileHash == "" {
            return cell
        } else {
            let url = "http://194.67.92.182:3001/\(messages[indexPath.row].fileHash!)"
            var options = ImageLoadingOptions.shared
            options.contentModes?.success = .scaleToFill
            Nuke.loadImage(with: URL(string: url)!, options: options, into: cell.attachedImageView)
            return cell
        }
    }
}

extension ChatController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 16, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 50 )
        let estimatedSizeCell = MessageCell(frame: frame)
        estimatedSizeCell.message = messages[indexPath.row]
        estimatedSizeCell.layoutIfNeeded()
        
        let targetSize = CGSize(width: view.frame.width, height: 1000)
        let estimatedSize = estimatedSizeCell.systemLayoutSizeFitting(targetSize)
        
        return .init(width: view.frame.width, height: estimatedSize.height)
    }
}

extension ChatController: CustomInputAccessoryViewDelegate {
    func inputView(_ inputView: CustomInputAccessoryView, wantsToSend message: String) {
        let message = Message(id: 0, body: message, memberData: DataRepository.shared.user!.memberData!, filehash: "")
        
        DataRepository.shared.sendMessage(forGroup: group, message: message)
        inputView.clearMessageText()
    }
}


