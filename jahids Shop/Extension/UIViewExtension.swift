//
//  UIViewExtension.swift
//  jahids Shop
//
//  Created by jahidul islam on 22/2/24.
//

import Foundation
import UIKit

extension UIView {
    
    public func ApplyCorner (CornerRadius: Double,BorderWidth: Double, BorderColor: UIColor) {
        self.layer.borderColor = BorderColor.cgColor
        self.layer.cornerRadius = CornerRadius
        self.layer.borderWidth = BorderWidth
        self.clipsToBounds = true
    }
    
    public func addShadow(color: UIColor, radius: CGFloat, offset: CGSize, opacity: Float) {
        self.layer.shadowRadius = radius
        self.layer.shadowOffset = offset
        self.layer.shadowOpacity = opacity
        self.layer.shadowColor = color.cgColor
        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        //self.layer.masksToBounds = true
        }
}
