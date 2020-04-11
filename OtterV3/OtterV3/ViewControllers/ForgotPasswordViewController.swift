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

class ForgotPasswordViewController: BaseViewController {

    let label = UILabel()
    let emailTextField = MadokaTextField()
    let backButton = UIButton()
    let sendEmailButton = CustomLoginButton()
    
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
        
        navigationController?.navigationBar.isHidden = true
        view.setGradientBackground(colorOne: Colors.veryDarkPurple, colorTwo: Colors.darkPurple, colorThree: Colors.darkTeal)
        label.text = "It's okay! We'll send a password recovery link to your email"
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.numberOfLines = 9
        label.font = UIFont(name: "PingFangTC-Light", size: 20)
        
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
    
    @objc func backButtonTapped() {
        print("Back button tapped")
        navigationController?.dismiss(animated: true, completion: nil)
    }
    
    @objc func sendEmailTapped() {
        print("Send email tapped")
        
        if emailTextField.text != nil {
            Auth.auth().sendPasswordReset(withEmail: emailTextField.text!) { (error) in
                if error != nil {
                    print(error!.localizedDescription)
                    self.createAlert(title: "Invalid Email", message: "Please try again")
                }
                else {
                    print("Password Recovery Email Sent!")
                    //self.navigationController?.pushViewController(PasswordRecoveredViewController(), animated: true)
                }
            }
        } else {
            self.createAlert(title: "Invalid Email", message: "Please enter an email")
        }
    }
}

extension ForgotPasswordViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
}
