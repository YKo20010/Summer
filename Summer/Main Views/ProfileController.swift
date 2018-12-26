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
    var logoutButton: UIButton!
    var nameLabel: UILabel!
    
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
        logoutButton = UIButton()
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        logoutButton.backgroundColor = UIColor(red: 81/255, green: 188/255, blue: 168/255, alpha: 1)
        logoutButton.layer.cornerRadius = logoutButtonHeight/2
        logoutButton.layer.masksToBounds = true
        logoutButton.setTitle("Logout", for: .normal)
        logoutButton.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        logoutButton.addTarget(self, action: #selector(logout), for: .touchDown)
        view.addSubview(logoutButton)
        NSLayoutConstraint.activate([
            logoutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoutButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -12),
            logoutButton.widthAnchor.constraint(equalToConstant: 200),
            logoutButton.heightAnchor.constraint(equalToConstant: logoutButtonHeight)
            ])
        
        nameLabel = UILabel()
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        let uid = Auth.auth().currentUser?.uid
        Database.database().reference().child("users").child(uid!).observeSingleEvent(of: .value, with: { (dataSnapshot) in
            if let dictionary = dataSnapshot.value as? [String: AnyObject] {
                self.nameLabel.text = dictionary["name"] as? String
            }
        }, withCancel: nil)
        nameLabel.font = UIFont.systemFont(ofSize: 25, weight: .semibold)
        nameLabel.textColor = UIColor.gray
        view.addSubview(nameLabel)
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24)
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
