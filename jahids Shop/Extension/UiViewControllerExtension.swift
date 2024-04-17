//
//  UiViewControllerExtension.swift
//  jahids Shop
//
//  Created by jahidul islam on 7/4/24.
//

import Foundation
import UIKit

extension UIViewController {
    func DisplayAlert (title: String, massage: String) {
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        let alertController = UIAlertController(title: title, message: massage, preferredStyle: .alert)
        alertController.addAction(cancelAction)
        self.present(alertController,animated: true)
    }
    
    func writeToUserDefoults <T> (key: String, Value: T) {
        let userDefaults = UserDefaults.standard
        userDefaults.setValue(Value, forKey: key)
        userDefaults.synchronize()
    }
    
    func readFromUserDefoults <T> (key: String, defaultValue: T) -> T? {
        let userDefaults = UserDefaults.standard
        if defaultValue is String {
            if let value = userDefaults.string(forKey: key) as? String {
                return value as! T
            } else {
                return defaultValue
            }
        }
        
        return nil
    }
}
