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
    
//    private var news: [New] = [
//                        New(title: "Title",
//                            body: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla finibus pellentesque lacus, ut dignissim est. Nam arcu ligula, aliquet non lacinia id, tempor id ante. Donec et dolor vestibulum, molestie dolor at, imperdiet leo. Nullam auctor vehicula purus, sit amet cursus eros iaculis at. Nullam interdum eu lacus ac efficitur. Aenean eu augue tempus, feugiat tortor quis, sodales ante. Duis vehicula erat sit amet iaculis tincidunt. Ut urna neque, tincidunt vitae aliquet in, blandit vitae ipsum. Curabitur a ipsum nec dui vestibulum tincidunt. Duis imperdiet vel erat a elementum.",
//                            epil: "Epil",
//                            date: "10.10.10"),
//                        New(title: "Title",
//                            body: "Curabitur finibus nulla ac volutpat lobortis. In nec nulla in ligula rutrum dapibus. Etiam pharetra hendrerit vehicula. Etiam vitae est facilisis erat ultrices egestas. Nunc eros sem, pellentesque non mi iaculis, porta consectetur nisi. Nam sed vestibulum neque. Integer sed fermentum lorem. Etiam porta leo risus, ut dapibus neque iaculis mattis. Proin a orci tempor, ultricies orci a, consectetur massa. Mauris cursus dignissim nisl nec congue.",
//                            epil: "Epil",
//                            date: "10.10.10"),
//                        New(title: "Title",
//                            body: "Nulla a nibh iaculis erat porta rhoncus nec posuere velit. Morbi arcu erat, molestie non justo posuere, maximus ultricies quam. In ornare elit a est facilisis blandit. Integer ornare fermentum molestie. Ut gravida malesuada purus, sit amet pulvinar erat lobortis sagittis. Nulla rutrum est nec elit consectetur pretium. Donec vitae quam eros. Praesent ut lectus sollicitudin, varius odio non, tempus purus. Nulla vestibulum, urna eu placerat consectetur, sapien justo porta purus, a dictum metus mauris ut neque. Suspendisse potenti. Maecenas rutrum commodo ante, nec congue enim vestibulum id.",
//                            epil: "Epil",
//                            date: "10.10.10")]
    
    private var news = [New]()
    
    private let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: UICollectionViewFlowLayout())
    
    //MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        tabBarController?.tabBar.overrideUserInterfaceStyle = .light
        configureBaseUI(withNavBarTitle: "News", withNavBarColor: .systemPurple, navBarPrefersLargeTitles: false)
        configureCollectionView()
        
        print("Trying to fetch")
        NewsService.shared.fetchNews(forGroupId: 1) { (news) in
            self.news = news
            self.collectionView.reloadData()
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

