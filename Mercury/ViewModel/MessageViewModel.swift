//
//  MessageViewModel.swift
//  ChatApp
//
//  Created by Andrey  Grechko on 05.05.2020.
//  Copyright © 2020 Andrey Grechko. All rights reserved.
//

import UIKit

struct MessageViewModel {
    
    private let message: Message
    
    var messageBackgroundColor: UIColor {
        return message.memberData.nick == DataRepository.shared.user?.memberData?.nick ? #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1) : .systemPurple
    }
    
    var messageTextColor: UIColor {
        return (message.memberData.nick == DataRepository.shared.user?.memberData?.nick) ? .black : .white
    }
    
    var rightAnchorActive: Bool {
        //print(message.memberData.nick)
        //print(DataRepository.shared.user?.memberData?.nick)
        return (message.memberData.nick == DataRepository.shared.user?.memberData?.nick)
    }
    
    var leftAnchorActive: Bool {
        return !(message.memberData.nick == DataRepository.shared.user?.memberData?.nick)
    }
    
    var shouldHideProfileImage: Bool {
        return (message.memberData.nick == DataRepository.shared.user?.memberData?.nick)
    }
    
    var profileImageUrl: URL? {
        //guard let user = DataRepository.user else { return nil }
        return URL(string: "")
    }
    
    var hasImage: Bool {
        return !message.fileHash!.isEmpty
    }
    
    init(message: Message) {
        self.message = message
    }
}
