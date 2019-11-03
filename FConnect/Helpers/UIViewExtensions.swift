//
//  UIViewExtensions.swift
//  FConnect
//
//  Created by hor kimleng on 11/2/19.
//  Copyright © 2019 kimlenghor. All rights reserved.
//

import UIKit

extension UIView {
    func createRoundCorner(cornerRadius: CGFloat) {
        self.layer.cornerRadius = cornerRadius
    }
    
    func setupTheBottomBorder() {
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0.0, y: self.frame.height - 1, width: self.frame.width, height: 1.0)
        bottomLine.backgroundColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
        self.layer.addSublayer(bottomLine)
    }
    
    func createSpecificRoundCorner(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    
    //create shadow
    func createShadow(color: CGColor) {
        layer.shadowColor = color
        layer.shadowOpacity = 0.25
        layer.shadowOffset = .zero
        layer.shadowRadius = 5
        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        layer.cornerRadius = 14
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
    }
}

//create gradient
var gradientLayer: CAGradientLayer!

func createLinearGradient(gradientView: UIView, firstColor: UIColor, secondColor: UIColor, radius: CGFloat) {
    gradientLayer = CAGradientLayer()
    gradientLayer.frame = gradientView.bounds
    gradientLayer.colors = [firstColor.cgColor, secondColor.cgColor]
    gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
    gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
    gradientView.createRoundCorner(cornerRadius: radius)
    gradientView.clipsToBounds = true
    gradientView.layer.insertSublayer(gradientLayer, at: 0)
}

extension UITextField {
    func createPadding() {
        let paddingView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 0))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
}




