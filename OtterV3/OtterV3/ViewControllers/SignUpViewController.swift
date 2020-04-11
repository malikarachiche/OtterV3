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

class SignUpViewController: BaseViewController {

    let otterImage = UIImageView()
    let emailTextField = MadokaTextField()
    let passwordTextField = MadokaTextField()
    let confirmPasswordTextField = MadokaTextField()
    let careerTextField = MadokaTextField()
    let signUpButton = CustomLoginButton()
    let alreadyHaveAccountButton = CustomLoginTransitionButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpGestureRecognizer()
        setUpUI()
        setUpTFUI()
    }
    
    func setUpUI() {
        view.addSubview(otterImage)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(confirmPasswordTextField)
        view.addSubview(careerTextField)
        view.addSubview(signUpButton)
        view.addSubview(alreadyHaveAccountButton)
        
        setConstraints()
        navigationController?.navigationBar.isHidden = true
        view.setGradientBackground(colorOne: Colors.veryDarkPurple, colorTwo: Colors.darkPurple, colorThree: Colors.darkTeal)
        otterImage.image = UIImage(named: "otter-logo-white-10")
        signUpButton.addTarget(self, action: #selector(signUpTapped), for: .touchUpInside)
        signUpButton.setTitle("Sign Up", for: .normal)
        alreadyHaveAccountButton.addTarget(self, action: #selector(alreadyHaveAccountTapped), for: .touchUpInside)
        alreadyHaveAccountButton.setTitle("Already have an account?", for: .normal)
//        emailTextField.delegate = self
//        passwordTextField.delegate = self
    }
    
    func setUpTFUI() {
        emailTextField.setTextField(string: "Email...")
        passwordTextField.setTextField(string: "Password...")
        confirmPasswordTextField.setTextField(string: "Confirm Password...")
        careerTextField.setTextField(string: "Occupation...")
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
            make.topMargin.equalTo(self.otterImage.snp_bottomMargin).offset(-35)
            make.height.equalTo(55)
            make.width.equalToSuperview().multipliedBy(0.61)
        }
        
        passwordTextField.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.topMargin.equalTo(self.emailTextField.snp_bottomMargin).offset(18)
            make.height.equalTo(55)
            make.width.equalToSuperview().multipliedBy(0.61)
        }
        
        confirmPasswordTextField.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.topMargin.equalTo(self.passwordTextField.snp_bottomMargin).offset(18)
            make.height.equalTo(55)
            make.width.equalToSuperview().multipliedBy(0.61)
        }
        
        careerTextField.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.topMargin.equalTo(self.confirmPasswordTextField.snp_bottomMargin).offset(18)
            make.height.equalTo(55)
            make.width.equalToSuperview().multipliedBy(0.61)
        }
        
        signUpButton.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.topMargin.equalTo(self.careerTextField.snp_bottomMargin).offset(40)
            make.height.equalTo(40)
            make.width.equalToSuperview().multipliedBy(0.61)
        }
        
        alreadyHaveAccountButton.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.topMargin.equalTo(self.signUpButton.snp_bottomMargin).offset(60)
            make.height.equalTo(30)
            make.width.equalToSuperview().multipliedBy(0.60)
        }
    }
    
    
    @objc func signUpTapped() {
        print("Sign Up tapped")
        
        // Check if passwords match
        if (emailTextField.text != nil && passwordTextField.text != nil && confirmPasswordTextField.text != nil)
            && passwordTextField.text! == confirmPasswordTextField.text! {
            // Create user using input
            Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
                if user != nil {
                    print("User created")
                    // Sends an email verification
                    Auth.auth().currentUser?.sendEmailVerification(completion: { (error) in
                        self.createAlert(title: "User created!", message: "An email will be sent to activate your account!")
                        self.navigationController?.dismiss(animated: true, completion: nil)
                    })
                } else {
                    // There was an error
                    self.signUpButton.shakeButton()
                    self.createAlert(title: "There was a problem", message: "Please try again")
                }
            }
        } else {
            createAlert(title: "There was a problem", message: "Passwords do not match")
        }
    }
    
    @objc func alreadyHaveAccountTapped() {
        print("Button Tapped")
        self.navigationController?.popViewController(animated: false)
    }
}

