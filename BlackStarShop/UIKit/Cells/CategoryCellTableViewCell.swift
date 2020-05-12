//
//  CategoryCellTableViewCell.swift
//  BlackStarShop
//
//  Created by Maxim Alekseev on 21.04.2020.
//  Copyright © 2020 Maxim Alekseev. All rights reserved.
//

import UIKit

class CategoryCellTableViewCell: UITableViewCell {
    
    static let reuseId = "CategoryCell"
    var catImage: UIImageView = {
        let catImage = UIImageView()
        catImage.contentMode = .scaleAspectFit
        catImage.translatesAutoresizingMaskIntoConstraints = false
        catImage.layer.borderColor = UIColor.customGrey().cgColor
        catImage.layer.borderWidth = 1
        return catImage
    }()
    
    var catNameLabel: UILabel = {
        let catNameLabel = UILabel()
        catNameLabel.translatesAutoresizingMaskIntoConstraints = false
        catNameLabel.text = ""
        catNameLabel.font = .sfProDisplay16()
        return catNameLabel
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupConstraints()
      
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    override func layoutSubviews() {
        super.layoutSubviews()
        self.catImage.layer.cornerRadius = catImage.frame.height / 2
        self.catImage.clipsToBounds = true
    }
}

//MARK:- Setup constraints

extension CategoryCellTableViewCell {
    private func setupConstraints() {
        addSubview(catImage)
        addSubview(catNameLabel)
        NSLayoutConstraint.activate([
            catImage.heightAnchor.constraint(equalToConstant: 56),
            catImage.widthAnchor.constraint(equalToConstant: 56),
            catImage.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            catImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            catNameLabel.leadingAnchor.constraint(equalTo: catImage.trailingAnchor, constant: 16),
            catNameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
}
