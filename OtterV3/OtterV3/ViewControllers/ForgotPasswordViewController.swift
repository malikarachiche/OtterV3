//
//  ForgotPasswordViewController.swift
//  OtterV3
//
//  Created by Malik Arachiche on 4/11/20.
//  Copyright © 2020 Malik Arachiche. All rights reserved.
//

import UIKit
import FirebaseAuth
import TextFieldEffects
import Lottie

class ForgotPasswordViewController: BaseViewController {
    
    // MARK: TODO: Refactor backToLogin and sendEmailButton to be the same button
    
    let label = UILabel()
    let emailTextField = MadokaTextField()
    let backButton = UIButton()
    let sendEmailButton = CustomLoginButton()
    let animationView = AnimationView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        setUpTFUI()
        setUpGestureRecognizer()
    }
    
    func setUpUI() {
        view.addSubview(label)
        view.addSubview(emailTextField)
        view.addSubview(backButton)
        view.addSubview(sendEmailButton)
        
        setConstraints()
        setUpLabel(label: label, text: "It's okay! We'll send a password recovery link to your email")
        
        view.setGradientBackground(colorOne: Colors.veryDarkPurple, colorTwo: Colors.darkPurple, colorThree: Colors.darkTeal)
        
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        backButton.setTitle("<-", for: .normal)
        sendEmailButton.addTarget(self, action: #selector(sendEmailTapped), for: .touchUpInside)
        sendEmailButton.setTitle("Send Email", for: .normal)
    }
    
    func setConstraints() {
        
        backButton.snp.makeConstraints { (make) in
            make.left.topMargin.equalTo(10)
            make.height.width.equalTo(45)
        }
        
        label.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview().offset(-125)
            make.centerX.equalToSuperview()
            make.height.equalTo(100)
            make.width.equalToSuperview().multipliedBy(0.85)
        }
        
        emailTextField.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.topMargin.equalTo(self.label.snp_bottomMargin).offset(30)
            make.height.equalTo(50)
            make.width.equalToSuperview().multipliedBy(0.75)
        }
        
        sendEmailButton.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.height.equalTo(40)
            make.topMargin.equalTo(self.emailTextField.snp_bottomMargin).offset(50)
            make.width.equalToSuperview().multipliedBy(0.75)
        }
    }
    
    func setUpTFUI() {
        emailTextField.setTextField(string: "Email")
        emailTextField.delegate = self
    }
    
    func animate() {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.2) {
                self.emailTextField.alpha = 0
                self.label.text = "An email has been sent, please click the link provided in the email to reset your password"
            }
            self.sendEmailButton.setTitle(message: "Back To Login")
        }
    }
    
    @objc func backButtonTapped() {
        print("Back button tapped")
        navigationController?.popViewController(animated: true)
    }
    
    @objc func sendEmailTapped() {
        print("Send email tapped")
        if sendEmailButton.titleLabel?.text == "Send Email" {
            Auth.auth().sendPasswordReset(withEmail: emailTextField.text!) { (error) in
                // MARK: TODO: Fix up error checking
                if let error = error {
                    print(error.localizedDescription)
                    self.sendEmailButton.shakeButton()
                    if let errCode = AuthErrorCode(rawValue: error._code) {
                        switch errCode {
                        case .invalidEmail:
                            self.createAlert(title: "THere was a problem", message: "Email is invalid")
                        case .missingEmail:
                            self.createAlert(title: "There was a problem", message: error.localizedDescription)
                        case .userNotFound:
                            self.createAlert(title: "There was a problem", message: "User not found")
                        default:
                            self.createAlert(title: "There was a problem", message: "Please try again")
                        }
                    }
                } else {
                    print("Password Recovery Email Sent!")
                    self.animate()
                }
            }
        } else {
            navigationController?.popViewController(animated: true)
        }
        
    }
}

extension ForgotPasswordViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
}
