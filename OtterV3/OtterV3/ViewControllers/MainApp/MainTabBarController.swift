//
//  MainTabBarViewController.swift
//  OtterV3
//
//  Created by Malik Arachiche on 4/12/20.
//  Copyright © 2020 Malik Arachiche. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    let homeVC = HomeViewController()
    let notificationVC = NotificationViewController()
    let profileVC = ProfileViewController()
    let settingsVC = SettingsViewController()
    
//    private let homeVC = HomeViewController()
//    private let notificationVC = NotificationViewController()
//    private let profileVC = ProfileViewController()
//    private let settingsVC = SettingsViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewControllers = [createController(title: "Home", imageName: "home", vc: homeVC),
                           createController(title: "Notification", imageName: "message", vc: notificationVC),
                           createController(title: "Profile", imageName: "report_card", vc: profileVC),
                           createController(title: "Settings", imageName: "settings", vc: settingsVC)]
    }
    
    private func createController(title: String, imageName: String, vc: UIViewController) -> UINavigationController {
        
        let recentVC = UINavigationController(rootViewController: vc)
        recentVC.tabBarItem.title = title
        recentVC.navigationBar.topItem?.title = title
        recentVC.tabBarItem.image = UIImage(named: imageName)
        //recentVC.navigationBar.prefersLargeTitles = true
        
        return recentVC
    }

}
