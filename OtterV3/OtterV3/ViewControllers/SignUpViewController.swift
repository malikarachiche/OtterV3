//
//  SignUpViewController.swift
//  OtterV3
//
//  Created by Malik Arachiche on 4/10/20.
//  Copyright © 2020 Malik Arachiche. All rights reserved.
//

import UIKit
import TextFieldEffects
import FirebaseAuth
import Firebase

class SignUpViewController: BaseViewController {

    // TODO: Figure out what to do with careerTextField
    
    let finishedLabel = UILabel()
    let otterImage = UIImageView()
    let emailTextField = MadokaTextField()
    let passwordTextField = MadokaTextField()
    let confirmPasswordTextField = MadokaTextField()
    let nameTextField = MadokaTextField()
    let careerTextField = MadokaTextField()
    let signUpButton = CustomLoginButton()
    let alreadyHaveAccountButton = CustomLoginTransitionButton()
    
    //let database = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpGestureRecognizer()
        setUpUI()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        emailTextField.text = ""
        passwordTextField.text = ""
        confirmPasswordTextField.text = ""
        nameTextField.text = ""
        careerTextField.text = ""
    }
    
    func setUpUI() {
        view.addSubview(finishedLabel)
        view.addSubview(otterImage)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(confirmPasswordTextField)
        view.addSubview(nameTextField)
        view.addSubview(careerTextField)
        view.addSubview(signUpButton)
        view.addSubview(alreadyHaveAccountButton)
        
        setConstraints()
        setUpLabel(label: finishedLabel, text: "Nice! Check your email for a link to activate the account!")
        setUpTFUI(textField: emailTextField, string: "Email...")
        setUpTFUI(textField: passwordTextField, string: "Password...")
        setUpTFUI(textField: confirmPasswordTextField, string: "Confirm Password...")
        setUpTFUI(textField: nameTextField, string: "Name")
        setUpTFUI(textField: careerTextField, string: "Occupation or field of study")
        
        finishedLabel.alpha = 0
        passwordTextField.isSecureTextEntry = true
        confirmPasswordTextField.isSecureTextEntry = true
        nameTextField.alpha = 0
        nameTextField.isEnabled = false
        careerTextField.alpha = 0
        careerTextField.isEnabled = false
        
        navigationController?.navigationBar.isHidden = true
        view.setGradientBackground(colorOne: Colors.veryDarkPurple, colorTwo: Colors.darkPurple, colorThree: Colors.darkTeal)
        otterImage.image = UIImage(named: "otter-logo-white-10")
        signUpButton.addTarget(self, action: #selector(signUpTapped), for: .touchUpInside)
        signUpButton.setTitle("Next", for: .normal)
        alreadyHaveAccountButton.addTarget(self, action: #selector(alreadyHaveAccountTapped), for: .touchUpInside)
        alreadyHaveAccountButton.setTitle("Already have an account?", for: .normal)
    }
    
    func setUpTFUI(textField: MadokaTextField, string: String) {
        textField.setTextField(string: string)
        textField.delegate = self
    }
    
    func setConstraints() {
        
        otterImage.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.topMargin.equalToSuperview().inset(20)
            make.height.equalTo(300)
            make.width.equalToSuperview().multipliedBy(0.95)
        }
        
        emailTextField.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.topMargin.equalTo(self.otterImage.snp_bottomMargin).offset(-25)
            make.height.equalTo(55)
            make.width.equalToSuperview().multipliedBy(0.61)
        }
        
        passwordTextField.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.topMargin.equalTo(self.emailTextField.snp_bottomMargin).offset(22)
            make.height.equalTo(55)
            make.width.equalToSuperview().multipliedBy(0.61)
        }
        
        confirmPasswordTextField.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.topMargin.equalTo(self.passwordTextField.snp_bottomMargin).offset(22)
            make.height.equalTo(55)
            make.width.equalToSuperview().multipliedBy(0.61)
        }
        
        nameTextField.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.topMargin.equalTo(self.emailTextField.snp_bottomMargin).offset(22)
            make.height.equalTo(55)
            make.width.equalToSuperview().multipliedBy(0.61)
        }
        
        careerTextField.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.topMargin.equalTo(self.passwordTextField.snp_bottomMargin).offset(22)
            make.height.equalTo(55)
            make.width.equalToSuperview().multipliedBy(0.61)
        }
        
        signUpButton.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.topMargin.equalTo(self.confirmPasswordTextField.snp_bottomMargin).offset(40)
            make.height.equalTo(40)
            make.width.equalToSuperview().multipliedBy(0.61)
        }
        
        alreadyHaveAccountButton.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.topMargin.equalTo(self.signUpButton.snp_bottomMargin).offset(60)
            make.height.equalTo(30)
            make.width.equalToSuperview().multipliedBy(0.60)
        }
        
        finishedLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.topMargin.equalTo(self.otterImage.snp_bottomMargin)
            make.height.equalTo(100)
            make.width.equalToSuperview().multipliedBy(0.85)
        }
    }
    
    func createNewUser() {
        Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
            if let error = error {
                self.signUpButton.shakeButton()
                if let errCode = AuthErrorCode(rawValue: error._code) {
                    switch errCode {
                    case .invalidEmail:
                        self.createAlert(title: "There was a problem", message: "Invalid email")
                        return
                    case .weakPassword:
                        self.createAlert(title: "There was a problem", message: "Password is too weak")
                        return
                    case .emailAlreadyInUse:
                        self.createAlert(title: "There was a problem", message: "Email already in use")
                        return
                    default:
                        self.createAlert(title: "There was a problem", message: "Unknown error: please try again")
                        return
                    }
                }
            }
        
            if user != nil {
                print("User created")
                // Sends an email verification
                self.animate()
            } else {
                // There was an error
                self.signUpButton.shakeButton()
                self.createAlert(title: "There was a problem", message: "Please try again")
            }
        }
    }
    
    func animate() {
        if nameTextField.alpha == 0 {
            DispatchQueue.main.async {
                UIView.animate(withDuration: 0.2) {
                    self.emailTextField.alpha = 0
                    self.passwordTextField.alpha = 0
                    self.confirmPasswordTextField.alpha = 0
                    self.alreadyHaveAccountButton.alpha = 0
                }
                self.emailTextField.isEnabled = false
                self.passwordTextField.isEnabled = false
                self.confirmPasswordTextField.isEnabled = false
                self.alreadyHaveAccountButton.isEnabled = false
                self.nameTextField.isEnabled = true
                self.careerTextField.isEnabled = true
                UIView.animate(withDuration: 0.2) {
                    self.nameTextField.alpha = 1
                    self.careerTextField.alpha = 1
                    self.signUpButton.setTitle(message: "Sign Up")
                }
            }
        } else {
            DispatchQueue.main.async {
                UIView.animate(withDuration: 0.2) {
                    self.nameTextField.alpha = 0
                    self.careerTextField.alpha = 0
                }
                self.nameTextField.isEnabled = false
                self.careerTextField.isEnabled = false
                UIView.animate(withDuration: 0.2) {
                    // TODO: Checkmark animation here maybe??
                    self.finishedLabel.alpha = 1
                    self.signUpButton.setTitle(message: "Back To Login")
                }
            }
        }
    }
    
    @objc func signUpTapped() {
        let buttonText = self.signUpButton.titleLabel?.text
        if buttonText == "Next" {
            print("Next tapped")
            if passwordTextField.text! == confirmPasswordTextField.text! {
                self.createNewUser()
            } else {
                createAlert(title: "There was a problem", message: "Passwords do not match")
            }
        } else if buttonText == "Sign Up" {
            print("Sign up tapped")
            Auth.auth().currentUser?.sendEmailVerification(completion: { (error) in
                self.animate()
            })
            addUserToDatabase(name: nameTextField.text ?? "", career: careerTextField.text ?? "")
        } else {
            print("Back to login tapped")
            self.navigationController?.popViewController(animated: true)
            
        }
    }
    
    @objc func alreadyHaveAccountTapped() {
        print("Button Tapped")
        self.navigationController?.popViewController(animated: false)
    }
}

extension SignUpViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        textField.resignFirstResponder()
        return true
    }
}

