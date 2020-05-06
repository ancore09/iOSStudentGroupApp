//
//  ProfileController.swift
//  Mercury
//
//  Created by Andrey  Grechko on 06.05.2020.
//  Copyright © 2020 Andrey Grechko. All rights reserved.
//

import UIKit

class ProfileController: UIViewController {

    //MARK: Properties
    
    //MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        configureBaseUI(withNavBarTitle: "Profile", withNavBarColor: .systemPurple, navBarPrefersLargeTitles: false)
    }
    
    //MARK: Selectors
    
    //MARK: Helpers
    
    //MARK: API

}

