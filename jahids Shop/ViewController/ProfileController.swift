//
//  ProfileController.swift
//  jahids Shop
//
//  Created by jahidul islam on 7/3/24.
//

import UIKit
import ActionKit

class ProfileController: UIViewController {
    
    @IBOutlet weak var profilePhotoImageView: UIImageView!
    @IBOutlet weak var notifySwitch: UISwitch!
    @IBOutlet weak var notifyLavel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "My Profile"
        
        self.profilePhotoImageView.ApplyCorner(CornerRadius: self.profilePhotoImageView.frame.width/2.0, BorderWidth: 0.5, BorderColor: .darkGray)
        
        self.notifySwitch.addControlEvent(.valueChanged) {
            print("Switch --> \(self.notifySwitch.isOn)")
            if self.notifySwitch.isOn {
                self.notifyLavel.text = "Notify me When Order Processed."
            } else {
                self.notifyLavel.text = "Don't Notify me When Order Processed."
            }
        }
        
        let singleTabGestureRecognizer = UITapGestureRecognizer () {
            self.view.backgroundColor = self.getRendomColor()
        }
        self.notifyLavel.isUserInteractionEnabled = true
        self.notifySwitch.addGestureRecognizer(singleTabGestureRecognizer)
        
    }
    
    func getRendomColor () -> UIColor {
        return UIColor(red: getRendomNumber(), green: getRendomNumber(), blue: getRendomNumber(), alpha: 1.0)
    }
    
    func getRendomNumber () -> Double {
        return Double(arc4random() % 255) / 255.0
    }
    

}
