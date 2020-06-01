//
//  KeyboardAdjusting.swift
//  BlackStarShop
//
//  Created by Maxim Alekseev on 01.06.2020.
//  Copyright © 2020 Maxim Alekseev. All rights reserved.
//

import UIKit

@objc protocol KeyboardAdjusting {
    @objc func adjustForKeyboard(notification: Notification)
}
