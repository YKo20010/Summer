//
//  homeCVC.swift
//  Summer
//
//  Created by Artesia Ko on 12/24/18.
//  Copyright © 2018 Yanlam. All rights reserved.
//

import UIKit
import Firebase

class homeCVC: UICollectionViewCell {
    
    var circleImage: UIImageView!
    var line: UIImageView!
    var nameLabel: UILabel!
    var messageLabel: UILabel!
    var timeLabel: UILabel!
    var timeRec: UIView!
    var smallIcon: UIImageView!
    
    var message: Message? {
        didSet {
            if let id = message?.chatPartnerId() {
                let ref = Database.database().reference().child("users").child(id)
                ref.observeSingleEvent(of: .value, with: { (snapshot) in
                    if let dictionary = snapshot.value as? [String : AnyObject] {
                        self.nameLabel?.text = dictionary["name"] as? String
                        if let imageUrl = dictionary["profileImageURL"] as? String {
                            self.circleImage.loadImage(urlString: imageUrl)
                        }
                        if self.message?.imageUrl != nil {
                            self.smallIcon.image = UIImage(named: "iconImage")?.withRenderingMode(.alwaysTemplate)
                            self.smallIcon.alpha = 1
                            self.messageLeadingAnchor?.constant = 24
                            if let fromId = self.message?.fromId, fromId != Auth.auth().currentUser?.uid, let name = self.nameLabel?.text {
                                self.messageLabel.text = "\(name) sent an image."
                            }
                            else {
                                self.messageLabel.text = "You sent an image."
                            }
                        }
                        else {
                            self.smallIcon.alpha = 0
                            self.messageLeadingAnchor?.constant = 0
                        }
                    }
                }, withCancel: nil)
            }
            if let time = message?.timestamp {
                let date = Date(timeIntervalSince1970: time)
                let dif = date.timeIntervalSinceNow
                if (dif < -60*60*24) {
                    let form2 = DateFormatter()
                    form2.dateFormat = "MMM dd"
                    timeLabel.text = form2.string(from: date)
                }
                else {
                    let form1 = DateFormatter()
                    form1.dateFormat = "h:mm a"
                    timeLabel.text = form1.string(from: date)
                }
            }
            messageLabel.text = message?.text
        }
    }
    
    let padding: CGFloat = 12
    var messageLeadingAnchor: NSLayoutConstraint?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.clear
        
        line = UIImageView()
        line.translatesAutoresizingMaskIntoConstraints = false
        line.backgroundColor = Static.customGray
        line.alpha = 0.5
        contentView.addSubview(line)
        NSLayoutConstraint.activate([
            line.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            line.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            line.heightAnchor.constraint(equalToConstant: 0.5),
            line.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
            ])
        
        timeRec = UIView()
        timeRec.translatesAutoresizingMaskIntoConstraints = false
        timeRec.backgroundColor = Static.darkAqua
        timeRec.layer.masksToBounds = true
        timeRec.layer.cornerRadius = 7
        contentView.addSubview(timeRec)
        timeRec.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding).isActive = true
        timeRec.heightAnchor.constraint(equalToConstant: 14).isActive = true
        timeRec.widthAnchor.constraint(equalToConstant: 55).isActive = true
        timeRec.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -0.5*padding).isActive = true
        
        timeLabel = UILabel()
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        timeLabel.text = "00:00"
        timeLabel.textColor = .white
        timeLabel.font = UIFont.systemFont(ofSize: 10, weight: .regular)
        timeLabel.textAlignment = .center
        timeLabel.sizeToFit()
        contentView.addSubview(timeLabel)
        timeLabel.centerYAnchor.constraint(equalTo: timeRec.centerYAnchor).isActive = true
        timeLabel.centerXAnchor.constraint(equalTo: timeRec.centerXAnchor).isActive = true
 
        let circleHeight: CGFloat = 55
        circleImage = UIImageView()
        circleImage.translatesAutoresizingMaskIntoConstraints = false
        circleImage.backgroundColor = .white
        circleImage.contentMode = .scaleAspectFill
        circleImage.image = UIImage(named: "")
        circleImage.layer.cornerRadius = circleHeight/2
        circleImage.clipsToBounds = true
        circleImage.layer.masksToBounds = true
        contentView.addSubview(circleImage)
        NSLayoutConstraint.activate([
            circleImage.bottomAnchor.constraint(equalTo: timeRec.topAnchor, constant: -4),
            circleImage.centerXAnchor.constraint(equalTo: timeRec.centerXAnchor),
            circleImage.heightAnchor.constraint(equalToConstant: circleHeight),
            circleImage.widthAnchor.constraint(equalToConstant: circleHeight)
            ])
        
        nameLabel = UILabel()
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.text = ""
        nameLabel.textColor = .black
        nameLabel.font = UIFont.systemFont(ofSize: 18, weight: .light)
        nameLabel.sizeToFit()
        contentView.addSubview(nameLabel)
        NSLayoutConstraint.activate([
            nameLabel.bottomAnchor.constraint(equalTo: contentView.centerYAnchor, constant: -1),
            nameLabel.leadingAnchor.constraint(equalTo: timeRec.trailingAnchor, constant: padding),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding)
            ])
        
        smallIcon = UIImageView()
        smallIcon.translatesAutoresizingMaskIntoConstraints = false
        smallIcon.contentMode = .scaleAspectFit
        smallIcon.image = UIImage()
        smallIcon.tintColor = Static.customGray
        contentView.addSubview(smallIcon)
        smallIcon.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor).isActive = true
        smallIcon.heightAnchor.constraint(equalToConstant: 20).isActive = true
        smallIcon.widthAnchor.constraint(equalToConstant: 20).isActive = true
    
        messageLabel = UILabel()
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.text = ""
        messageLabel.textColor = UIColor.gray
        messageLabel.font = UIFont.systemFont(ofSize: 12, weight: .ultraLight)
        messageLabel.numberOfLines = 0
        messageLabel.sizeToFit()
        contentView.addSubview(messageLabel)
        messageLeadingAnchor = messageLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor)
        messageLeadingAnchor?.isActive = true
        messageLabel.topAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 1).isActive = true
        messageLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor).isActive = true
        messageLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -padding).isActive = true
        
        smallIcon.centerYAnchor.constraint(equalTo: messageLabel.centerYAnchor).isActive = true
 
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

