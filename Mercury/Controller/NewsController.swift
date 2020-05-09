//
//  FirstViewController.swift
//  Mercury
//
//  Created by Andrey  Grechko on 03.05.2020.
//  Copyright © 2020 Andrey Grechko. All rights reserved.
//

import UIKit

private let reuseId = "NewCell"

class NewsController: UIViewController {
    
    //MARK: Properties
    
    private var news = [New]()
    
    private let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: UICollectionViewFlowLayout())
    
    private let addNewButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.backgroundColor = .systemBlue
        button.tintColor = .white
        button.imageView?.setDimensions(height: 24, width: 24)
        button.setDimensions(height: 56, width: 56)
        button.layer.cornerRadius = 56 / 2
        button.addTarget(self, action: #selector(showNewForm), for: .touchUpInside)
        return button
    }()
    
    //MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        tabBarController?.tabBar.overrideUserInterfaceStyle = .light
        configureBaseUI(withNavBarTitle: "News", withNavBarColor: .systemPurple, navBarPrefersLargeTitles: false)
        configureUI()
        
        var ids = [Int]()
        DataRepository.shared.groups?.forEach({ (group) in
            ids.append(group.ID)
        })
        fetchNews(forGroupIds: ids)
    }
    
    //MARK: Selectors
    
    @objc func showNewForm() {
        let controller = NewAdditionFromController()
        navigationController?.pushViewController(controller, animated: true)
    }

    //MARK: Helpers
    
    func configureUI() {
        configureCollectionView()
        
        view.addSubview(addNewButton)
        addNewButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingBottom: 16, paddingRight: 24)
    }
    
    func configureCollectionView() {
        collectionView.backgroundColor = #colorLiteral(red: 0.8899991512, green: 0.8901486993, blue: 0.8899795413, alpha: 1)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(NewCell.self, forCellWithReuseIdentifier: reuseId)
        view.addSubview(collectionView)
        collectionView.frame = view.frame
        collectionView.alwaysBounceVertical = true
    }
    
    //MARK: API
    
    func fetchNews(forGroupIds: [Int]) {
        showLoader(true)
        NewsService.shared.fetchNews(forGroupIds: forGroupIds) { (news) in
            self.showLoader(false)
            self.news = news
            self.collectionView.reloadData()
        }
    }
}

    //MARK: CollectionViewStuff

extension NewsController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return news.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseId, for: indexPath) as! NewCell
        cell.new = news[indexPath.row]
        cell.backgroundColor = .white
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 16, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 50 )
        let estimatedSizeCell = NewCell(frame: frame)
        estimatedSizeCell.new = news[indexPath.row]
        estimatedSizeCell.layoutIfNeeded()
        
        let targetSize = CGSize(width: view.frame.width, height: 1000)
        let estimatedSize = estimatedSizeCell.systemLayoutSizeFitting(targetSize)
        
        return .init(width: view.frame.width, height: estimatedSize.height)
    }
}

