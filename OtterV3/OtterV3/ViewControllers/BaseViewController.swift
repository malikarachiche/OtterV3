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

    let database = Firestore.firestore()
    
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
    
    func getUserFromDatabase(email: String) {
        database.collection("users").whereField("email", isEqualTo: email).getDocuments { (snapshot, error) in
            if let error = error {
                print("Error getting documents: \(error.localizedDescription)")
            } else {
                for document in snapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                }
            }
        }
    }
    
    func addUserToDatabase(name: String, career: String) {
        let currentUser = Auth.auth().currentUser
        if currentUser != nil {
            let currentDate = getCurrentDate()
            let user = User(id: currentUser!.uid, email: currentUser?.email ?? "", name: name, dateJoined: currentDate, career: career)
            
            database.collection("users").document(user.getID()).setData(user.getData()) { error in
                if let error = error {
                    print("Error creating a new user: \(error.localizedDescription)")
                    return
                } else {
                    print("User document successfully created")
                }
            }
        }
        signOut()
    }
    
    func getCurrentDate() -> String {
        let currentDateTime = Date()
        let formatter = DateFormatter()
        formatter.timeStyle = .none
        formatter.dateStyle = .medium
        
        let dateTimeString = formatter.string(from: currentDateTime)
        
        return dateTimeString
    }
    
    func signOutAndRedirect() {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            GIDSignIn.sharedInstance()?.disconnect()
            let vc = UINavigationController(rootViewController: LoginViewController())
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: false, completion: nil)
            print("Logging out")
        } catch let signOutError as NSError {
            print("Sign out error \(signOutError)" )
        }
    }
    
    func signOut() {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            GIDSignIn.sharedInstance()?.disconnect()
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
