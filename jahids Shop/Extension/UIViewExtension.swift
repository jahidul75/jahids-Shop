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
}
