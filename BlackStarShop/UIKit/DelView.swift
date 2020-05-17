//
//  DelView.swift
//  BlackStarShop
//
//  Created by Maxim Alekseev on 07.05.2020.
//  Copyright © 2020 Maxim Alekseev. All rights reserved.
//

import UIKit

class DelView: UIView {
    
    private let delLabel: UILabel = {
        let delLabel = UILabel()
        delLabel.text = "Удалить товар из корзины?"
        delLabel.font = .sfProDisplay18
        return delLabel
    }()
    
    private let yesButton = UIButton(title: "ДА",
                                     backgroundColor: #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1), titleColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0),
                                     font: .sfProDisplay15, cornerRadius: 8)
    
    private let noButton = UIButton(title: "НЕТ",
                                    backgroundColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), titleColor: .black,
                                    font: .sfProDisplay15, cornerRadius: 8)
    
    var completion: ((Bool) -> ())!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViewElements()
        setupConstraints()
        yesButton.addTarget(self, action: #selector(yesButtonTapped), for: .touchUpInside)
        noButton.addTarget(self, action: #selector(noButoonTapped), for: .touchUpInside)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func yesButtonTapped() {
        completion!(true)
    }
    
    @objc private func noButoonTapped() {
        completion!(false)
    }
    
    func setDelLabelText(text: String) {
        delLabel.text = "Удалить \(text) из корзины?"
    }
}

//MARK: - Setup View Elements

extension DelView {
    
    private func setupViewElements() {
        for button in [delLabel, yesButton, noButton] {
            addSubview(button)
            button.translatesAutoresizingMaskIntoConstraints = false
        }
        
        noButton.layer.borderColor = UIColor.customGrey().cgColor
        noButton.layer.borderWidth = 1
    }

}


//MARK: - Setup Constraints
extension DelView {
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            delLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 32),
            delLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            yesButton.topAnchor.constraint(equalTo: delLabel.bottomAnchor, constant: 32),
            yesButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 32),
            yesButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -32),
            yesButton.heightAnchor.constraint(equalToConstant: 48),
            noButton.topAnchor.constraint(equalTo: yesButton.bottomAnchor, constant: 12),
            noButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 32),
            noButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -32),
            noButton.heightAnchor.constraint(equalToConstant: 48)
        ])
    }
}
