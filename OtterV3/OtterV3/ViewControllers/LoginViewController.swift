//
//  LoginViewController.swift
//  OtterV3
//
//  Created by Malik Arachiche on 4/10/20.
//  Copyright © 2020 Malik Arachiche. All rights reserved.
//

import UIKit
import GoogleSignIn
import Firebase
import SnapKit
import TextFieldEffects

class LoginViewController: BaseViewController {

    // MARK: TODO: Fix Google Sign In
    
    let otterImage = UIImageView()
    let emailTextField = MadokaTextField()
    let passwordTextField = MadokaTextField()
    let loginButton = CustomLoginButton()
    let googleButton = GIDSignInButton()
    let noAccountButton = CustomLoginTransitionButton()
    let forgotPasswordButton = CustomLoginTransitionButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        setUpTFUI()
        setUpGestureRecognizer()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        emailTextField.text = ""
        passwordTextField.text = ""
    }
    
    func setUpUI() {
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(loginButton)
        view.addSubview(googleButton)
        view.addSubview(noAccountButton)
        view.addSubview(forgotPasswordButton)
        view.addSubview(otterImage)
        
        setConstraints()
        
        navigationController?.navigationBar.isHidden = true
        view.setGradientBackground(colorOne: Colors.veryDarkPurple, colorTwo: Colors.darkPurple, colorThree: Colors.darkTeal)
        otterImage.image = UIImage(named: "otter-logo-white-10")
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        noAccountButton.addTarget(self, action: #selector(noAccountTapped), for: .touchUpInside)
        forgotPasswordButton.addTarget(self, action: #selector(forgotPasswordTapped), for: .touchUpInside)
        loginButton.setTitle("Sign In", for: .normal)
        noAccountButton.setTitle("Don't have an account?", for: .normal)
        forgotPasswordButton.setTitle("Forgot Password?", for: .normal)
        forgotPasswordButton.contentHorizontalAlignment = .left
        forgotPasswordButton.titleLabel?.adjustsFontSizeToFitWidth = true
        googleButton.style = .wide
    }
    
    func setUpTFUI() {
        emailTextField.setTextField(string: "Email...")
        passwordTextField.setTextField(string: "Password...")
        passwordTextField.isSecureTextEntry = true
        emailTextField.delegate = self
        passwordTextField.delegate = self
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
            make.topMargin.equalTo(self.otterImage.snp_bottomMargin).offset(-20)
            make.height.equalTo(55)
            make.width.equalToSuperview().multipliedBy(0.61)
        }
        
        passwordTextField.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.topMargin.equalTo(self.emailTextField.snp_bottomMargin).offset(25)
            make.height.equalTo(55)
            make.width.equalToSuperview().multipliedBy(0.61)
        }
        
        forgotPasswordButton.snp.makeConstraints { (make) in
            make.leftMargin.equalTo(self.passwordTextField.snp_leftMargin).inset(6)
            make.topMargin.equalTo(self.passwordTextField.snp_bottomMargin).offset(23)
            make.height.equalTo(18)
            make.width.equalToSuperview().multipliedBy(0.32)
        }
        
        loginButton.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.topMargin.equalTo(self.forgotPasswordButton).offset(50)
            make.height.equalTo(40)
            make.width.equalToSuperview().multipliedBy(0.61)
        }
        
        googleButton.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.topMargin.equalTo(self.loginButton).offset(70)
            make.height.equalTo(40)
            make.width.equalToSuperview().multipliedBy(0.61)
        }
        
        noAccountButton.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.topMargin.equalTo(self.googleButton).offset(90)
            make.height.equalTo(30)
            make.width.equalToSuperview().multipliedBy(0.55)
        }
        
    }
    
    @objc func loginButtonTapped() {
        print("Login tapped")

        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
            if let error = error {
                self.loginButton.shakeButton()
                if let errCode = AuthErrorCode(rawValue: error._code) {
                    switch errCode {
                    case .invalidEmail:
                        self.createAlert(title: "There was a problem", message: "Invalid email, please try again")
                        return
                    case .wrongPassword:
                        self.createAlert(title: "There was a problem", message: "Incorrect password")
                        return
                    case .userDisabled:
                        self.createAlert(title: "There was a problem", message: "This account was disabled")
                        return
                    default:
                        self.createAlert(title: "There was a problem", message: "Unknown error, please try again")
                        return
                    }
                }
            }
            if user != nil {
                if Auth.auth().currentUser!.isEmailVerified {
                    let vc = MainTabBarController()
                    vc.modalPresentationStyle = .fullScreen
                    self.present(vc, animated: true, completion: nil)
                    
                }
                else {
                    // If email isn't verified
                    self.loginButton.shakeButton()
                    self.createAlert(title: "There was a problem", message: "Please verify your email")
                }
            }
        }
    }
    
    @objc func noAccountTapped() {
        print("No account tapped")
        self.navigationController?.pushViewController(SignUpViewController(), animated: true)
    }
    
    @objc func forgotPasswordTapped() {
        print("forgot password tapped")
        self.navigationController?.pushViewController(ForgotPasswordViewController(), animated: true)
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        textField.resignFirstResponder()
        return true
    }
}
