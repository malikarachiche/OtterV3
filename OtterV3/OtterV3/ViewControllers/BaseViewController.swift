//
//  BaseViewController.swift
//  OtterV3
//
//  Created by Malik Arachiche on 4/10/20.
//  Copyright © 2020 Malik Arachiche. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    func createAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    /**
     Allows dismissal of keyboard
     */
    func setUpGestureRecognizer() {
        let tapRecognizer: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(BaseViewController.dismissKeyboard))
        
        self.view.addGestureRecognizer(tapRecognizer)
        tapRecognizer.cancelsTouchesInView = false
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func getCurrentDate() -> String {
        let currentDateTime = Date()
        let formatter = DateFormatter()
        formatter.timeStyle = .none
        formatter.dateStyle = .medium
        
        let dateTimeString = formatter.string(from: currentDateTime)
        
        return dateTimeString
    }
    
    func signOut(redirect: UIViewController) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            GIDSignIn.sharedInstance()?.disconnect()
            present(redirect, animated: true, completion: nil)
            print("Logging out")
        } catch let signOutError as NSError {
            print("Sign out error \(signOutError)" )
        }
    }
    
    func setUpLabel(label: UILabel, text: String) {
        label.text = text
        label.textColor = UIColor.white
        label.backgroundColor = .clear
        label.textAlignment = .center
        label.numberOfLines = 5
        label.font = UIFont(name: "PingFangTC-Light", size: 20)
    }

}
