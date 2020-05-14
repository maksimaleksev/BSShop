//
//  InstantPanGestureRecognizer.swift
//  Transition
//
//  Created by Maxim Alekseev on 06.05.2020.
//  Copyright © 2020 Maxim Alekseev. All rights reserved.
//

import UIKit

class InstantPanGestureRecognizer: UIPanGestureRecognizer {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
        if (self.state == .began) { return }
        super.touchesBegan(touches, with: event)
        self.state = .began
    }
}
