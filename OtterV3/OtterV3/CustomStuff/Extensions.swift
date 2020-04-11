//
//  Extensions.swift
//  OtterV3
//
//  Created by Malik Arachiche on 4/10/20.
//  Copyright © 2020 Malik Arachiche. All rights reserved.
//

import UIKit
import TextFieldEffects

extension UIView {
    func setGradientBackground(colorOne: UIColor, colorTwo: UIColor, colorThree: UIColor)  {
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [colorOne.cgColor, colorTwo.cgColor, colorThree.cgColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.startPoint = CGPoint(x: 1.0, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 0.0, y: 0.0)
        
        layer.insertSublayer(gradientLayer, at: 0)
    }
}

extension HoshiTextField {
    func setTextField(string: String) {
        placeholder = string
        placeholderFontScale = 0.85
        
        placeholderColor = UIColor.white
        borderInactiveColor = UIColor.white
        borderActiveColor = Colors.darkTeal
        textColor = UIColor.white
        clearButtonMode = .whileEditing
    }
}
