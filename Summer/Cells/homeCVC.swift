//
//  homeCVC.swift
//  Summer
//
//  Created by Artesia Ko on 12/24/18.
//  Copyright © 2018 Yanlam. All rights reserved.
//

import UIKit

class homeCVC: UICollectionViewCell {
    
    var circleImage: UIImageView!
    var circleImage2: UIImageView!
    var line: UIImageView!
    var nameLabel: UILabel!
    var messageLabel: UILabel!
    var timeLabel: UILabel!
    
    var message: Message? {
        didSet {
            nameLabel.text = message?.person?.name
            messageLabel.text = message?.text
            
            if let imageName = message?.person?.profileImageName {
                circleImage.image = UIImage(named: imageName)
                circleImage2.image = UIImage(named: imageName)
            }
            
            if let date = message?.date {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "h:mm a"
                timeLabel.text = dateFormatter.string(from: date)
            }
        }
    }
    
    let padding: CGFloat = 12
    let textColor: UIColor = UIColor.gray
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.clear
        
        let lineWidth = contentView.frame.width - 2*padding
        line = UIImageView()
        line.translatesAutoresizingMaskIntoConstraints = false
        //UIColor(red: 133/255, green: 226/255, blue: 209/255, alpha: 1)
        line.backgroundColor = .white
        line.layer.cornerRadius = 10
        line.layer.masksToBounds = true
        contentView.addSubview(line)
        NSLayoutConstraint.activate([
            line.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            line.widthAnchor.constraint(equalToConstant: lineWidth),
            line.heightAnchor.constraint(equalTo: contentView.heightAnchor, constant: -1.0*padding),
            line.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
            ])
        
        let circleHeight = contentView.frame.height - 4*padding
        circleImage = UIImageView()
        circleImage.translatesAutoresizingMaskIntoConstraints = false
        circleImage.backgroundColor = .white
        circleImage.contentMode = .scaleAspectFill
        circleImage.image = UIImage(named: "defaultImage")
        circleImage.layer.cornerRadius = circleHeight/2
        circleImage.clipsToBounds = true
        circleImage.layer.masksToBounds = true
        contentView.addSubview(circleImage)
        NSLayoutConstraint.activate([
            circleImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            circleImage.leadingAnchor.constraint(equalTo: line.leadingAnchor, constant: padding),
            circleImage.heightAnchor.constraint(equalToConstant: circleHeight),
            circleImage.widthAnchor.constraint(equalToConstant: circleHeight)
            ])
        
        timeLabel = UILabel()
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        timeLabel.text = "00:00"
        timeLabel.textColor = textColor
        timeLabel.font = UIFont.systemFont(ofSize: 12, weight: .light)
        timeLabel.textAlignment = .right
        contentView.addSubview(timeLabel)
        NSLayoutConstraint.activate([
            timeLabel.centerYAnchor.constraint(equalTo: circleImage.topAnchor, constant: 0.25*circleHeight),
            timeLabel.trailingAnchor.constraint(equalTo: line.trailingAnchor, constant: -1.0*padding)
            ])
        
        nameLabel = UILabel()
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.text = "Name Label"
        nameLabel.textColor = textColor
        nameLabel.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        contentView.addSubview(nameLabel)
        NSLayoutConstraint.activate([
            nameLabel.centerYAnchor.constraint(equalTo: circleImage.topAnchor, constant: 0.25*circleHeight),
            nameLabel.leadingAnchor.constraint(equalTo: circleImage.trailingAnchor, constant: padding),
            nameLabel.trailingAnchor.constraint(equalTo: timeLabel.leadingAnchor, constant: -0.1*padding)
            ])
        
        let circleHeight2: CGFloat = 20
        circleImage2 = UIImageView()
        circleImage2.translatesAutoresizingMaskIntoConstraints = false
        circleImage2.backgroundColor = .white
        circleImage2.contentMode = .scaleAspectFill
        circleImage2.image = UIImage(named: "defaultImage")
        circleImage2.layer.cornerRadius = circleHeight2/2
        circleImage2.clipsToBounds = true
        circleImage2.layer.masksToBounds = true
        contentView.addSubview(circleImage2)
        NSLayoutConstraint.activate([
            circleImage2.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 0.5*padding),
            circleImage2.trailingAnchor.constraint(equalTo: timeLabel.trailingAnchor),
            circleImage2.heightAnchor.constraint(equalToConstant: circleHeight2),
            circleImage2.widthAnchor.constraint(equalToConstant: circleHeight2)
            ])
        
        messageLabel = UILabel()
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.alpha = 0.85
        messageLabel.text = "Message Label Message Label Message Label Message Label Message Label Message Label Message Label Message Label Message Label Message Label Message Label Message Label Message Label Message Label Message Label Message Label Message Label Message Label Message Label"
        messageLabel.textColor = textColor
        messageLabel.font = UIFont.systemFont(ofSize: 12, weight: .light)
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .left
        contentView.addSubview(messageLabel)
        NSLayoutConstraint.activate([
            messageLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 0.5*padding),
            messageLabel.leadingAnchor.constraint(equalTo: circleImage.trailingAnchor, constant: padding),
            messageLabel.trailingAnchor.constraint(equalTo: circleImage2.leadingAnchor, constant: -1.0*padding),
            messageLabel.bottomAnchor.constraint(equalTo: line.bottomAnchor, constant: -1.0*padding)
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

