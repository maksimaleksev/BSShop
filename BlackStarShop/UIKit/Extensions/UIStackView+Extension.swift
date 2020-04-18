//
//  UIStackView+Extension.swift
//  BlackStarShop
//
//  Created by Maxim Alekseev on 17.04.2020.
//  Copyright © 2020 Maxim Alekseev. All rights reserved.
//

import UIKit

extension UIStackView {
    
    convenience init(arrangedSubviews: [UIView], axis: NSLayoutConstraint.Axis, spacing: CGFloat) {
        self.init(arrangedSubviews: arrangedSubviews)
        self.axis = axis
        self.spacing = spacing
    }
}

