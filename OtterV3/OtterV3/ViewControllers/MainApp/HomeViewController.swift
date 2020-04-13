//
//  HomeViewController.swift
//  OtterV3
//
//  Created by Malik Arachiche on 4/12/20.
//  Copyright © 2020 Malik Arachiche. All rights reserved.
//

import UIKit
import SnapKit
import Firebase

class HomeViewController: BaseViewController {

    let button = CustomLoginButton()
    let label = UILabel()
    
    override var currentUser: User? {
        didSet {
            label.text = "Welcome \(currentUser?.getName() ?? "nil")"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getUserFromDatabase()
        setUpUI()
        print("User info")
        print("Name: \(currentUser?.getName()), Email: \(currentUser?.getEmail()), Career: \(currentUser?.getCareer()), Date Joined: \(currentUser?.getDateJoined())")
        if let email = Auth.auth().currentUser?.email {
            print("Email in home screen: \(email)")
        }
        sleep(3)
        label.text = "Welcome \(currentUser?.getName() ?? "nil")"
        
    }
    
    func setUpUI() {
        view.addSubview(label)
        
        view.backgroundColor = .white
        setUpLabel(label: label, text: "Welcome \(currentUser?.getName() ?? "nil")")
        label.textColor = .black
        
        setConstraints()
    }
    
    func setConstraints() {
        
        label.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.height.equalTo(40)
            make.width.equalToSuperview().multipliedBy(0.9)
            make.centerY.equalToSuperview().offset(-150)
        }
    }
}
