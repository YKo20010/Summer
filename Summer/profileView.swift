//
//  profileView.swift
//  Summer
//
//  Created by Artesia Ko on 12/27/18.
//  Copyright © 2018 Yanlam. All rights reserved.
//

import UIKit

class profileView: UIView {
    var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20, weight: .light)
        label.textColor = UIColor.gray
        label.text = ""
        return label
    }()
    var usernameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 15, weight: .light)
        label.textColor = UIColor.gray
        label.text = ""
        return label
    }()
    var emailLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 15, weight: .light)
        label.textColor = UIColor.gray
        label.text = ""
        return label
    }()
    let sep1: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Static.customGray
        return view
    }()
    let sep2: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Static.customGray
        return view
    }()
    let sep3: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Static.customGray
        return view
    }()
    var nLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 10, weight: .light)
        label.textColor = UIColor.gray
        label.text = "name"
        return label
    }()
    var uLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 10, weight: .light)
        label.textColor = UIColor.gray
        label.text = "username"
        return label
    }()
    var eLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 10, weight: .light)
        label.textColor = UIColor.gray
        label.text = "email"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        self.addSubview(nLabel)
        self.addSubview(uLabel)
        self.addSubview(eLabel)
        self.addSubview(sep1)
        self.addSubview(sep2)
        self.addSubview(sep3)
        self.addSubview(nameLabel)
        self.addSubview(usernameLabel)
        self.addSubview(emailLabel)
        
        NSLayoutConstraint.activate([
            sep1.topAnchor.constraint(equalTo: self.topAnchor),
            sep1.heightAnchor.constraint(equalTo: nameLabel.heightAnchor),
            sep1.widthAnchor.constraint(equalToConstant: 0.5)
            ])
        NSLayoutConstraint.activate([
            sep2.topAnchor.constraint(equalTo: sep1.bottomAnchor, constant: 5),
            sep2.heightAnchor.constraint(equalTo: usernameLabel.heightAnchor),
            sep2.widthAnchor.constraint(equalToConstant: 0.5)
            ])
        NSLayoutConstraint.activate([
            sep3.topAnchor.constraint(equalTo: sep2.bottomAnchor, constant: 5),
            sep3.heightAnchor.constraint(equalTo: emailLabel.heightAnchor),
            sep3.widthAnchor.constraint(equalToConstant: 0.5)
            ])
        NSLayoutConstraint.activate([
            nLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            nLabel.lastBaselineAnchor.constraint(equalTo: sep1.bottomAnchor)
            ])
        NSLayoutConstraint.activate([
            uLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            uLabel.lastBaselineAnchor.constraint(equalTo: sep2.bottomAnchor)
            ])
        NSLayoutConstraint.activate([
            eLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            eLabel.lastBaselineAnchor.constraint(equalTo: sep3.bottomAnchor)
            ])
        NSLayoutConstraint.activate([
            sep2.leadingAnchor.constraint(equalTo: uLabel.trailingAnchor, constant: 5),
            sep1.leadingAnchor.constraint(equalTo: sep2.leadingAnchor),
            sep3.leadingAnchor.constraint(equalTo: sep2.leadingAnchor)
            ])
        NSLayoutConstraint.activate([
            nameLabel.lastBaselineAnchor.constraint(equalTo: sep1.bottomAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: sep1.trailingAnchor, constant: 5)
            ])
        NSLayoutConstraint.activate([
            usernameLabel.lastBaselineAnchor.constraint(equalTo: sep2.bottomAnchor),
            usernameLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor)
            ])
        NSLayoutConstraint.activate([
            emailLabel.lastBaselineAnchor.constraint(equalTo: sep3.bottomAnchor),
            emailLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor)
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
