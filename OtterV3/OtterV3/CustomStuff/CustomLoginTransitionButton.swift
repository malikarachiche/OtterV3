//
//  CustomLoginTransitionButton.swift
//  OtterV3
//
//  Created by Malik Arachiche on 4/10/20.
//  Copyright © 2020 Malik Arachiche. All rights reserved.
//

import UIKit

class CustomLoginTransitionButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        makeButtonCool()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        makeButtonCool()
    }
    
    func makeButtonCool() {
        layer.cornerRadius      = 5
        backgroundColor         = UIColor.clear
        tintColor               = UIColor.white
        setTitleColor(UIColor.white, for: .normal)
    }
    
    func shakeButton() {
        let shake = CABasicAnimation(keyPath: "position")
        shake.duration = 0.1
        shake.repeatCount = 2
        shake.autoreverses = true
        
        let fromPoint = CGPoint(x: center.x - 8, y: center.y)
        let fromValue = NSValue(cgPoint: fromPoint)
        
        let toPoint = CGPoint(x: center.x + 8, y: center.y)
        let toValue = NSValue(cgPoint: toPoint)
        
        shake.fromValue = fromValue
        shake.toValue = toValue
        
        layer.add(shake, forKey: "position")
    }
    
    
}
