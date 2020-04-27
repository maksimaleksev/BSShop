//
//  UIFont+Extension.swift
//  BlackStarShop
//
//  Created by Maxim Alekseev on 15.04.2020.
//  Copyright © 2020 Maxim Alekseev. All rights reserved.
//

import UIKit

extension UIFont {
    
    static var helvetica36: UIFont? {
        return UIFont.init(name: "HelveticaNeue-Bold", size: 36)
    }
    
    static var akzidenzGroteskPro40: UIFont? {
        return UIFont.init(name: "AkzidenzGroteskPro-BoldCn", size: 40)
    }
    static var sfProDisplay15: UIFont? {
        return UIFont.init(name: "SFProDisplay-Semibold", size: 15)
    }
    
    static var sfProDisplay18: UIFont? {
        return UIFont.init(name: "SFProDisplay-Semibold", size: 18)
    }
    
    static func sfProDisplay16() -> UIFont? {
        return UIFont.init(name: "SFProDisplay-Medium", size: 16)
    }
    
    static func sfProDisplay11() -> UIFont? {
        return UIFont.init(name: "SFProDisplay-Medium", size: 11)
    }
    
    static func robotoBold8() -> UIFont? {
        return UIFont.init(name: "Roboto-Bold", size: 8)
    }
}

