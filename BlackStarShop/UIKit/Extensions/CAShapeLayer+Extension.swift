//
//  CAShapeLayer+Extension.swift
//  BlackStarShop
//
//  Created by Maxim Alekseev on 01.05.2020.
//  Copyright © 2020 Maxim Alekseev. All rights reserved.
//

import UIKit

extension CAShapeLayer {
    func drawRoundedRect(rect: CGRect, andColor color: UIColor, filled: Bool) {
        fillColor = filled ? color.cgColor : UIColor.white.cgColor
        strokeColor = color.cgColor
        path = UIBezierPath(roundedRect: rect, cornerRadius: 7).cgPath
    }
}
