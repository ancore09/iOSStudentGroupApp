//
//  ThirdViewController.swift
//  Mercury
//
//  Created by Andrey  Grechko on 03.05.2020.
//  Copyright © 2020 Andrey Grechko. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        configureBaseUI(withNavBarTitle: "Chat", withNavBarColor: .systemPurple, navBarPrefersLargeTitles: false)
    }

}
