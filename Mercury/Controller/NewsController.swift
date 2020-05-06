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
    
    //MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        tabBarController?.tabBar.overrideUserInterfaceStyle = .light
        configureBaseUI(withNavBarTitle: "News", withNavBarColor: .systemPurple, navBarPrefersLargeTitles: false)
        configureCollectionView()
        
        //fetchNews(forGroupId: 1)
        DataRepository.shared.authUser(login: "rollingworld", hash: "356a192b7913b04c54574d18c28d46e6395428ab") { (user) in
            print(user.memberData?.nick)
        }
    }

    //MARK: Helpers
    
    func configureCollectionView() {
        collectionView.backgroundColor = #colorLiteral(red: 0.8899991512, green: 0.8901486993, blue: 0.8899795413, alpha: 1)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(NewCell.self, forCellWithReuseIdentifier: reuseId)
        view.addSubview(collectionView)
        collectionView.frame = view.frame
        collectionView.alwaysBounceVertical = true
    }
    
    //MERK: API
    
    func fetchNews(forGroupId: Int) {
        showLoader(true)
        NewsService.shared.fetchNews(forGroupId: forGroupId) { (news) in
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

