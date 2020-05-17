//
//  CartCell.swift
//  BlackStarShop
//
//  Created by Maxim Alekseev on 27.04.2020.
//  Copyright © 2020 Maxim Alekseev. All rights reserved.
//

import UIKit
import SDWebImage

class CartCell: UITableViewCell {

    static let reuseId = "CartCell"
    
    private var cellData: CartModel!
    
    weak var delegate: CartCellDelegate?
    
    private var itemImage: UIImageView = {
        let itemImage = UIImageView()
        itemImage.contentMode = .scaleAspectFit
        return itemImage
    }()
    
    private let trashButton: UIButton = {
        let trashButton = UIButton()
        let image = UIImage(named: "trash")
        trashButton.setImage(image, for: .normal)
        return trashButton
    }()
    
    private var itemLabel = UILabel(text: "", font: .sfProDisplay16())
    private var sizeLabel = UILabel(text: "Размер:", font: .sfProDisplay11(), textColor: .customGrey())
    private var colorLabel = UILabel(text: "Цвет:", font: .sfProDisplay11(), textColor: .customGrey())
    private var priceLabel = UILabel(text: "", font: .sfProDisplay16())
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupConstraints()
        trashButton.addTarget(self, action: #selector(trashButtonTapped), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func trashButtonTapped() {
        
        delegate?.delCellData(data: cellData)
    }
    
}

//MARK: - Set Cell Data

extension CartCell {
    func setCellData(data: CartModel) {
        cellData = data
        if let imageURLString = data.productImage {
            let imageURL = URL(string: APIref.urlString + imageURLString)
            itemImage.sd_setImage(with: imageURL)

        }
        sizeLabel.text = "Размер: " + data.productSize
        colorLabel.text = "Цвет: " + data.productColor
        priceLabel.text = data.price + "₽"
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
