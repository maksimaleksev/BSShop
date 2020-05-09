//
//  Validators.swift
//  IChat
//
//  Created by Maxim Alekseev on 27.03.2020.
//  Copyright © 2020 Maxim Alekseev. All rights reserved.
//

import Foundation

class Validators {
    static func isFilled(email: String?, password: String?, confirmPassword: String?) -> Bool {
        guard let email = email,
            let password = password,
            let confirmPassword = confirmPassword,
            email  != "",
            password != "",
            confirmPassword != ""
        else { return false }
        
        return true
    }
    
    static func isFilled(name: String?, secondName: String?, city: String?, address: String?) -> Bool {
        guard let name = name,
            let secondName = secondName,
            let city = city,
            let address = address,
            name  != "",
            secondName != "",
            city != "",
            address != ""
        else { return false }
        
        return true
    }

    
    
    static func isSimpleEmail(_ email: String) -> Bool {
        let emailRegEx = "^.+@.+\\..{2,}$"
        return check(text: email, regEx: emailRegEx)
    }
    
    private static func check(text: String, regEx: String) -> Bool {
        let predicate = NSPredicate(format: "SELF MATCHES %@", regEx)
        return predicate.evaluate(with: text)
    }
}
