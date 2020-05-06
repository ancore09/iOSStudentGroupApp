//
//  ThirdViewController.swift
//  Mercury
//
//  Created by Andrey  Grechko on 03.05.2020.
//  Copyright © 2020 Andrey Grechko. All rights reserved.
//

import UIKit

private let reuseId = "LessonCell"

class ChatController: UIViewController {

    //MARK: Properties
     
     //MARK: Lifecycle
     
     override func viewDidLoad() {
         super.viewDidLoad()
         overrideUserInterfaceStyle = .light
         configureBaseUI(withNavBarTitle: "Chat", withNavBarColor: .systemPurple, navBarPrefersLargeTitles: false)
     }
     
     //MARK: Selectors
     
     //MARK: Helpers
     
     //MARK: API
}


