//
//  ProfileViewController.swift
//  BlackStarShop
//
//  Created by Maxim Alekseev on 20.04.2020.
//  Copyright © 2020 Maxim Alekseev. All rights reserved.
//

import UIKit
import SwiftUI

class SetupProfileViewController: UIViewController {
    
    let createProfileLabel = UILabel(text: "Создайте профиль", font: .sfProDisplay18, textColor: #colorLiteral(red: 0.4470588235, green: 0.4470588235, blue: 0.4470588235, alpha: 1))
    let profileImageView = AddPhotoView()
    let nameLabel = UILabel(text: "Имя:", font: .sfProDisplay15, textColor: #colorLiteral(red: 0.4470588235, green: 0.4470588235, blue: 0.4470588235, alpha: 1))
    let nameTextField = FormTextField(font: .sfProDisplay15)
    let secondNameLabel = UILabel(text: "Фамилия:", font: .sfProDisplay15, textColor: #colorLiteral(red: 0.4470588235, green: 0.4470588235, blue: 0.4470588235, alpha: 1))
    let secondNameTextField = FormTextField(font: .sfProDisplay15)
    let cityLabel = UILabel(text: "Город:", font: .sfProDisplay15, textColor: #colorLiteral(red: 0.4470588235, green: 0.4470588235, blue: 0.4470588235, alpha: 1))
    let cityTextField = FormTextField(font: .sfProDisplay15)
    let addressLabel = UILabel(text: "Адрес:", font: .sfProDisplay15, textColor: #colorLiteral(red: 0.4470588235, green: 0.4470588235, blue: 0.4470588235, alpha: 1))
    let addressTextField = FormTextField(font: .sfProDisplay15)
    let createProfileButton = UIButton(title: "Создать профиль",
                                       backgroundColor: #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1), titleColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0),
                                       font: .sfProDisplay15, cornerRadius: 24)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createProfileLabel.textAlignment = .center
        view.backgroundColor = .white
        setupConstraints()
        
    }
    
}

extension SetupProfileViewController {
    
    func setupConstraints() {
        
        let stackView = UIStackView(arrangedSubviews: [nameLabel, nameTextField, secondNameLabel, secondNameTextField, cityLabel, cityTextField, addressLabel, addressTextField], axis: .vertical, spacing: 8)
        let loginVCElements = [createProfileLabel, stackView, profileImageView, createProfileButton]
        loginVCElements.forEach { [weak self](element) in
            if let self = self {
                element.translatesAutoresizingMaskIntoConstraints = false
                self.view.addSubview(element)
            }
        }
        
        let setupProfileTextfields = [nameTextField,
                                      secondNameTextField,
                                      cityTextField,
                                      addressTextField]
        setupProfileTextfields.forEach { (setupProfileTextfield) in
            setupProfileTextfield.heightAnchor.constraint(equalToConstant: 48).isActive = true
        }
        
        NSLayoutConstraint.activate([
            createProfileLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 56),
            createProfileLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profileImageView.topAnchor.constraint(equalTo: createProfileLabel.bottomAnchor, constant: 6),
            profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 1),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 27),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -27),
            createProfileButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 48),
            createProfileButton.heightAnchor.constraint(equalToConstant: 48),
            createProfileButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            createProfileButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15)
        ])
    }
}

//MARK: - For Canvas prewiew (SwiftUI)

struct SetupProfileVCProvider: PreviewProvider {
    
    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        
        let viewController = SetupProfileViewController()
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<SetupProfileVCProvider.ContainerView>) -> SetupProfileViewController {
            return viewController
        }
        
        func updateUIViewController(_ uiViewController: SetupProfileVCProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<SetupProfileVCProvider.ContainerView>) {
            
        }
    }
    
}
