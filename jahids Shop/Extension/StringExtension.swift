//
//  StringExtension.swift
//  jahids Shop
//
//  Created by jahidul islam on 7/4/24.
//

import Foundation

extension String {
    func isValidateEmail () -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: self)
    }
    
    func isValidatePassword () -> Bool {
        return self.count > 5
    }
}
