//
//  ChatController.swift
//  Summer
//
//  Created by Artesia Ko on 12/24/18.
//  Copyright © 2018 Yanlam. All rights reserved.
//

import UIKit
import Firebase

protocol sendDrawing: class {
    func sendDrawing(image: UIImage)
}

class ChatController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate, UITextFieldDelegate, UIGestureRecognizerDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    var viewHeight: CGFloat!
    var viewWidth: CGFloat!
    var messages = [Message]()
    let cellId = "cellId"
    
    var containerViewBottomAnchor: NSLayoutConstraint?
    
    var me: Person?
    var user: Person? {
        didSet {
            navigationItem.title = user?.name
        }
    }
    
    var collectionView: UICollectionView!
    var pan: UIPanGestureRecognizer!
    let sep: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Static.customGray
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
        b.tintColor = Static.lightAqua
        return b
    }()
    let uploadImageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.image = UIImage(named: "iconImage")?.withRenderingMode(.alwaysTemplate)
        iv.tintColor = Static.customGray
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    let drawImageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.image = UIImage(named: "iconDraw")?.withRenderingMode(.alwaysTemplate)
        iv.tintColor = Static.customGray
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    let containerView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = UIColor.white
        return v
    }()
    
    /*********************     SET UP VIEWS    ********************/
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.title = user?.name
        setUpKeyboard()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.barTintColor = Static.lightAqua
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.white]
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.isTranslucent = false
        
        viewHeight = view.frame.height
        viewWidth = view.frame.width
        
        self.setUpContainerView()
        
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
        
        setUpKeyboard()
        
        pan = UIPanGestureRecognizer(target: self, action: #selector(onPan(_:)))
        pan.delegate = self
        view.addGestureRecognizer(pan)
        
        loadMessages()
    }
    
    private func setUpContainerView() {
        view.addSubview(containerView)
        containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        containerView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        containerViewBottomAnchor = containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        containerViewBottomAnchor?.isActive = true
        
        uploadImageView.isUserInteractionEnabled = true
        uploadImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(pickImage)))
        containerView.addSubview(uploadImageView)
        uploadImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8).isActive = true
        uploadImageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        uploadImageView.widthAnchor.constraint(equalTo: containerView.heightAnchor, constant: -16).isActive = true
        uploadImageView.heightAnchor.constraint(equalTo: containerView.heightAnchor, constant: -16).isActive = true
        
        drawImageView.isUserInteractionEnabled = true
        drawImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(draw)))
        containerView.addSubview(drawImageView)
        drawImageView.leadingAnchor.constraint(equalTo: uploadImageView.trailingAnchor, constant: 2).isActive = true
        drawImageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        drawImageView.widthAnchor.constraint(equalTo: containerView.heightAnchor, constant: -16).isActive = true
        drawImageView.heightAnchor.constraint(equalTo: containerView.heightAnchor, constant: -16).isActive = true
        
        sendButton.addTarget(self, action: #selector(send), for: .touchDown)
        containerView.addSubview(sendButton)
        sendButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8).isActive = true
        sendButton.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        sendButton.heightAnchor.constraint(equalTo: containerView.heightAnchor, constant: -20).isActive = true
        sendButton.widthAnchor.constraint(equalTo: containerView.heightAnchor, constant: -16).isActive = true
        
        inputTextField.delegate = self
        containerView.addSubview(inputTextField)
        inputTextField.leadingAnchor.constraint(equalTo: drawImageView.trailingAnchor, constant: 8).isActive = true
        inputTextField.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        inputTextField.trailingAnchor.constraint(equalTo: sendButton.leadingAnchor).isActive = true
        inputTextField.heightAnchor.constraint(equalTo: containerView.heightAnchor).isActive = true
     
        containerView.addSubview(sep)
        sep.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        sep.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        sep.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        sep.heightAnchor.constraint(equalToConstant: 0.5).isActive = true

    }
    
    @objc func draw() {
        let canvasController = CanvasController()
        canvasController.user = user
        canvasController.me = me
        canvasController.delegate = self
        self.navigationController?.pushViewController(canvasController, animated: true)
    }
    
    /*********************     IMAGE PICKER    ********************/
    @objc func pickImage() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.allowsEditing = true
        imagePickerController.delegate = self
        self.present(imagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        var selectedImage: UIImage?
        if let edit = info["UIImagePickerControllerEditedImage"] as? UIImage {
            selectedImage = edit
        }
        else if let original = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            selectedImage = original
        }
        if let image = selectedImage {
            self.uploadImageToFirebase(image: image)
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    private func uploadImageToFirebase(image: UIImage) {
        let imageName = NSUUID().uuidString
        let ref = Storage.storage().reference().child("message_images").child("\(imageName).jpg")
        if let uploadData = UIImageJPEGRepresentation(image, 0.2) {
            ref.putData(uploadData, metadata: nil) { (metadata, error) in
                if error != nil {
                    print(error)
                    return
                }
                ref.downloadURL(completion: { (downloadUrl, error) in
                    guard let url = downloadUrl else {return}
                    let imageUrl = url.absoluteString
                    self.sendImage(url: imageUrl, image: image)
                })
            }
        }
    }
    
    private func sendImage(url: String, image: UIImage) {
        let ref = Database.database().reference().child("messages")
        let childRef = ref.childByAutoId()
        let toID = user!.id!
        let fromID = Auth.auth().currentUser!.uid
        let timestamp = Date().timeIntervalSince1970
        let values = ["imageUrl": url, "imageHeight": image.size.height, "imageWidth": image.size.width, "toId": toID, "fromId": fromID, "timestamp": timestamp] as [String : Any]
        childRef.updateChildValues(values) { (error, ref) in
            if error != nil {
                print(error)
                return
            }
            let fromRef = Database.database().reference().child("user-messages").child(fromID).child(toID)
            let toRef = Database.database().reference().child("user-messages").child(toID).child(fromID)
            if let messageId = childRef.key {
                fromRef.updateChildValues([messageId: 1])
                toRef.updateChildValues([messageId: 1])
            }
        }
    }
    
    /*********************     LOAD / SEND MESSAGES    ********************/
    func loadMessages() {
        messages = []
        guard let uid = Auth.auth().currentUser?.uid, let toId = user?.id else { return }
        let ref = Database.database().reference().child("user-messages").child(uid).child(toId)
        ref.observe(.childAdded, with: { (snapshot) in
            let messageId = snapshot.key
            let messageRef = Database.database().reference().child("messages").child(messageId)
            messageRef.observeSingleEvent(of: .value, with: { (snapshot) in
                guard let dictionary = snapshot.value as? [String: AnyObject] else { return }
                let message = Message(dictionary: dictionary)
                if (message.chatPartnerId() == self.user?.id) {
                    self.messages.append(message)
                    DispatchQueue.main.async {
                        self.collectionView?.reloadData()
                        guard let cv = self.collectionView else { return }
                        let index = IndexPath(item: self.messages.count - 1, section: 0)
                        self.collectionView?.scrollToItem(at: index, at: .bottom, animated: true)
                    }
                }
            }, withCancel: nil)
        }, withCancel: nil)
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
                let fromRef = Database.database().reference().child("user-messages").child(fromID).child(toID)
                let toRef = Database.database().reference().child("user-messages").child(toID).child(fromID)
                if let messageId = childRef.key {
                    fromRef.updateChildValues([messageId: 1])
                    toRef.updateChildValues([messageId: 1])
                }
            }
            inputTextField.text = ""
        }
    }
    
    /*********************     TEXT FIELD FUNCTIONS    ********************/
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        send()
        return true
    }
    
    /*********************     COLLECTION VIEW FUNCTIONS    ********************/
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! messageCVC
        let message = messages[indexPath.item]
        cell.chatLogController = self
        if let text = message.text {
            cell.textView.text = text
            cell.textView.isHidden = false
            cell.messageImageView.isHidden = true
        }
        else if let url = message.imageUrl, let h = message.imageHeight, let w = message.imageWidth {
            let height = CGFloat(h / w * 250.0)
            let width = CGFloat(w / h) * height
            cell.messageImageView.loadImage(urlString: url)
            cell.imageWidthAnchor?.constant = width
            cell.imageHeightAnchor?.constant = height
            cell.messageImageView.isHidden = false
            cell.textView.isHidden = true
        }
        if let fromId = message.fromId {
            if fromId == user?.id {     //from other person
                cell.sep.backgroundColor = Static.lightBlue
                cell.userLabel.textColor = Static.lightBlue
                cell.timeLabel.textColor = Static.lightBlue
                cell.userLabel.text = user?.name?.uppercased()
            }
            else {                      //from self
                cell.timeLabel.textColor = Static.darkBlue
                cell.sep.backgroundColor = Static.darkBlue
                cell.userLabel.textColor = Static.darkBlue
                cell.userLabel.text = me?.name?.uppercased()
            }
        }
        if let time = message.timestamp {
            let date = Date(timeIntervalSince1970: time)
            let dif = date.timeIntervalSinceNow
            if (dif < -60*60*24) {
                let form2 = DateFormatter()
                form2.dateFormat = "MMM dd"
                cell.timeLabel.text = form2.string(from: date)
            }
            else {
                let form1 = DateFormatter()
                form1.dateFormat = "h:mm a"
                cell.timeLabel.text = form1.string(from: date)
            }
        }
        if indexPath.item != 0 && messages[indexPath.item - 1].fromId == message.fromId {
            cell.userLabel.isHidden = true
            cell.timeLabel.isHidden = true
            cell.sepTopAnchor?.isActive = false
            cell.sepTopAnchor2?.isActive = true
        }
        else {
            cell.userLabel.isHidden = false
            cell.timeLabel.isHidden = false
            cell.sepTopAnchor?.isActive = true
            cell.sepTopAnchor2?.isActive = false
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var height: CGFloat = 80
        
        let message = messages[indexPath.item]
        if let text = message.text {
            if indexPath.item != 0 && messages[indexPath.item - 1].fromId == message.fromId {
                height = estimatedHeightForText(text: text).height + 5
            }
            else {
                height = estimatedHeightForText(text: text).height + 25
            }
        }
        else if let url = message.imageUrl, let h = message.imageHeight, let w = message.imageWidth {
            if indexPath.item != 0 && messages[indexPath.item - 1].fromId == message.fromId {
                height = CGFloat(h / w * 250.0 + 20)
            }
            else {
                height = CGFloat(h / w * 250.0 + 40)
            }
        }
        return CGSize(width: view.frame.width, height: height)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        collectionView?.collectionViewLayout.invalidateLayout()
    }
    
    private func estimatedHeightForText(text: String) -> CGRect {
        let size = CGSize(width: view.frame.width - 25, height: 2000)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        return NSString(string: text).boundingRect(with: size, options: options, attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 16, weight: .light)], context: nil)
    }
    
    /*********************     ZOOM IMAGE FUNCTIONS   ********************/
    var startFrame: CGRect?
    var imageBackground: UIView?
    
    @objc func zoomOut(tapGesture: UITapGestureRecognizer) {
        if let zoomOutImageView = tapGesture.view {
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                if let frame = self.startFrame {
                    zoomOutImageView.frame = frame
                    self.imageBackground?.alpha = 0
                    self.containerView.alpha = 1
                }
            }) { (completed: Bool) in
                zoomOutImageView.removeFromSuperview()
            }
        }
    }
    
    func zoomImage(imageView: UIImageView) {
        startFrame = imageView.superview?.convert(imageView.frame, to: nil)
        let zoomImageView = UIImageView(frame: startFrame!)
        zoomImageView.image = imageView.image
        zoomImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(zoomOut)))
        zoomImageView.isUserInteractionEnabled = true
        
        if let keyWindow = UIApplication.shared.keyWindow {
            imageBackground = UIView(frame: keyWindow.frame)
            imageBackground?.backgroundColor = .white
            imageBackground?.alpha = 0
            keyWindow.addSubview(imageBackground!)
            keyWindow.addSubview(zoomImageView)
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                if let h = self.startFrame?.height, let w = self.startFrame?.width {
                    self.imageBackground?.alpha = 1
                    self.containerView.alpha = 0
                    var width: CGFloat = keyWindow.frame.width
                    var height: CGFloat = h / w * width
                    if h > keyWindow.frame.height {
                        height = keyWindow.frame.height
                        width =  w / h * height
                    }
                    
                    zoomImageView.frame = CGRect(x: 0, y: 0, width: width, height: height)
                    zoomImageView.center = keyWindow.center
                }
            }, completion: nil)
        }
    }
    
    
}

extension ChatController: sendDrawing {
    func sendDrawing(image: UIImage) {
        let imageName = NSUUID().uuidString
        let ref = Storage.storage().reference().child("message_images").child("\(imageName).jpg")
        if let uploadData = UIImageJPEGRepresentation(image, 1.0) {
            ref.putData(uploadData, metadata: nil) { (metadata, error) in
                if error != nil {
                    print(error)
                    return
                }
                ref.downloadURL(completion: { (downloadUrl, error) in
                    guard let url = downloadUrl else {return}
                    let imageUrl = url.absoluteString
                    self.sendImage(url: imageUrl, image: image)
                })
            }
        }
    }
}





