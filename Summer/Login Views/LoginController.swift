//
//  LoginController.swift
//  Summer
//
//  Created by Artesia Ko on 12/24/18.
//  Copyright © 2018 Yanlam. All rights reserved.
//

import UIKit
import Firebase

class LoginController: UIViewController, UIGestureRecognizerDelegate {

    var loginButton: UIButton!
    var registerButton: UIButton!
    var registerLabel: UILabel!
    
    var emailTextField: UITextField!
    var passwordTextField: UITextField!
    var imageView: UIImageView!
    
    let inputRec1: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 25
        view.layer.masksToBounds = true
        return view
    }()
    let inputRec2: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 25
        view.layer.masksToBounds = true
        return view
    }()
    let rec: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.white
        return view
    }()
    
    var pan: UIPanGestureRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isHidden = true
        
        view.backgroundColor = Static.lightAqua
        
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
        
        view.addSubview(inputRec1)
        inputRec1.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        inputRec1.bottomAnchor.constraint(equalTo: view.centerYAnchor, constant: -5).isActive = true
        inputRec1.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -50).isActive = true
        inputRec1.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        emailTextField = UITextField()
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.placeholder = "Email"
        view.addSubview(emailTextField)
        NSLayoutConstraint.activate([
            emailTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emailTextField.centerYAnchor.constraint(equalTo: inputRec1.centerYAnchor),
            emailTextField.widthAnchor.constraint(equalTo: inputRec1.widthAnchor, constant: -40),
            emailTextField.heightAnchor.constraint(equalToConstant: 50)
            ])
        
        view.addSubview(inputRec2)
        inputRec2.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        inputRec2.topAnchor.constraint(equalTo: view.centerYAnchor, constant: 5).isActive = true
        inputRec2.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -50).isActive = true
        inputRec2.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        passwordTextField = UITextField()
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.placeholder = "Password"
        passwordTextField.isSecureTextEntry = true
        view.addSubview(passwordTextField)
        NSLayoutConstraint.activate([
            passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordTextField.centerYAnchor.constraint(equalTo: inputRec2.centerYAnchor),
            passwordTextField.widthAnchor.constraint(equalTo: inputRec2.widthAnchor, constant: -40),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50)
            ])
        
        let loginButtonHeight: CGFloat = 50
        loginButton = UIButton()
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.backgroundColor = Static.darkAqua
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
            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20),
            loginButton.widthAnchor.constraint(equalToConstant: 200),
            loginButton.heightAnchor.constraint(equalToConstant: loginButtonHeight)
            ])
        
        let imageViewHeight: CGFloat = 150
        imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "loginlogo")
        imageView.contentMode = .scaleAspectFit
        view.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.bottomAnchor.constraint(equalTo: emailTextField.topAnchor, constant: -20),
            imageView.widthAnchor.constraint(equalToConstant: imageViewHeight),
            imageView.heightAnchor.constraint(equalToConstant: imageViewHeight)
            ])
        
        pan = UIPanGestureRecognizer(target: self, action: #selector(onPan(_:)))
        pan.delegate = self
        view.addGestureRecognizer(pan)
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
            
            DispatchQueue.main.async {
                Database.database().reference().child("users").child(uid!).observeSingleEvent(of: .value, with: { (dataSnapshot) in
                    if let dictionary = dataSnapshot.value as? [String: AnyObject] {
                        let person = Person(dictionary: dictionary, id: uid!)
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
