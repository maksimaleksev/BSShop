//
//  ChangeProfileViewController.swift
//  BlackStarShop
//
//  Created by Maxim Alekseev on 10.05.2020.
//  Copyright © 2020 Maxim Alekseev. All rights reserved.
//

import UIKit
import SDWebImage

class ChangeProfileViewController: UIViewController {
    
    internal let scrollView: UIScrollView = {
       let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    private let changeProfileLabel = UILabel(text: "Отредактируйте профиль", font: .sfProDisplay18, textColor: #colorLiteral(red: 0.4470588235, green: 0.4470588235, blue: 0.4470588235, alpha: 1))
    private let profileImageView = AddPhotoView()
    private let nameLabel = UILabel(text: "Имя:", font: .sfProDisplay15, textColor: #colorLiteral(red: 0.4470588235, green: 0.4470588235, blue: 0.4470588235, alpha: 1))
    private let nameTextField = FormTextField(font: .sfProDisplay15)
    private let secondNameLabel = UILabel(text: "Фамилия:", font: .sfProDisplay15, textColor: #colorLiteral(red: 0.4470588235, green: 0.4470588235, blue: 0.4470588235, alpha: 1))
    private let secondNameTextField = FormTextField(font: .sfProDisplay15)
    private let cityLabel = UILabel(text: "Город:", font: .sfProDisplay15, textColor: #colorLiteral(red: 0.4470588235, green: 0.4470588235, blue: 0.4470588235, alpha: 1))
    private let cityTextField = FormTextField(font: .sfProDisplay15)
    private let addressLabel = UILabel(text: "Адрес:", font: .sfProDisplay15, textColor: #colorLiteral(red: 0.4470588235, green: 0.4470588235, blue: 0.4470588235, alpha: 1))
    private let addressTextField = FormTextField(font: .sfProDisplay15)
    private let changeProfileButton = UIButton(title: "Изменить профиль",
                                       backgroundColor: #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1), titleColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0),
                                       font: .sfProDisplay15, cornerRadius: 24)
    
    private var currentUser: MUser
    
    init(currentUser: MUser) {
        self.currentUser = currentUser
        super.init(nibName: nil, bundle: nil)
        
        self.nameTextField.text = currentUser.name
        self.secondNameTextField.text = currentUser.secondName
        self.cityTextField.text = currentUser.city
        self.addressTextField.text = currentUser.address
        self.profileImageView.circleImageView.sd_setImage(with: URL(string: currentUser.avatarStringURL))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        removeKeyboardNotifications()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        changeProfileLabel.textAlignment = .center
        view.backgroundColor = .white
        setupConstraints()
        changeProfileButton.addTarget(self, action: #selector(changeProfileButtonTapped), for: .touchUpInside)
        profileImageView.plusButton.addTarget(self, action: #selector(plusButtonTapped), for: .touchUpInside)
        registerForKeyboardNotifications()
        self.hideKeyboardWhenTappedAround()
        
    }
    
    @objc private func changeProfileButtonTapped() {
        FirestoreService.shared.saveProfileWith(id: currentUser.id,
                                                email: currentUser.email,
                                                name: nameTextField.text,
                                                avatarImage: profileImageView.circleImageView.image,
                                                secondName: secondNameTextField.text,
                                                city: cityTextField.text,
                                                address: addressTextField.text) { (result) in
                                                    switch result {
                                                    case .success(let mUser):
                                                        self.showAlert(with: "Вы успешно изменили профиль", and: "Приятных вам покупок!", completion: { [weak self] in
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

extension ChangeProfileViewController {
    
    func setupConstraints() {
        view.addSubview(scrollView)
        let stackView = UIStackView(arrangedSubviews: [nameLabel, nameTextField, secondNameLabel, secondNameTextField, cityLabel, cityTextField, addressLabel, addressTextField], axis: .vertical, spacing: 8)
        let loginVCElements = [changeProfileLabel, stackView, profileImageView, changeProfileButton]
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
            changeProfileLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 56),
            changeProfileLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profileImageView.topAnchor.constraint(equalTo: changeProfileLabel.bottomAnchor, constant: 6),
            profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 1),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 27),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -27),
            changeProfileButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 48),
            changeProfileButton.heightAnchor.constraint(equalToConstant: 48),
            changeProfileButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            changeProfileButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            changeProfileButton.bottomAnchor.constraint(greaterThanOrEqualTo: scrollView.bottomAnchor, constant: -77)
        ])
    }
}

// MARK: - UIImagePickerControllerDelegate
extension ChangeProfileViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
        profileImageView.circleImageView.image = image
    }
}

//MARK: - Moving content when keyboard appears

extension ChangeProfileViewController: ScrollWhenKeyboardAppears, KeyboardAdjusting {
    
    @objc func adjustForKeyboard(notification: Notification) {
            setScrollSizeWhenKeyboardAppears(notification: notification)
        }
}
