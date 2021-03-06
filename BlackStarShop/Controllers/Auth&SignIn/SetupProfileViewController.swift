//
//  ProfileViewController.swift
//  BlackStarShop
//
//  Created by Maxim Alekseev on 20.04.2020.
//  Copyright © 2020 Maxim Alekseev. All rights reserved.
//

import UIKit
import SwiftUI
import FirebaseAuth
import SDWebImage

class SetupProfileViewController: UIViewController {
    
    internal let scrollView: UIScrollView = {
       let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let createProfileLabel = UILabel(text: "Создайте профиль", font: .sfProDisplay18, textColor: #colorLiteral(red: 0.4470588235, green: 0.4470588235, blue: 0.4470588235, alpha: 1))
    private let profileImageView = AddPhotoView()
    private let nameLabel = UILabel(text: "Имя:", font: .sfProDisplay15, textColor: #colorLiteral(red: 0.4470588235, green: 0.4470588235, blue: 0.4470588235, alpha: 1))
    private let nameTextField = FormTextField(font: .sfProDisplay15)
    private let secondNameLabel = UILabel(text: "Фамилия:", font: .sfProDisplay15, textColor: #colorLiteral(red: 0.4470588235, green: 0.4470588235, blue: 0.4470588235, alpha: 1))
    private let secondNameTextField = FormTextField(font: .sfProDisplay15)
    private let cityLabel = UILabel(text: "Город:", font: .sfProDisplay15, textColor: #colorLiteral(red: 0.4470588235, green: 0.4470588235, blue: 0.4470588235, alpha: 1))
    private let cityTextField = FormTextField(font: .sfProDisplay15)
    private let addressLabel = UILabel(text: "Адрес:", font: .sfProDisplay15, textColor: #colorLiteral(red: 0.4470588235, green: 0.4470588235, blue: 0.4470588235, alpha: 1))
    private let addressTextField = FormTextField(font: .sfProDisplay15)
    private let createProfileButton = UIButton(title: "Создать профиль",
                                       backgroundColor: #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1), titleColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0),
                                       font: .sfProDisplay15, cornerRadius: 24)
    
    private var currentUser: User
    
    init(currentUser: User) {
        self.currentUser = currentUser
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createProfileLabel.textAlignment = .center
        view.backgroundColor = .white
        setupConstraints()
        createProfileButton.addTarget(self, action: #selector(createProfileButtonTapped), for: .touchUpInside)
        profileImageView.plusButton.addTarget(self, action: #selector(plusButtonTapped), for: .touchUpInside)
        registerForKeyboardNotifications()
        self.hideKeyboardWhenTappedAround()
        
    }
    
    deinit {
        removeKeyboardNotifications()
    }
    
    @objc private func createProfileButtonTapped() {
        FirestoreService.shared.saveProfileWith(id: currentUser.uid,
                                                email: currentUser.email!,
                                                name: nameTextField.text,
                                                avatarImage: profileImageView.circleImageView.image,
                                                secondName: secondNameTextField.text,
                                                city: cityTextField.text,
                                                address: addressTextField.text) { (result) in
                                                    switch result {
                                                    case .success(let mUser):
                                                        self.showAlert(with: "Успешно", and: "Приятных вам покупок!", completion: { [weak self] in
                                                            let mainTabBarController = MainTabBarController(currentUser: mUser)
                                                            mainTabBarController.modalPresentationStyle = .fullScreen
                                                            self?.present(mainTabBarController, animated: true)
                                                        })
                                                        
                                                    case .failure(let error):
                                                        self.showAlert(with: "Ошибка", and: error.localizedDescription)
                                                    }
                                                    
        }
    }
    
    @objc private func plusButtonTapped() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        present(imagePickerController, animated: true)
    }

    
}

extension SetupProfileViewController {
    
    private func setupConstraints() {
        view.addSubview(scrollView)
        let stackView = UIStackView(arrangedSubviews: [nameLabel, nameTextField, secondNameLabel, secondNameTextField, cityLabel, cityTextField, addressLabel, addressTextField], axis: .vertical, spacing: 8)
        let loginVCElements = [createProfileLabel, stackView, profileImageView, createProfileButton]
        loginVCElements.forEach { [weak self](element) in
            if let self = self {
                element.translatesAutoresizingMaskIntoConstraints = false
                self.scrollView.addSubview(element)
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
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            createProfileLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 56),
            createProfileLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profileImageView.topAnchor.constraint(equalTo: createProfileLabel.bottomAnchor, constant: 6),
            profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 1),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 27),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -27),
            createProfileButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 48),
            createProfileButton.heightAnchor.constraint(equalToConstant: 48),
            createProfileButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            createProfileButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            createProfileButton.bottomAnchor.constraint(greaterThanOrEqualTo: scrollView.bottomAnchor, constant: -77)
        ])
    }
}

// MARK: - UIImagePickerControllerDelegate
extension SetupProfileViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
     func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
        profileImageView.circleImageView.image = image
    }
}

//MARK: - Moving content when keyboard appears

extension SetupProfileViewController: ScrollWhenKeyboardAppears, KeyboardAdjusting {

    @objc func adjustForKeyboard(notification: Notification) {
        setScrollSizeWhenKeyboardAppears(notification: notification)
    }
    
}
