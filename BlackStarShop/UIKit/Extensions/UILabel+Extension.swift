//
//  UILabel+extension.swift
//  BlackStarShop
//
//  Created by Maxim Alekseev on 15.04.2020.
//  Copyright © 2020 Maxim Alekseev. All rights reserved.
//

import UIKit

extension UILabel {
    
    convenience init (text: String, font: UIFont?, textColor: UIColor? = .black) {
        self.init()
        self.text = text
        self.font = font
        self.textColor = textColor
    }
}
