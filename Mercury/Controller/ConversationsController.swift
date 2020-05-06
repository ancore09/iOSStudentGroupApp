//
//  ThirdViewController.swift
//  Mercury
//
//  Created by Andrey  Grechko on 03.05.2020.
//  Copyright © 2020 Andrey Grechko. All rights reserved.
//

import UIKit

private let reuseId = "LessonCell"

class ConversationsController: UIViewController {

    //MARK: Properties
    
    private let tableView = UITableView()
     
    //MARK: Lifecycle
     
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        configureBaseUI(withNavBarTitle: "Chat", withNavBarColor: .systemPurple, navBarPrefersLargeTitles: false)
        configureUI()
    }
     
    //MARK: Selectors
     
    //MARK: Helpers
    
    func configureUI() {
        overrideUserInterfaceStyle = .light
        view.backgroundColor = .white

        configureTableView()
    }
    
    func configureTableView() {
        tableView.backgroundColor = .white
        tableView.rowHeight = 80
        tableView.register(ConversationCell.self, forCellReuseIdentifier: reuseId)
        tableView.tableFooterView = UIView()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        view.addSubview(tableView)
        tableView.frame = view.frame
    }
     
    //MARK: API
}

extension ConversationsController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseId, for: indexPath) as! ConversationCell
        cell.groupName = DataRepository.shared.groups![indexPath.row].NameInfo
        return cell
    }
    
    
}

extension ConversationsController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let group = DataRepository.shared.groups![indexPath.row]
        let controller = ChatController(group: group)
        navigationController?.pushViewController(controller, animated: true)
    }
}


