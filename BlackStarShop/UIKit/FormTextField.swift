//
//  FormTextField.swift
//  BlackStarShop
//
//  Created by Maxim Alekseev on 17.04.2020.
//  Copyright © 2020 Maxim Alekseev. All rights reserved.
//

import UIKit

class FormTextField: UITextField {

    convenience init (font: UIFont? = .sfProDisplay15) {
        self.init()
        self.font = font
        self.borderStyle = .none
        self.layer.borderWidth = 1
        self.layer.borderColor = #colorLiteral(red: 0.5921568627, green: 0.5921568627, blue: 0.5921568627, alpha: 1)
        self.layer.cornerRadius = 8
        self.clipsToBounds = true
        self.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.frame.height))
        self.leftViewMode = .always
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
