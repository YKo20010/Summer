//
//  RegisterController.swift
//  Summer
//
//  Created by Artesia Ko on 12/24/18.
//  Copyright © 2018 Yanlam. All rights reserved.
//

import UIKit
import Firebase

class RegisterController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIGestureRecognizerDelegate {
    
    var inputsContainerView: UIView!
    var registerButton: UIButton!
    var loginButton: UIButton!
    var loginLabel: UILabel!
    
    var usernameTextField: UITextField!
    var nameTextField: UITextField!
    var emailTextField: UITextField!
    var passwordTextField: UITextField!
    var profileImageView: UIImageView!
    
    var alert: UIAlertController!
    
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
    let rec: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.white
        return view
    }()
    
    var pan: UIPanGestureRecognizer!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Static.lightAqua
        
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
            inputsContainerView.heightAnchor.constraint(equalToConstant: 200)
            ])
        
        let registerButtonHeight: CGFloat = 50
        registerButton = UIButton()
        registerButton.translatesAutoresizingMaskIntoConstraints = false
        registerButton.backgroundColor = Static.darkAqua
        registerButton.setTitle("Register", for: .normal)
        registerButton.setTitleColor(.white, for: .normal)
        registerButton.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        registerButton.layer.cornerRadius = registerButtonHeight/2
        registerButton.layer.masksToBounds = true
        registerButton.addTarget(self, action: #selector(register), for: .touchDown)
        view.addSubview(registerButton)
        NSLayoutConstraint.activate([
            registerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            registerButton.topAnchor.constraint(equalTo: inputsContainerView.bottomAnchor, constant: 20),
            registerButton.widthAnchor.constraint(equalToConstant: 200),
            registerButton.heightAnchor.constraint(equalToConstant: registerButtonHeight)
            ])
        
        view.addSubview(rec)
        loginLabel = UILabel()
        loginLabel.translatesAutoresizingMaskIntoConstraints = false
        loginLabel.text = "Already have an account? "
        loginLabel.textColor = .white
        loginLabel.font = UIFont.systemFont(ofSize: 15, weight: .light)
        view.addSubview(loginLabel)
        NSLayoutConstraint.activate([
            loginLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -12),
            loginLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -24)
            ])
        loginButton = UIButton()
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.backgroundColor = .clear
        loginButton.setTitle("Sign In", for: .normal)
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        loginButton.addTarget(self, action: #selector(login), for: .touchDown)
        view.addSubview(loginButton)
        NSLayoutConstraint.activate([
            loginButton.leadingAnchor.constraint(equalTo: loginLabel.trailingAnchor),
            loginButton.centerYAnchor.constraint(equalTo: loginLabel.centerYAnchor)
        ])
        NSLayoutConstraint.activate([
            rec.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            rec.widthAnchor.constraint(equalTo: view.widthAnchor),
            rec.topAnchor.constraint(equalTo: loginLabel.topAnchor, constant: -12),
            rec.heightAnchor.constraint(equalToConstant: 0.5)
            ])
        
        usernameTextField = UITextField()
        usernameTextField.translatesAutoresizingMaskIntoConstraints = false
        usernameTextField.placeholder = "Username"
        inputsContainerView.addSubview(usernameTextField)
        NSLayoutConstraint.activate([
            usernameTextField.centerXAnchor.constraint(equalTo: inputsContainerView.centerXAnchor),
            usernameTextField.topAnchor.constraint(equalTo: inputsContainerView.topAnchor),
            usernameTextField.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor, constant: -24),
            usernameTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/4)
            ])
        inputsContainerView.addSubview(sep3)
        NSLayoutConstraint.activate([
            sep3.centerXAnchor.constraint(equalTo: inputsContainerView.centerXAnchor),
            sep3.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor),
            sep3.heightAnchor.constraint(equalToConstant: 0.75),
            sep3.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor, constant: -24)
            ])
        
        nameTextField = UITextField()
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        nameTextField.placeholder = "Name"
        inputsContainerView.addSubview(nameTextField)
        NSLayoutConstraint.activate([
            nameTextField.centerXAnchor.constraint(equalTo: inputsContainerView.centerXAnchor),
            nameTextField.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor),
            nameTextField.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor, constant: -24),
            nameTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/4)
            ])
        inputsContainerView.addSubview(sep1)
        NSLayoutConstraint.activate([
            sep1.centerXAnchor.constraint(equalTo: inputsContainerView.centerXAnchor),
            sep1.topAnchor.constraint(equalTo: nameTextField.bottomAnchor),
            sep1.heightAnchor.constraint(equalToConstant: 0.75),
            sep1.widthAnchor.constraint(equalTo: nameTextField.widthAnchor)
            ])
        
        emailTextField = UITextField()
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.placeholder = "Email"
        inputsContainerView.addSubview(emailTextField)
        NSLayoutConstraint.activate([
            emailTextField.centerXAnchor.constraint(equalTo: inputsContainerView.centerXAnchor),
            emailTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor),
            emailTextField.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor, constant: -24),
            emailTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/4)
            ])
        inputsContainerView.addSubview(sep2)
        NSLayoutConstraint.activate([
            sep2.centerXAnchor.constraint(equalTo: inputsContainerView.centerXAnchor),
            sep2.topAnchor.constraint(equalTo: emailTextField.bottomAnchor),
            sep2.heightAnchor.constraint(equalToConstant: 0.75),
            sep2.widthAnchor.constraint(equalTo: emailTextField.widthAnchor)
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
            passwordTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/4)
            ])
        
        let profileImageViewHeight: CGFloat = 150
        profileImageView = UIImageView()
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        profileImageView.backgroundColor = .white
        profileImageView.image = UIImage(named: "pp1")
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.layer.cornerRadius = profileImageViewHeight/2
        profileImageView.layer.masksToBounds = true
        profileImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(changeProfileImage)))
        profileImageView.isUserInteractionEnabled = true
        view.addSubview(profileImageView)
        NSLayoutConstraint.activate([
            profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profileImageView.bottomAnchor.constraint(equalTo: inputsContainerView.topAnchor, constant: -20),
            profileImageView.widthAnchor.constraint(equalToConstant: profileImageViewHeight),
            profileImageView.heightAnchor.constraint(equalToConstant: profileImageViewHeight)
            ])
        
        alert = UIAlertController()
        alert.title = "Invalid Input"
        alert.message = ""
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: .none))
   
        pan = UIPanGestureRecognizer(target: self, action: #selector(onPan(_:)))
        pan.delegate = self
        view.addGestureRecognizer(pan)
    }
    
    @objc func changeProfileImage() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        self.present(picker, animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
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
            profileImageView.image = selectedImage
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func login() { //loginButton
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func register() { //registerButton
        guard let email = emailTextField.text, email != "", let password = passwordTextField.text, password != "", let name = nameTextField.text, name != "", let username = usernameTextField.text, username != "" else {
            self.alert.title = "Invalid Input"
            self.alert.message = ""
            if (usernameTextField.text == "") {
                self.alert.message = self.alert.message! + "Username must not be empty.\n"
            }
            if (nameTextField.text == "") {
                self.alert.message = self.alert.message! + "Name must not be empty.\n"
            }
            if (emailTextField.text == "") {
                self.alert.message = self.alert.message! + "Enter a valid email.\n"
            }
            if (passwordTextField.text == "") {
                self.alert.message = self.alert.message! +  "Password must be at least 6 characters."
            }
            self.present(alert, animated: true)
            return
        }
        Auth.auth().createUser(withEmail: email, password: password, completion: { (authResult, error) in
            if error != nil {
                let errorMessage = error!.localizedDescription
                self.alert.title = "Invalid Input"
                if (errorMessage.contains("The email address is badly formatted.")) {
                    self.alert.message = "Email must be valid."
                }
                if (errorMessage.contains("The email address is already in use by another account.")) {
                    self.alert.message = "Email already in use."
                }
                if (errorMessage.contains("The password must be 6 characters long or more.")) {
                    self.alert.message = "Password must be at least 6 characters."
                }
                self.present(self.alert, animated: true)
                return
            }
            
            guard let uid = authResult?.user.uid else {return}
            let imageName = NSUUID().uuidString
            let storageRef = Storage.storage().reference().child("profile_images").child("\(imageName).jpg")
            if let profileImage = self.profileImageView.image, let uploadData = UIImageJPEGRepresentation(profileImage, 0.1) {
                storageRef.putData(uploadData, metadata: nil, completion: { (metadata, error) in
                    if (error != nil) {
                        print(error)
                        return
                    }
                    storageRef.downloadURL(completion: { (downloadUrl, error) in
                        guard let url = downloadUrl else {return}
                        let ref: DatabaseReference = Database.database().reference(fromURL: "https://summer-81ae7.firebaseio.com/")
                        let usersReference = ref.child("users").child(uid)
                        let values = ["name": name, "email": email, "password": password, "username": username, "profileImageURL" : url.absoluteString]
                        usersReference.updateChildValues(values, withCompletionBlock: { (err, ref) in
                            if err != nil {
                                print(err)
                                return
                            }
                        })
                    })
                })
            }
            self.dismiss(animated: true, completion: nil)
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
   

}
