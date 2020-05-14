//
//  ProfileViewController.swift
//  BlackStarShop
//
//  Created by Maxim Alekseev on 28.04.2020.
//  Copyright © 2020 Maxim Alekseev. All rights reserved.
//

import UIKit
import SwiftUI
import SDWebImage

class ProfileViewController: UIViewController {
    
    private let currentUser: MUser
    
    init(currentUser: MUser) {
        self.currentUser = currentUser
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var profileImageView: UIImageView = {
        let profileImageView = UIImageView()
        profileImageView.image = #imageLiteral(resourceName: "avatar")
        return profileImageView
    }()
    
    var nameLabel = UILabel(text: "Имя:", font: .sfProDisplay15, textColor: #colorLiteral(red: 0.4470588235, green: 0.4470588235, blue: 0.4470588235, alpha: 1))
    var secondNameLabel = UILabel(text: "Фамилия:", font: .sfProDisplay15, textColor: #colorLiteral(red: 0.4470588235, green: 0.4470588235, blue: 0.4470588235, alpha: 1))
    var cityLabel = UILabel(text: "Город:", font: .sfProDisplay15, textColor: #colorLiteral(red: 0.4470588235, green: 0.4470588235, blue: 0.4470588235, alpha: 1))
    var addressLabel = UILabel(text: "Адрес:", font: .sfProDisplay15, textColor: #colorLiteral(red: 0.4470588235, green: 0.4470588235, blue: 0.4470588235, alpha: 1))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setNavigationBarItems()
        setupConstraints()
        setUpValuesForUIElements()
        
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        profileImageView.layer.cornerRadius = profileImageView.frame.width / 2
        profileImageView.clipsToBounds = true
        profileImageView.layer.borderColor = UIColor.customGrey().cgColor
        profileImageView.layer.borderWidth = 1
    }
    
    private func setUpValuesForUIElements() {
        nameLabel.text = "Имя: " + currentUser.name
        secondNameLabel.text = "Фамилия: " + currentUser.secondName
        cityLabel.text = "Город: " + currentUser.city
        addressLabel.text = "Адрес: " + currentUser.address
        profileImageView.sd_setImage(with: URL(string: currentUser.avatarStringURL))
        profileImageView.contentMode = .scaleAspectFill
        
    }
    
    private func setNavigationBarItems() {
        navigationItem.title = "Ваш профиль"
        let rightBarButtonItem = UIBarButtonItem(title: "Изменить", style: .done, target: self, action: #selector(changeProfile))
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
    @objc private func changeProfile() {
        let changeVC = ChangeProfileViewController(currentUser: currentUser)
        self.present(changeVC, animated: true)
    }
    
}

//MARK: - Setup Constraints

extension ProfileViewController {
    func setupConstraints() {
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(profileImageView)
        
        let stackView = UIStackView(arrangedSubviews: [nameLabel, secondNameLabel, cityLabel, addressLabel], axis: .vertical, spacing: 64)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        
        let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        let topPadding = window?.safeAreaInsets.top
        
        NSLayoutConstraint.activate([
            profileImageView.heightAnchor.constraint(equalToConstant: 100),
            profileImageView.widthAnchor.constraint(equalToConstant: 100),
            profileImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: (topPadding ?? 0) + 44 + 24),
            profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 32),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32)
        ])
        
    }
}


//MARK: - For Canvas prewiew (SwiftUI)

struct ProfileVCProvider: PreviewProvider {
    
    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        
        let tabBarVC = MainTabBarController()
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<ProfileVCProvider.ContainerView>) -> MainTabBarController {
            return tabBarVC
        }
        
        func updateUIViewController(_ uiViewController: ProfileVCProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<ProfileVCProvider.ContainerView>) {
            
        }
    }
    
}
