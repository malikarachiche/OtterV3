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
    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        user = getUserFromDatabase(email: Auth.auth().currentUser?.email ?? "")
        print(" ")
        print("User data on home screen")
        print(user?.getData() ?? [:])
    }
    
    func setUpUI() {
        view.addSubview(button)
        
        view.backgroundColor = .white
        setConstraints()
        
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        button.setTitle(message: "Log out")
    }
    
    func setConstraints() {
        button.snp.makeConstraints { (make) in
            make.centerX.centerY.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.5)
            make.height.equalTo(50)
        }
    }
    
    @objc func buttonTapped() {
        print("Button tapped")
        signOutAndRedirect()
    }
}
