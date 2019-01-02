//
//  discoverView.swift
//  Summer
//
//  Created by Artesia Ko on 12/24/18.
//  Copyright © 2018 Yanlam. All rights reserved.
//

import UIKit
import Firebase

class DiscoverController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate, UISearchBarDelegate, UISearchDisplayDelegate {
    
    weak var delegate: showChat?
    
    var collectionView: UICollectionView!
    var searchController: UISearchBar!
    
    var viewHeight: CGFloat!
    var viewWidth: CGFloat!
    
    var people: [Person] = []
    var selected_people: [Person] = []
    var me: Person?
    let cellId = "cellId"
   
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.navigationBar.prefersLargeTitles = false
        loadPeople()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.barTintColor = UIColor(red: 133/255, green: 226/255, blue: 209/255, alpha: 1)
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.white]
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.isTranslucent = false
    
        viewHeight = view.frame.height
        viewWidth = view.frame.width
        
        searchController = UISearchBar()
        searchController.translatesAutoresizingMaskIntoConstraints = false
        searchController.sizeToFit()
        searchController.barTintColor = UIColor(red: 133/255, green: 226/255, blue: 209/255, alpha: 1)
        searchController.backgroundImage = UIImage()
        searchController.isTranslucent = false
        searchController.layer.borderWidth = 0
        searchController.tintColor = .black
        searchController.delegate = self
        searchController.placeholder = "Username"
        view.addSubview(searchController)
        definesPresentationContext = true
        NSLayoutConstraint.activate([
            searchController.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchController.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchController.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ])
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.alwaysBounceVertical = true
        collectionView.register(personCVC.self, forCellWithReuseIdentifier: cellId)
        collectionView.showsVerticalScrollIndicator = false
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: searchController.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if let searchText = searchController.text?.lowercased() {
            if !searchText.isEmpty {
                selected_people = people.filter{($0.username?.lowercased().contains(searchText))!}
                collectionView?.reloadData()
            }
            else {
                selected_people = []
                collectionView?.reloadData()
            }
        }
    }
    
    func loadPeople() {
        people = []
        selected_people = []
        Database.database().reference().child("users").observe(.childAdded, with: { (dataSnapshot) in
            if let dictionary = dataSnapshot.value as? [String: AnyObject] {
                let user = Person()
                user.name = dictionary["name"] as? String
                user.profileImageName = dictionary["profileImageURL"] as? String
                user.email = dictionary["email"] as? String
                user.username = dictionary["username"] as? String
                user.id = dataSnapshot.key
                if (user.email != self.me?.email) {
                    self.people.append(user)
                }
                DispatchQueue.main.async {
                    self.collectionView?.reloadData()
                }
            }
        }, withCancel: nil)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return selected_people.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! personCVC
        let person = selected_people[indexPath.item]
        cell.nameLabel.text = person.name
        cell.usernameLabel.text = person.username
        cell.circleImage.image = UIImage(named: "")
        if let profileImageURL = person.profileImageName {
            cell.circleImage.loadImage(urlString: profileImageURL)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 75)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.navigationController?.popViewController(animated: true)
        self.delegate?.presentChat(user: selected_people[indexPath.item])
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        collectionView?.collectionViewLayout.invalidateLayout()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
