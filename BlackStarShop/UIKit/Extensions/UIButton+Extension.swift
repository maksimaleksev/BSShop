//
//  UIButton+Extension.swift
//  BlackStarShop
//
//  Created by Maxim Alekseev on 15.04.2020.
//  Copyright © 2020 Maxim Alekseev. All rights reserved.
//

import UIKit

extension UIButton {
    
    convenience init(title: String,
                     backgroundColor: UIColor,
                     titleColor: UIColor,
                     font: UIFont? = .sfProDisplay15,
                     cornerRadius: CGFloat = 4) {
        self.init (type: .system)
        self.setTitle(title, for: .normal)
        self.setTitleColor(titleColor, for: .normal)
        self.backgroundColor = backgroundColor
        self.titleLabel?.font = font
        self.layer.cornerRadius = cornerRadius
    }
}
