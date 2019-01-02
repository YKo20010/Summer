//
//  ChatController.swift
//  Summer
//
//  Created by Artesia Ko on 12/24/18.
//  Copyright © 2018 Yanlam. All rights reserved.
//

import UIKit
import Firebase

class ChatController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate, UITextFieldDelegate {
    var viewHeight: CGFloat!
    var viewWidth: CGFloat!
    
    var user: Person? {
        didSet {
            navigationItem.title = user?.name
        }
    }
    
    var me: Person?
    
    let cellId = "cellId"
    var collectionView: UICollectionView!
    
    var messages = [Message]()
    
    let sep: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 211/255, green: 211/255, blue: 211/255, alpha: 1)
        return view
    }()
    
    let inputTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "Enter message..."
        return tf
    }()
    
    let sendButton: UIButton = {
        let b = UIButton(type: .system)
        b.translatesAutoresizingMaskIntoConstraints = false
        b.setImage(UIImage(named: "iconSend"), for: .normal)
        b.contentMode = .scaleAspectFit
        b.tintColor = UIColor(red: 133/255, green: 226/255, blue: 209/255, alpha: 1)
        return b
    }()
    
    let containerView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = UIColor.white
        return v
    }()
    
    func loadMessages() {
        messages = []
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let ref = Database.database().reference().child("user-messages").child(uid)
        ref.observe(.childAdded, with: { (snapshot) in
            let messageId = snapshot.key
            let messageRef = Database.database().reference().child("messages").child(messageId)
            messageRef.observeSingleEvent(of: .value, with: { (snapshot) in
                guard let dictionary = snapshot.value as? [String: AnyObject] else { return }
                let message = Message()
                message.fromId = dictionary["fromId"] as? String
                message.toId = dictionary["toId"] as? String
                message.text = dictionary["text"] as? String
                message.timestamp = dictionary["timestamp"] as? Double
                if (message.chatPartnerId() == self.user?.id) {
                    self.messages.append(message)
                    DispatchQueue.main.async {
                        self.collectionView?.reloadData()
                        guard let cv = self.collectionView else { return }
                        let index = IndexPath(item: self.collectionView(self.collectionView, numberOfItemsInSection: 0) - 1, section: 0)
                        self.collectionView?.scrollToItem(at: index, at: .bottom, animated: true)
                    }
                }
            }, withCancel: nil)
        }, withCancel: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.navigationBar.prefersLargeTitles = false
        loadMessages()
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
        
        view.addSubview(containerView)
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            containerView.heightAnchor.constraint(equalToConstant: 50)
            ])
        
        sendButton.addTarget(self, action: #selector(send), for: .touchDown)
        containerView.addSubview(sendButton)
        NSLayoutConstraint.activate([
            sendButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8),
            sendButton.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            sendButton.heightAnchor.constraint(equalTo: containerView.heightAnchor, constant: -20),
            sendButton.widthAnchor.constraint(equalTo: containerView.heightAnchor, constant: -16)
            ])
        inputTextField.delegate = self
        containerView.addSubview(inputTextField)
        NSLayoutConstraint.activate([
            inputTextField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
            inputTextField.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            inputTextField.trailingAnchor.constraint(equalTo: sendButton.leadingAnchor),
            inputTextField.heightAnchor.constraint(equalTo: containerView.heightAnchor)
            ])
        containerView.addSubview(sep)
        NSLayoutConstraint.activate([
            sep.topAnchor.constraint(equalTo: containerView.topAnchor),
            sep.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            sep.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            sep.heightAnchor.constraint(equalToConstant: 0.5)
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
        collectionView.register(messageCVC.self, forCellWithReuseIdentifier: cellId)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.contentInset = UIEdgeInsetsMake(8, 0, 8, 0)
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: containerView.topAnchor)
            ])
    }
    
    @objc func send() { //sendButton
        if let message = inputTextField.text, message != "" {
            let ref = Database.database().reference().child("messages")
            let childRef = ref.childByAutoId()
            let toID = user!.id!
            let fromID = Auth.auth().currentUser!.uid
            let timestamp = Date().timeIntervalSince1970
            let values = ["text": message, "toId": toID, "fromId": fromID, "timestamp": timestamp] as [String : Any]
            childRef.updateChildValues(values) { (error, ref) in
                if error != nil {
                    print(error)
                    return
                }
                let fromRef = Database.database().reference().child("user-messages").child(fromID)
                let toRef = Database.database().reference().child("user-messages").child(toID)
                if let messageId = childRef.key {
                    fromRef.updateChildValues([messageId: 1])
                    toRef.updateChildValues([messageId: 1])
                }
            }
            inputTextField.text = ""
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        send()
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! messageCVC
        let message = messages[indexPath.item]
        cell.textView.text = message.text
        if let fromId = message.fromId {
            if fromId == user?.id {     //from other person
                cell.sep.backgroundColor = UIColor(red: 82/255, green: 177/255, blue: 211/255, alpha: 1.0)
                cell.userLabel.textColor = UIColor(red: 82/255, green: 177/255, blue: 211/255, alpha: 1.0)
                cell.userLabel.text = user?.name?.uppercased()
            }
            else {                      //from self
                cell.sep.backgroundColor = UIColor(red: 80/255, green: 95/255, blue: 211/255, alpha: 1.0)
                cell.userLabel.textColor = UIColor(red: 80/255, green: 95/255, blue: 211/255, alpha: 1.0)
                cell.userLabel.text = me?.name?.uppercased()
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var h: CGFloat = 80
        if let text = messages[indexPath.item].text {
            h = estimatedHeightForText(text: text).height + 40
        }
        return CGSize(width: view.frame.width, height: h)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        collectionView?.collectionViewLayout.invalidateLayout()
    }
    
    private func estimatedHeightForText(text: String) -> CGRect {
        let size = CGSize(width: view.frame.width - 3.0 * 8.0 - 1, height: 1000)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        return NSString(string: text).boundingRect(with: size, options: options, attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 16, weight: .light)], context: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
