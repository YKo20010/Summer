//
//  personCVC.swift
//  Summer
//
//  Created by Artesia Ko on 12/25/18.
//  Copyright © 2018 Yanlam. All rights reserved.
//

import UIKit

class personCVC: UICollectionViewCell {
    var circleImage: UIImageView!
    var line: UIImageView!
    var nameLabel: UILabel!
    var usernameLabel: UILabel!
    
    let padding: CGFloat = 12
    let textColor: UIColor = UIColor.gray
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.clear
        
        let lineWidth = contentView.frame.width - 2*padding
        line = UIImageView()
        line.translatesAutoresizingMaskIntoConstraints = false
        line.backgroundColor = textColor
        contentView.addSubview(line)
        NSLayoutConstraint.activate([
            line.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            line.widthAnchor.constraint(equalToConstant: lineWidth),
            line.heightAnchor.constraint(equalToConstant: 0.5),
            line.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
            ])
        
        let circleHeight = contentView.frame.height - 2*padding
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
            circleImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            circleImage.heightAnchor.constraint(equalToConstant: circleHeight),
            circleImage.widthAnchor.constraint(equalToConstant: circleHeight)
            ])
        
        nameLabel = UILabel()
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.text = "Name Label"
        nameLabel.textColor = textColor
        nameLabel.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        contentView.addSubview(nameLabel)
        NSLayoutConstraint.activate([
            nameLabel.bottomAnchor.constraint(equalTo: circleImage.centerYAnchor, constant: -1),
            nameLabel.leadingAnchor.constraint(equalTo: circleImage.trailingAnchor, constant: padding),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -0.1*padding)
            ])
        
        usernameLabel = UILabel()
        usernameLabel.translatesAutoresizingMaskIntoConstraints = false
        usernameLabel.text = "Username Label"
        usernameLabel.textColor = textColor
        usernameLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        contentView.addSubview(usernameLabel)
        NSLayoutConstraint.activate([
            usernameLabel.topAnchor.constraint(equalTo: circleImage.centerYAnchor, constant: 1),
            usernameLabel.leadingAnchor.constraint(equalTo: circleImage.trailingAnchor, constant: padding),
            usernameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -0.1*padding)
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
