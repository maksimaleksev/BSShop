//
//  ProductCollectionViewCell.swift
//  BlackStarShop
//
//  Created by Maxim Alekseev on 24.04.2020.
//  Copyright © 2020 Maxim Alekseev. All rights reserved.
//

import UIKit
import SDWebImage

class ProductCollectionViewCell: UICollectionViewCell {
    
    static let reuseId = "ProductCell"
    
    private var shoppingProduct: ShoppingProductsResponse!
    weak var delegate: ProductCollectionViewCellDelegate?
    
    var productNameLabel = UILabel(text: "Product", font: UIFont.sfProDisplay16())
    var productDescriptionLabel: UILabel = UILabel(text: "Description", font: UIFont.sfProDisplay11(), textColor: .customGrey())
    var productImageView: UIImageView = {
        let productImageView = UIImageView()
        productImageView.contentMode = .scaleAspectFit
        return productImageView
    }()
    var priceLabel = UILabel(text: "", font: UIFont.sfProDisplay16())
    let buyButton: UIButton = {
        let buyButton = UIButton()
        buyButton.setTitle("купить".uppercased(), for: .normal)
        buyButton.setTitleColor(.white, for: .normal)
        buyButton.backgroundColor = .customPink()
        buyButton.titleLabel?.font = UIFont.robotoBold8()
        return buyButton
    }()
    
    let bottomView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupConstraints()
        self.buyButton.addTarget(self, action: #selector(buyButtonTapped), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        buyButton.layer.cornerRadius = 5
        buyButton.clipsToBounds = true
    }
        
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
         guard isUserInteractionEnabled else { return nil }

           guard !isHidden else { return nil }

           guard alpha >= 0.01 else { return nil }

           guard self.point(inside: point, with: event) else { return nil }


           if self.buyButton.point(inside: convert(point, to: buyButton), with: event) {
               return self.buyButton
           }

           return super.hitTest(point, with: event)
    }
    
    @objc func buyButtonTapped() {
        delegate?.didTapBuyButton(shoppingProduct: shoppingProduct)
    }
}

//MARK:- set shopping product values

extension ProductCollectionViewCell {
    func setProductCellValues (shoppingProductResponse: ShoppingProductsResponse){
        shoppingProduct = shoppingProductResponse
        productNameLabel.text = shoppingProductResponse.name
        productDescriptionLabel.text = shoppingProductResponse.englishName
        priceLabel.text = shoppingProductResponse.priceUnwarped! + "₽"
        if let imageString = shoppingProductResponse.mainImage {
            let imageURLString = APIref.urlString + imageString
            productImageView.sd_setImage(with: URL(string: imageURLString))
        }
    }
}


// MARK: - Setup Constraints

extension ProductCollectionViewCell {
    
   private func setupConstraints() {
        setupBottomViewConstraints()
        let productCVCItems = [productNameLabel, productDescriptionLabel, productImageView, bottomView]
        productCVCItems.forEach { (item) in
            addSubview(item)
            item.translatesAutoresizingMaskIntoConstraints = false
        }
        
        let upperStackView = UIStackView(arrangedSubviews: [productNameLabel, productDescriptionLabel], axis: .vertical, spacing: 2)
        upperStackView.alignment = .leading
        addSubview(upperStackView)
        upperStackView.translatesAutoresizingMaskIntoConstraints = false
        
        // upperStackView constraint
        
        NSLayoutConstraint.activate([
            upperStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 6),
            upperStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 6),
            upperStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
        ])
        
        // productImageView constraint
        NSLayoutConstraint.activate([
            productImageView.heightAnchor.constraint(equalToConstant: 168),
            productImageView.widthAnchor.constraint(equalToConstant: 168),
            productImageView.topAnchor.constraint(equalTo: upperStackView.bottomAnchor, constant: 8),
            productImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 6)
        ])
        
        //bottomView constraints
        
        NSLayoutConstraint.activate([
            bottomView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -4),
            bottomView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 6),
            bottomView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8)
        ])
    }
    
    // Bottom view setup constraints
    
    func setupBottomViewConstraints() {
        bottomView.addSubview(priceLabel)
        bottomView.addSubview(buyButton)
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        buyButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            buyButton.heightAnchor.constraint(equalToConstant: 25),
            buyButton.widthAnchor.constraint(equalToConstant: 70),
            buyButton.centerYAnchor.constraint(equalTo: bottomView.centerYAnchor),
            buyButton.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor),
            priceLabel.centerYAnchor.constraint(equalTo: bottomView.centerYAnchor),
            priceLabel.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor),
            priceLabel.trailingAnchor.constraint(equalTo: buyButton.leadingAnchor, constant: -1)
            
        ])
    }
}
