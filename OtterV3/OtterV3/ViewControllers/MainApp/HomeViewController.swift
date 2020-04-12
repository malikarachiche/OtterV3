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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
    }
    
    func setUpUI() {
        view.addSubview(button)
        
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
