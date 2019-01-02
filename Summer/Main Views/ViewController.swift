//
//  ViewController.swift
//  Summer
//
//  Created by Artesia Ko on 12/24/18.
//  Copyright © 2018 Yanlam. All rights reserved.
//

import UIKit
import Firebase

protocol showChat: class {
    func presentChat(user: Person)
}

class ViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var me: Person?
    
    let cellId = "cellId"
    var collectionView: UICollectionView!
    
    var viewHeight: CGFloat!
    var viewWidth: CGFloat!
    
    var messages: [Message] = []
    var strToMessage = [String : Message]()
    
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
    }
    
    @objc func discover() { //newBarButton
        let discoverController = DiscoverController()
        discoverController.me = self.me
        discoverController.delegate = self
        self.navigationController?.pushViewController(discoverController, animated: true)
    }
    
    @objc func showChatController(user: Person) {
        let chatController = ChatController()
        chatController.user = user
        chatController.me = me
        self.navigationController?.pushViewController(chatController, animated: true)
    }
    
    func loadAllMessages() {
        messages = []
        let ref = Database.database().reference().child("messages")
        ref.observe(.childAdded, with: { (snapshot) in
            if let dictionary = snapshot.value as? [String: AnyObject] {
                let message = Message()
                message.fromId = dictionary["fromId"] as? String
                message.toId = dictionary["toId"] as? String
                message.text = dictionary["text"] as? String
                message.timestamp = dictionary["timestamp"] as? Double
                self.messages.append(message)
                if let toId = message.toId {
                    self.strToMessage[toId] = message
                    self.messages = Array(self.strToMessage.values)
                    self.messages.sort(by: { (m1, m2) -> Bool in
                        return m1.timestamp! > m2.timestamp!
                    })
                }
                DispatchQueue.main.async {
                    self.collectionView?.reloadData()
                }
            }
        }, withCancel: nil)
    }
    
    func loadMessages() {
        messages = []
        strToMessage = [:]
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let ref = Database.database().reference().child("user-messages").child(uid)
        ref.observe(.childAdded, with: { (snapshot) in
            let messageId = snapshot.key
            let messageReference = Database.database().reference().child("messages").child(messageId)
            messageReference.observeSingleEvent(of: .value, with: { (snapshot) in
                if let dictionary = snapshot.value as? [String: AnyObject] {
                    let message = Message()
                    message.fromId = dictionary["fromId"] as? String
                    message.toId = dictionary["toId"] as? String
                    message.text = dictionary["text"] as? String
                    message.timestamp = dictionary["timestamp"] as? Double
                    self.messages.append(message)
                    guard let id = message.chatPartnerId() else { return }
                    self.strToMessage[id] = message
                    self.messages = Array(self.strToMessage.values)
                    self.messages.sort(by: { (m1, m2) -> Bool in
                        return m1.timestamp! > m2.timestamp!
                    })
                    DispatchQueue.main.async {
                        self.collectionView?.reloadData()
                    }
                }
            }, withCancel: nil)
        }, withCancel: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! homeCVC
        let message = messages[indexPath.item]
        cell.message = message
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let message = messages[indexPath.row]
        guard let id = message.chatPartnerId() else { return }
        let ref = Database.database().reference().child("users").child(id)
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            guard let dictionary = snapshot.value as? [String: AnyObject] else { return }
            let user = Person()
            user.name = dictionary["name"] as? String
            user.profileImageName = dictionary["profileImageURL"] as? String
            user.email = dictionary["email"] as? String
            user.username = dictionary["username"] as? String
            user.id = snapshot.key
            self.showChatController(user: user)
        }, withCancel: nil)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        collectionView?.collectionViewLayout.invalidateLayout()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

extension ViewController: showChat {
    func presentChat(user: Person) {
        showChatController(user: user)
    }
}


