//
//  SecondViewController.swift
//  Mercury
//
//  Created by Andrey  Grechko on 03.05.2020.
//  Copyright © 2020 Andrey Grechko. All rights reserved.
//

import UIKit

private let reuseId = "LessonCell"

class JournalController: UIViewController {
    
    //MARK: Properties
    
    private var lessons = [Lesson]()
    
    private let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: UICollectionViewFlowLayout())
    
    private let addLessonButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.backgroundColor = .systemBlue
        button.tintColor = .white
        button.imageView?.setDimensions(height: 24, width: 24)
        button.setDimensions(height: 56, width: 56)
        button.layer.cornerRadius = 56 / 2
        button.addTarget(self, action: #selector(showLessonForm), for: .touchUpInside)
        return button
    }()
    
    //MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        configureBaseUI(withNavBarTitle: "Journal", withNavBarColor: .systemPurple, navBarPrefersLargeTitles: false)
        configureUI()
        
        fetchLessons()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavigationBar(withTitle: "Journal", prefersLargeTitles: false)
    }
    
    //MARK: Selectors
    
    @objc func showLessonForm() {
        let controller = LessonAdditionFromController()
        navigationController?.pushViewController(controller, animated: true)
    }
    
    //MARK: Helpers
    
    func configureUI() {
        configureCollectionView()
        
        view.addSubview(addLessonButton)
        addLessonButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingBottom: 16, paddingRight: 24)
    }
    
    func configureCollectionView() {
        collectionView.backgroundColor = #colorLiteral(red: 0.8899991512, green: 0.8901486993, blue: 0.8899795413, alpha: 1)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(LessonCell.self, forCellWithReuseIdentifier: reuseId)
        view.addSubview(collectionView)
        collectionView.frame = view.frame
        collectionView.alwaysBounceVertical = true
    }
    
    //MARK: API
    
    func fetchLessons() {
        showLoader(true)
        LessonService.shared.fetchLessons(forGroups: DataRepository.shared.groups!, forUserId: DataRepository.shared.user!.ID) { (lessons) in
            self.showLoader(false)
            self.lessons = lessons
            self.collectionView.reloadData()
        }
    }
}

extension JournalController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return lessons.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseId, for: indexPath) as! LessonCell
        cell.lesson = lessons[indexPath.row]
        cell.backgroundColor = .white
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 16, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 50 )
        let estimatedSizeCell = LessonCell(frame: frame)
        estimatedSizeCell.lesson = lessons[indexPath.row]
        estimatedSizeCell.layoutIfNeeded()
        
        let targetSize = CGSize(width: view.frame.width, height: 1000)
        let estimatedSize = estimatedSizeCell.systemLayoutSizeFitting(targetSize)
        
        return .init(width: view.frame.width, height: estimatedSize.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let controller = LessonDetailsController(lesson: lessons[indexPath.row])
        navigationController?.pushViewController(controller, animated: true)
    }
}

