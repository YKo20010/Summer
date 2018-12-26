//
//  ViewController.swift
//  Summer
//
//  Created by Artesia Ko on 12/24/18.
//  Copyright © 2018 Yanlam. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate {
    
    let cellId = "cellId"
    var collectionView: UICollectionView!
    
    var viewHeight: CGFloat!
    var viewWidth: CGFloat!
    
    var messages: [Message]?
    
    var email: String = ""
    
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.title = "Messages"
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.white]
        navigationController?.navigationBar.prefersLargeTitles = true
        loadMessages()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.barTintColor = UIColor(red: 133/255, green: 226/255, blue: 209/255, alpha: 1)
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.white]
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.white]
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.backgroundColor = UIColor(red: 133/255, green: 226/255, blue: 209/255, alpha: 1)
    
        viewHeight = view.frame.height
        viewWidth = view.frame.width
        
        let newBarButton = UIBarButtonItem(title: "New", style: .plain, target: self, action: #selector(discover))
        self.navigationItem.rightBarButtonItem = newBarButton
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        //UIColor(red: 133/255, green: 226/255, blue: 209/255, alpha: 1)
        collectionView.backgroundColor = UIColor(red: 133/255, green: 226/255, blue: 209/255, alpha: 1)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.alwaysBounceVertical = true
        collectionView.register(homeCVC.self, forCellWithReuseIdentifier: cellId)
        collectionView.showsVerticalScrollIndicator = false
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            ])
        
        loadMessages()
    }
    
    @objc func discover() { //newBarButton
        let discoverController = DiscoverController()
        discoverController.email = self.email
        self.navigationController?.pushViewController(discoverController, animated: true)
    }
    
    func loadMessages() {
        let mark = Person()
        mark.name = "Mark Zuckerberg"
        mark.profileImageName = "pp2"
        let mMark = Message()
        mMark.person = mark
        mMark.text = "Hi I'm Mark."
        mMark.date = Date()
        
        let steve = Person()
        steve.name = "Steve Jobs"
        steve.profileImageName = "pp3"
        let mSteve = Message()
        mSteve.person = steve
        mSteve.text = "Hi I'm Steve."
        mSteve.date = Date()
        
        messages = [mMark, mSteve]
        
//        DispatchQueue.main.async {
//            self.collectionView.reloadData()
//        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = messages?.count {
            return count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! homeCVC
        
        if let message = messages?[indexPath.item] {
            cell.message = message
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 100)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

