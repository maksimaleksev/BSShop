//
//  LoginViewController.swift
//  BlackStarShop
//
//  Created by Maxim Alekseev on 17.04.2020.
//  Copyright © 2020 Maxim Alekseev. All rights reserved.
//

import UIKit
import SwiftUI

class LoginViewController: UIViewController {
    
    
    private let scrollView: UIScrollView = {
       let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    private let logoLabel = UILabel(text: "Black Star Wear", font: .akzidenzGroteskPro40)
    private let emailLabel = UILabel(text: "E-mail:", font: .sfProDisplay15, textColor: #colorLiteral(red: 0.4470588235, green: 0.4470588235, blue: 0.4470588235, alpha: 1))
    private let emailTextField: FormTextField = {
        let emailTextField = FormTextField(font: .sfProDisplay15)
        emailTextField.textContentType = .emailAddress
        emailTextField.keyboardType = .emailAddress
        return emailTextField
    }()
    private let passwordLabel = UILabel(text: "Пароль:", font: .sfProDisplay15, textColor: #colorLiteral(red: 0.4470588235, green: 0.4470588235, blue: 0.4470588235, alpha: 1))
    private let passwordTextField: FormTextField = {
        let passwordTextfield = FormTextField(font: .sfProDisplay15)
        passwordTextfield.isSecureTextEntry = true
        passwordTextfield.textContentType = .password
        return passwordTextfield
    }()
    private let loginButton = UIButton(title: "Войти",
                               backgroundColor: #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1), titleColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0),
                               font: .sfProDisplay15, cornerRadius: 24)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupConstraints()
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        registerForKeyboardNotifications()
        self.hideKeyboardWhenTappedAround()
    }
    
    deinit {
        removeKeyboardNotifications()
    }
    
    @objc private func loginButtonTapped() {
        AuthService.shared.login(
            email: emailTextField.text!,
            password: passwordTextField.text!) { (result) in
                switch result {
                case .success(let user):
                    self.showAlert(with: "Успешно!", and: "Вы авторизованы!") {
                        
                        FirestoreService.shared.getUserData(user: user) {[weak self] (result) in
                            switch result {
                            case .success(let mUser):
                                print(mUser)
                                let mainTabBarController = MainTabBarController(currentUser: mUser)
                                mainTabBarController.modalPresentationStyle = .fullScreen
                                self?.present(mainTabBarController, animated: true, completion: nil)
                            case .failure(_):
                                print("error")
                                self?.present(SetupProfileViewController(currentUser: user), animated: true, completion: nil)
                            }
                        }
                        
                    }
                case .failure(let error):
                    self.showAlert(with: "Ошибка!", and: error.localizedDescription)
                }
        }
        
    }
}


//MARK: - Setup constraints

extension LoginViewController {
    private func setupConstraints() {
        view.addSubview(scrollView)
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordLabel.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        let stackView = UIStackView(arrangedSubviews: [emailLabel, emailTextField, passwordLabel, passwordTextField], axis: .vertical, spacing: 18)
        let loginVCElements = [logoLabel, stackView, loginButton]
        loginVCElements.forEach { [weak self](element) in
            if let self = self {
                element.translatesAutoresizingMaskIntoConstraints = false
                self.scrollView.addSubview(element)
            }
        }
        
        NSLayoutConstraint.activate([
            //scrollView
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            //logoLabel
            logoLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 128),
            logoLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            emailTextField.heightAnchor.constraint(equalToConstant: 48),
            passwordTextField.heightAnchor.constraint(equalToConstant: 48),
            //stackView
            stackView.topAnchor.constraint(equalTo: logoLabel.bottomAnchor, constant: 24),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 27),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -27),
            //loginButton
            loginButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 72),
            loginButton.heightAnchor.constraint(equalToConstant: 48),
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            loginButton.bottomAnchor.constraint(greaterThanOrEqualTo: scrollView.bottomAnchor, constant: -154)
            ])
    }
}

//MARK: - Moving content when keyboard appears

extension LoginViewController {
        
    private func registerForKeyboardNotifications() {
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    private func removeKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func adjustForKeyboard(notification: Notification) {
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

//MARK: - For Canvas prewiew (SwiftUI)

struct LoginVCProvider: PreviewProvider {
    
    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        
        let viewController = LoginViewController()
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<LoginVCProvider.ContainerView>) -> LoginViewController {
            return viewController
        }
        
        func updateUIViewController(_ uiViewController: LoginVCProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<LoginVCProvider.ContainerView>) {
            
        }
    }
    
}
