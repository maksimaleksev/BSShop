//
//  ScrollWhenKeyboardAppears.swift
//  BlackStarShop
//
//  Created by Maxim Alekseev on 01.06.2020.
//  Copyright © 2020 Maxim Alekseev. All rights reserved.
//

import UIKit

protocol ScrollWhenKeyboardAppears {
    var scrollView: UIScrollView { get }
    func registerForKeyboardNotifications()
    func removeKeyboardNotifications()
    func setScrollSizeWhenKeyboardAppears(notification: Notification)
}

extension ScrollWhenKeyboardAppears where Self: KeyboardAdjusting, Self: UIViewController {
    
    func registerForKeyboardNotifications() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    func removeKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func setScrollSizeWhenKeyboardAppears(notification: Notification) {
            guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }

            let keyboardScreenEndFrame = keyboardValue.cgRectValue
            let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)

            if notification.name == UIResponder.keyboardWillHideNotification {
                scrollView.contentInset = .zero
            } else {
                scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height, right: 0)
            }
            scrollView.scrollIndicatorInsets = scrollView.contentInset
    }

}
