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
    
    let logoLabel = UILabel(text: "Black Star Wear", font: .akzidenzGroteskPro40)
    let emailLabel = UILabel(text: "E-mail:", font: .sfProDisplay15, textColor: #colorLiteral(red: 0.4470588235, green: 0.4470588235, blue: 0.4470588235, alpha: 1))
    let emailTextField = FormTextField(font: .sfProDisplay15)
    let passwordLabel = UILabel(text: "Пароль:", font: .sfProDisplay15, textColor: #colorLiteral(red: 0.4470588235, green: 0.4470588235, blue: 0.4470588235, alpha: 1))
    let passwordTextField: FormTextField = {
        let passwordTextfield = FormTextField(font: .sfProDisplay15)
        passwordTextfield.isSecureTextEntry = true
        return passwordTextfield
    }()
    let loginButton = UIButton(title: "Войти",
                               backgroundColor: #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1), titleColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0),
                               font: .sfProDisplay15, cornerRadius: 24)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupConstraints()
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
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
    func setupConstraints() {
        
        let stackView = UIStackView(arrangedSubviews: [emailLabel, emailTextField, passwordLabel, passwordTextField], axis: .vertical, spacing: 18)
        let loginVCElements = [logoLabel, stackView, loginButton]
        loginVCElements.forEach { [weak self](element) in
            if let self = self {
                element.translatesAutoresizingMaskIntoConstraints = false
                self.view.addSubview(element)
            }
        }
        
        emailTextField.heightAnchor.constraint(equalToConstant: 48).isActive = true
        passwordTextField.heightAnchor.constraint(equalToConstant: 48).isActive = true
        NSLayoutConstraint.activate([
            logoLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 128),
            logoLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.topAnchor.constraint(equalTo: logoLabel.bottomAnchor, constant: 24),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 27),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -27),
            loginButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 72),
            loginButton.heightAnchor.constraint(equalToConstant: 48),
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15)
        ])
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
