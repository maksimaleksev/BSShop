//
//  MainTabBarController.swift
//  BlackStarShop
//
//  Created by Maxim Alekseev on 28.04.2020.
//  Copyright © 2020 Maxim Alekseev. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    private let currentUser: MUser
       
       init(currentUser: MUser = MUser(name: "Unknown",
                                       secondName: "Unknown",
                                       city: "Unknown",
                                       address: "Unknown",
                                       avatarStringURL: "Unknown",
                                       email: "Unknown",
                                       id: "Unknown")) {
           self.currentUser = currentUser
           super.init(nibName: nil, bundle: nil)
       }
       
       required init?(coder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }

    override func viewDidLoad() {
        super.viewDidLoad()
            
        let categoryVC = CategoryViewController()
        let profileVC = ProfileViewController()
        let cartVC = CartViewController()
        let boldConfig = UIImage.SymbolConfiguration(weight: .medium)
        let profileImage = UIImage(systemName: "person", withConfiguration: boldConfig)!
        let cartImage = UIImage(systemName: "cart", withConfiguration: boldConfig)!
        let categoryImage = UIImage(systemName: "bag", withConfiguration: boldConfig)!

        viewControllers = [
            generateNavigationController(rootViewController: categoryVC, title: "Категории", image: categoryImage),
            generateNavigationController(rootViewController: profileVC, title: "Профиль", image: profileImage),
            generateNavigationController(rootViewController: cartVC, title: "Корзина", image: cartImage)
        ]
        
            }

    private func generateNavigationController (rootViewController: UIViewController, title: String, image: UIImage) -> UIViewController {
        let navigationVC = UINavigationController(rootViewController: rootViewController)
        navigationVC.tabBarItem.title = title
        navigationVC.tabBarItem.image = image
        return navigationVC
    }

}
