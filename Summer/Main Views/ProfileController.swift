//
//  ProfileController.swift
//  Summer
//
//  Created by Artesia Ko on 12/24/18.
//  Copyright © 2018 Yanlam. All rights reserved.
//

import UIKit
import Firebase

class ProfileController: UIViewController {
    var me: Person? {
        didSet {
            self.dataView.nameLabel.text = me?.name
            self.dataView.emailLabel.text = me?.email
            self.dataView.usernameLabel.text = me?.username
        }
    }
    var logoutButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(red: 81/255, green: 188/255, blue: 168/255, alpha: 1)
        button.setTitle("Logout", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        button.layer.masksToBounds = true
        return button
    }()
    var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .white
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        return imageView
    }()
    var dataView: profileView = profileView()
    
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.barTintColor = UIColor(red: 81/255, green: 188/255, blue: 168/255, alpha: 1)
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.white]
        navigationController?.navigationBar.isTranslucent = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let logoutButtonHeight: CGFloat = 50
        logoutButton.layer.cornerRadius = logoutButtonHeight/2
        logoutButton.addTarget(self, action: #selector(logout), for: .touchDown)
        view.addSubview(logoutButton)
        NSLayoutConstraint.activate([
            logoutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoutButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -12),
            logoutButton.widthAnchor.constraint(equalToConstant: 200),
            logoutButton.heightAnchor.constraint(equalToConstant: logoutButtonHeight)
            ])
        
        let profileImageViewHeight: CGFloat = 50
        profileImageView.layer.cornerRadius = profileImageViewHeight/2
        view.addSubview(profileImageView)
        NSLayoutConstraint.activate([
            profileImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            profileImageView.heightAnchor.constraint(equalToConstant: profileImageViewHeight),
            profileImageView.widthAnchor.constraint(equalToConstant: profileImageViewHeight),
            profileImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20)
            ])
        
        dataView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(dataView)
        NSLayoutConstraint.activate([
            dataView.topAnchor.constraint(equalTo: profileImageView.topAnchor),
            dataView.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 20)
            ])
    }
    
    @objc func logout() {
        do {
            try Auth.auth().signOut()
        }
        catch let logoutError{
            print(logoutError)
            return
        }
        self.dismiss(animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
