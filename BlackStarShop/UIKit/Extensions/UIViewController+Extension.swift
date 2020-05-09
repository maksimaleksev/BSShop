//
//  UIViewController+Extension.swift
//  BlackStarShop
//
//  Created by Maxim Alekseev on 08.05.2020.
//  Copyright © 2020 Maxim Alekseev. All rights reserved.
//

import UIKit

extension UIViewController {
    func showAlert(with title: String, and message: String, completion: @escaping() -> Void = { }) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (_) in
            completion()
        }
        alertController.addAction(okAction)
        present(alertController, animated: true)
    }
}
