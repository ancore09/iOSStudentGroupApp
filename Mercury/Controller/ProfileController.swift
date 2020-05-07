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
    
    private let logoutButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Log Out", for: .normal)
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.setHeight(height: 50)
        button.setWidth(width: 100)
        button.isEnabled = true
        button.addTarget(self, action: #selector(handleLogout), for: .touchUpInside)
        return button
    }()
    
    //MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        configureBaseUI(withNavBarTitle: "Profile", withNavBarColor: .systemPurple, navBarPrefersLargeTitles: false)
        configureUI()
    }
    
    //MARK: Selectors
    
    @objc func handleLogout() {
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: Keys.LOGINKEY)
        defaults.removeObject(forKey: Keys.PASSHASHKEY)
        self.performSegue(withIdentifier: "logout", sender: nil)
    }
    
    //MARK: Helpers
    
    func configureUI() {
        view.addSubview(logoutButton)
        logoutButton.centerX(inView: view)
        logoutButton.centerY(inView: view)
    }
    
    //MARK: API

}

