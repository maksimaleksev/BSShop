//
//  SignUpViewController.swift
//  BlackStarShop
//
//  Created by Maxim Alekseev on 18.04.2020.
//  Copyright © 2020 Maxim Alekseev. All rights reserved.
//

import UIKit
import SwiftUI

class SignUpViewController: UIViewController {
    
    internal let scrollView: UIScrollView = {
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
        passwordTextfield.textContentType = .newPassword
        return passwordTextfield
    }()
    private let passwordReplyLabel = UILabel(text: "Повторите пароль:", font: .sfProDisplay15, textColor: #colorLiteral(red: 0.4470588235, green: 0.4470588235, blue: 0.4470588235, alpha: 1))
    private let passwordReplyTextField: FormTextField = {
        let passwordTextfield = FormTextField(font: .sfProDisplay15)
        passwordTextfield.isSecureTextEntry = true
        passwordTextfield.textContentType = .newPassword
        return passwordTextfield
    }()
    
    private let signUpButton = UIButton(title: "Зарегистрироваться",
                                backgroundColor: #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1), titleColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0),
                                font: .sfProDisplay15, cornerRadius: 24)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupConstraints()
        signUpButton.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
        registerForKeyboardNotifications()
        self.hideKeyboardWhenTappedAround()
    }
    
    deinit {
        removeKeyboardNotifications()
    }
    
        
    @objc private func signUpButtonTapped() {
        AuthService.shared.register(email: emailTextField.text, password: passwordTextField.text, confirmPassword: passwordReplyTextField.text) { (result) in
            
            switch result {
                
            case .success(let user):
                self.showAlert(with: "Успешно", and: "Вы зарегистрированы!") {
                    let setupVC = SetupProfileViewController(currentUser: user)
                    setupVC.modalPresentationStyle = .fullScreen
                    self.present(setupVC, animated: true)
                }
                
            case .failure(let error):
                self.showAlert(with: "Ошибка", and: error.localizedDescription)
            }
        }
    }
    
}

extension SignUpViewController {
    func setupConstraints() {
        view.addSubview(scrollView)
        let stackView = UIStackView(arrangedSubviews: [emailLabel, emailTextField, passwordLabel, passwordTextField, passwordReplyLabel, passwordReplyTextField], axis: .vertical, spacing: 18)
        let loginVCElements = [logoLabel, stackView, signUpButton]
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
            passwordReplyTextField.heightAnchor.constraint(equalToConstant: 48),
            
            //stackView
            stackView.topAnchor.constraint(equalTo: logoLabel.bottomAnchor, constant: 24),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 27),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -27),
            //signUpButton
            signUpButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 72),
            signUpButton.heightAnchor.constraint(equalToConstant: 48),
            signUpButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            signUpButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            signUpButton.bottomAnchor.constraint(greaterThanOrEqualTo: scrollView.bottomAnchor, constant: -77)
        ])
    }
}

//MARK: - Moving content when keyboard appears

extension SignUpViewController: ScrollWhenKeyboardAppears, KeyboardAdjusting {
            
    @objc func adjustForKeyboard(notification: Notification) {
        setScrollSizeWhenKeyboardAppears(notification: notification)
    }
    
}

//MARK: - For Canvas prewiew (SwiftUI)

struct SignUpVCProvider: PreviewProvider {
    
    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        
        let viewController = SignUpViewController()
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<SignUpVCProvider.ContainerView>) -> SignUpViewController {
            return viewController
        }
        
        func updateUIViewController(_ uiViewController: SignUpVCProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<SignUpVCProvider.ContainerView>) {
            
        }
    }
    
}
