//
//  ViewController.swift
//  BlackStarShop
//
//  Created by Maxim Alekseev on 15.04.2020.
//  Copyright © 2020 Maxim Alekseev. All rights reserved.
//

import UIKit
import SwiftUI

class AuthViewController: UIViewController {
    
    let logoLabel = UILabel(text: "Black Star Wear", font: .akzidenzGroteskPro40)
    let loginButton = UIButton(title: "Войти в магазин",
                               backgroundColor: #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1),
                               titleColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0),
                               font: .sfProDisplay15,
                               cornerRadius: 24)
    let orLabel = UILabel(text: "или", font: .sfProDisplay15, textColor: #colorLiteral(red: 0.4470588235, green: 0.4470588235, blue: 0.4470588235, alpha: 1))
    let signUpButton = UIButton(title: "Зарегистрироваться",
                                backgroundColor: #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1), titleColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0),
                                font: .sfProDisplay15, cornerRadius: 24)
    
    private let signUpVC = SignUpViewController()
    private let loginVC = LoginViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupConstraints()
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        signUpButton.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
    }
    
    @objc func loginButtonTapped() {
        present(loginVC, animated: true, completion: nil)
    }
    
    @objc func signUpButtonTapped() {
        present(signUpVC, animated: true, completion: nil)
    }
}


//MARK: - Setup Constraints

extension AuthViewController {
    
    private func setupConstraints() {
        
        let authVCElements = [logoLabel, loginButton, orLabel, signUpButton]
            authVCElements.forEach { [weak self] (element) in
            if let self = self {
                element.translatesAutoresizingMaskIntoConstraints = false
                self.view.addSubview(element)
            }
        }
        
        let stackView = UIStackView (arrangedSubviews: [loginButton, orLabel, signUpButton])
        stackView.axis = .vertical
        stackView.spacing = 24
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            logoLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height/4),
            logoLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.heightAnchor.constraint(equalToConstant: 48),
            loginButton.widthAnchor.constraint(equalToConstant: 345),
            signUpButton.heightAnchor.constraint(equalToConstant: 48),
            signUpButton.widthAnchor.constraint(equalToConstant: 345),
            stackView.topAnchor.constraint(equalTo: logoLabel.bottomAnchor, constant: 64),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15)
        ])
    }
}


//MARK: - For Canvas prewiew (SwiftUI)

struct AuthVCProvider: PreviewProvider {
    
    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        
        let viewController = AuthViewController()
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<AuthVCProvider.ContainerView>) -> AuthViewController {
            return viewController
        }
        
        func updateUIViewController(_ uiViewController: AuthVCProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<AuthVCProvider.ContainerView>) {
            
        }
    }
    
}
