//
//  CartCell.swift
//  BlackStarShop
//
//  Created by Maxim Alekseev on 27.04.2020.
//  Copyright © 2020 Maxim Alekseev. All rights reserved.
//

import UIKit

class CartCell: UITableViewCell {

    static let reuseId = "CartCell"
    
    var itemImage: UIImageView = {
        let itemImage = UIImageView()
        return itemImage
    }()
    
    private let trashButton: UIButton = {
        let trashButton = UIButton()
        let image = UIImage(named: "trash")
        trashButton.setImage(image, for: .normal)
        return trashButton
    }()
    
    var itemLabel = UILabel(text: "", font: .sfProDisplay16())
    var sizeLabel = UILabel(text: "Размер:", font: .sfProDisplay11(), textColor: .customGrey())
    var colorLabel = UILabel(text: "Цвет:", font: .sfProDisplay11(), textColor: .customGrey())
    var priceLabel = UILabel(text: "", font: .sfProDisplay16())
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

//MARK: - Setup constraints

extension CartCell {
    
    
    
    private func setupConstraints() {
        
        let cartCellItems = [itemImage, itemLabel, sizeLabel, colorLabel, priceLabel, trashButton]
        cartCellItems.forEach { [weak self] (item) in
            item.translatesAutoresizingMaskIntoConstraints = false
            guard let self = self else { return }
            self.addSubview(item)
        }
        
        let stackView = UIStackView(arrangedSubviews: [sizeLabel, colorLabel], axis:.vertical, spacing: 1)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            itemImage.heightAnchor.constraint(equalToConstant: 80),
            itemImage.widthAnchor.constraint(equalToConstant: 80),
            itemImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            itemImage.centerYAnchor.constraint(equalTo: centerYAnchor),
            itemLabel.leadingAnchor.constraint(equalTo: itemImage.trailingAnchor, constant: 8),
            itemLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            stackView.topAnchor.constraint(equalTo: itemLabel.bottomAnchor, constant: 2),
            stackView.leadingAnchor.constraint(equalTo: itemImage.trailingAnchor, constant: 8),
            priceLabel.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 14),
            priceLabel.leadingAnchor.constraint(equalTo: itemImage.trailingAnchor, constant: 8),
            trashButton.heightAnchor.constraint(equalToConstant: 24),
            trashButton.widthAnchor.constraint(equalToConstant: 24),
            trashButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            trashButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
    }
}
