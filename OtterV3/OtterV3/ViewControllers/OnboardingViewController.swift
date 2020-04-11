//
//  OnboardingViewController.swift
//  OtterV3
//
//  Created by Malik Arachiche on 4/10/20.
//  Copyright © 2020 Malik Arachiche. All rights reserved.
//

import UIKit
import SnapKit
import paper_onboarding

class OnboardingViewController: UIViewController, PaperOnboardingDelegate, PaperOnboardingDataSource {
    
    let onboardingView = PaperOnboarding()
    let getStartedButton = UIButton()
    
    override func viewDidLoad() {
        onboardingView.dataSource = self
        onboardingView.delegate = self
        setUpUI()
    }
    
    func setUpUI() {
        view.addSubview(onboardingView)
        view.addSubview(getStartedButton)
        navigationController?.navigationBar.isHidden = true
        getStartedButton.addTarget(self, action: #selector(getStartedTapped), for: .touchUpInside)
        getStartedButton.alpha = 0.0
        getStartedButton.setTitle("Get Started", for: .normal)
        getStartedButton.setTitleColor(UIColor.white, for: .normal)
        getStartedButton.backgroundColor = UIColor.clear
        
        setConstraints()
    }
    
    func setConstraints() {
        
        onboardingView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
        
        getStartedButton.snp.makeConstraints { (make) in
            make.bottomMargin.equalToSuperview().inset(120)
            make.centerX.equalTo(self.view)
            make.height.equalToSuperview().multipliedBy(0.15)
            make.width.equalToSuperview().multipliedBy(0.75)
        }
    }
    
    func onboardingItemsCount() -> Int {
        return 4
    }
    
    func onboardingItem(at index: Int) -> OnboardingItemInfo {
        let backgroundColorOne = Colors.darkPurple
        let backgroundColorTwo = Colors.anotherDarkPurple
        let backgroundColorThree = Colors.lighterPurple
        let backgroundColorFour = Colors.darkTeal
        
        let titleFont = UIFont(name: "AppleSDGothicNeo-Regular", size: 24)!
        let descriptionFont = UIFont(name: "AppleSDGothicNeo-UltraLight", size: 20)!
        
        let firstImage = UIImage(named: "collaboration")
        let secondImage = UIImage(named: "goal")
        let thirdImage = UIImage(named: "stethoscope")
        let pageIcon = UIImage(named: "otter-logo-white-10")
        
        let firstScreen = OnboardingItemInfo(informationImage: firstImage!, title: "Welcome to Otter!", description: "An app designed to bridge the gap between a student and their dream job!", pageIcon: pageIcon!, color: backgroundColorOne, titleColor: UIColor.white, descriptionColor: UIColor.white, titleFont: titleFont, descriptionFont: descriptionFont)
        
        let secondScreen = OnboardingItemInfo(informationImage: secondImage!, title: "Gain Experience!", description: "Complete tasks for students in need of your skills!", pageIcon: pageIcon!, color: backgroundColorTwo, titleColor: UIColor.white, descriptionColor: UIColor.white, titleFont: titleFont, descriptionFont: descriptionFont)
        
        let thirdScreen = OnboardingItemInfo(informationImage: thirdImage!, title: "Create Opportunity", description: "Post tasks that you need to be completed", pageIcon: pageIcon!, color: backgroundColorThree, titleColor: UIColor.white, descriptionColor: UIColor.white, titleFont: titleFont, descriptionFont: descriptionFont)
        
        let fourthScreen = OnboardingItemInfo(informationImage: firstImage!, title: "Reflect", description: "On your work to prepare yourself for telling your story", pageIcon: pageIcon!, color: backgroundColorFour, titleColor: UIColor.white, descriptionColor: UIColor.white, titleFont: titleFont, descriptionFont: descriptionFont)
        
        let screens: [OnboardingItemInfo] = [firstScreen, secondScreen, thirdScreen, fourthScreen]
        
        return screens[index]
    }
    
    func onboardingDidTransitonToIndex(_ index : Int) {
        if index == 3 {
            UIView.animate(withDuration: 0.4) {
                self.getStartedButton.alpha = 1
            }
        }
    }
    
    func onboardingWillTransitonToIndex(_ index: Int) {
        if index != 3 {
            if self.getStartedButton.alpha == 1 {
                UIView.animate(withDuration: 0.4) {
                    self.getStartedButton.alpha = 0
                }
            }
        }
    }
    
    @objc func getStartedTapped() {
        print("Getting started")
        self.navigationController?.pushViewController(LoginViewController(), animated: false)
        //present(LoginViewController(), animated: true, completion: nil)
    }
}
