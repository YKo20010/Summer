//
//  LoginController.swift
//  Summer
//
//  Created by Artesia Ko on 12/24/18.
//  Copyright © 2018 Yanlam. All rights reserved.
//

import UIKit
import Firebase

class LoginController: UIViewController {

    var inputsContainerView: UIView!
    var loginButton: UIButton!
    var registerButton: UIButton!
    var registerLabel: UILabel!
    
    var emailTextField: UITextField!
    var passwordTextField: UITextField!
    var imageView: UIImageView!
    
    let sep1: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 211/255, green: 211/255, blue: 211/255, alpha: 1)
        return view
    }()
    let rec: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.white
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isHidden = true
        
        view.backgroundColor = UIColor(red: 133/255, green: 226/255, blue: 209/255, alpha: 1)
        
        inputsContainerView = UIView()
        inputsContainerView.translatesAutoresizingMaskIntoConstraints = false
        inputsContainerView.backgroundColor = .white
        inputsContainerView.layer.cornerRadius = 5
        inputsContainerView.layer.masksToBounds = true
        view.addSubview(inputsContainerView)
        NSLayoutConstraint.activate([
            inputsContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            inputsContainerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            inputsContainerView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -50),
            inputsContainerView.heightAnchor.constraint(equalToConstant: 100)
            ])
        
        let loginButtonHeight: CGFloat = 50
        loginButton = UIButton()
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.backgroundColor = UIColor(red: 81/255, green: 188/255, blue: 168/255, alpha: 1)
        loginButton.setTitle("Sign In", for: .normal)
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        loginButton.layer.cornerRadius = loginButtonHeight/2
        loginButton.layer.masksToBounds = true
        loginButton.contentMode = .scaleAspectFit
        loginButton.addTarget(self, action: #selector(login), for: .touchDown)
        view.addSubview(loginButton)
        NSLayoutConstraint.activate([
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.topAnchor.constraint(equalTo: inputsContainerView.bottomAnchor, constant: 20),
            loginButton.widthAnchor.constraint(equalToConstant: 200),
            loginButton.heightAnchor.constraint(equalToConstant: loginButtonHeight)
            ])
        
        view.addSubview(rec)
        registerLabel = UILabel()
        registerLabel.translatesAutoresizingMaskIntoConstraints = false
        registerLabel.text = "Don't have an account yet? "
        registerLabel.textColor = .white
        registerLabel.font = UIFont.systemFont(ofSize: 15, weight: .light)
        view.addSubview(registerLabel)
        NSLayoutConstraint.activate([
            registerLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -12),
            registerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -24)
            ])
        registerButton = UIButton()
        registerButton.translatesAutoresizingMaskIntoConstraints = false
        registerButton.backgroundColor = .clear
        registerButton.setTitle("Sign Up", for: .normal)
        registerButton.setTitleColor(.white, for: .normal)
        registerButton.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        registerButton.addTarget(self, action: #selector(register), for: .touchDown)
        view.addSubview(registerButton)
        NSLayoutConstraint.activate([
            registerButton.leadingAnchor.constraint(equalTo: registerLabel.trailingAnchor),
            registerButton.centerYAnchor.constraint(equalTo: registerLabel.centerYAnchor)
            ])
        NSLayoutConstraint.activate([
            rec.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            rec.widthAnchor.constraint(equalTo: view.widthAnchor),
            rec.topAnchor.constraint(equalTo: registerLabel.topAnchor, constant: -12),
            rec.heightAnchor.constraint(equalToConstant: 0.5)
            ])
        
        emailTextField = UITextField()
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.placeholder = "Email"
        inputsContainerView.addSubview(emailTextField)
        NSLayoutConstraint.activate([
            emailTextField.centerXAnchor.constraint(equalTo: inputsContainerView.centerXAnchor),
            emailTextField.topAnchor.constraint(equalTo: inputsContainerView.topAnchor),
            emailTextField.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor, constant: -24),
            emailTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/2)
            ])
        inputsContainerView.addSubview(sep1)
        NSLayoutConstraint.activate([
            sep1.centerXAnchor.constraint(equalTo: inputsContainerView.centerXAnchor),
            sep1.topAnchor.constraint(equalTo: emailTextField.bottomAnchor),
            sep1.heightAnchor.constraint(equalToConstant: 1),
            sep1.widthAnchor.constraint(equalTo: emailTextField.widthAnchor)
            ])
        
        passwordTextField = UITextField()
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.placeholder = "Password"
        passwordTextField.isSecureTextEntry = true
        inputsContainerView.addSubview(passwordTextField)
        NSLayoutConstraint.activate([
            passwordTextField.centerXAnchor.constraint(equalTo: inputsContainerView.centerXAnchor),
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor),
            passwordTextField.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor, constant: -24),
            passwordTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/2)
            ])
        
        let imageViewHeight: CGFloat = 150
        imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "loginlogo")
        imageView.contentMode = .scaleAspectFit
        view.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.bottomAnchor.constraint(equalTo: inputsContainerView.topAnchor, constant: -20),
            imageView.widthAnchor.constraint(equalToConstant: imageViewHeight),
            imageView.heightAnchor.constraint(equalToConstant: imageViewHeight)
            ])
    }
    
    @objc func login() { //loginButton
        guard let email = emailTextField.text, let password = passwordTextField.text else {
            return
        }
        Auth.auth().signIn(withEmail: email, password: password) { (authResponse, error) in
            if error != nil {
                return
            }
            let tabView = CustomTabBarController()
            let uid = Auth.auth().currentUser?.uid
            tabView.homeController.loadMessages()
            DispatchQueue.main.async {
                Database.database().reference().child("users").child(uid!).observeSingleEvent(of: .value, with: { (dataSnapshot) in
                    if let dictionary = dataSnapshot.value as? [String: AnyObject] {
                        let person = Person()
                        person.name = dictionary["name"] as? String
                        person.email = (dictionary["email"] as? String)!
                        person.id = uid
                        person.profileImageName = dictionary["profileImageURL"] as? String
                        person.username = dictionary["username"] as? String
                        tabView.homeController.me = person
                        tabView.profileController.me = person
                        if let profileImageURL = person.profileImageName {
                            tabView.profileController.profileImageView.loadImage(urlString: profileImageURL)
                        }
                    }
                    DispatchQueue.main.async {
                        self.present(tabView, animated: true, completion: nil)
                    }
                }, withCancel: nil)
            }
        }
    }
    
    @objc func register() { //registerButton
        let registerController = RegisterController()
        self.present(registerController, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
