//
//  BaseViewController.swift
//  OtterV3
//
//  Created by Malik Arachiche on 4/10/20.
//  Copyright © 2020 Malik Arachiche. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestoreSwift
import GoogleSignIn

class BaseViewController: UIViewController {

    let database = Firestore.firestore()
    var currentUser: User?
    
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
    
    func getUserFromDatabase() {
        self.database.collection("users").document(Auth.auth().currentUser?.uid ?? "").getDocument { (document, error) in
            let result = Result {
                try document.flatMap {
                    try $0.data(as: User.self)
                }
            }
            switch result {
            case .success(let user):
                if let user = user {
                    print("User: \(user)")
                    self.currentUser = user
                    print("User name: \(self.currentUser!.getName())")
                    print("User email: \(self.currentUser!.getEmail())")
                    print("User career: \(self.currentUser!.getCareer())")
                    print("User email: \(self.currentUser!.getDateJoined())")
                    print("User connections: \(self.currentUser!.getConnections())")
                } else {
                    print("Document does not exist")
                }
            case .failure(let error):
                print("Error decoding user: \(error)")
            }
        }
    }
        
    
    func addUserToDatabase(name: String, career: String) {
        let currentUser = Auth.auth().currentUser
        if currentUser != nil {
            let currentDate = getCurrentDate()
            let initialData: [String: String] = ["id": currentUser?.uid ?? "13123", "email": currentUser?.email ?? "", "name": name, "dateJoined": currentDate, "career": career]
            let user = User(data: initialData)
            
            do {
                try database.collection("users").document(user.getID()).setData(from: user)
            } catch let error {
                print("Error writing: \(error)")
            }
            print("User document successfully created")
        }
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
