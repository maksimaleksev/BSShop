//
//  SizesCell.swift
//  Transition
//
//  Created by Maxim Alekseev on 06.05.2020.
//  Copyright © 2020 Maxim Alekseev. All rights reserved.
//

import UIKit

class SizesCell: UITableViewCell {
    
    static let reuseId = "SizeCell"

    let sizeLabel: UILabel = {
       let sizeLabel = UILabel()
        sizeLabel.translatesAutoresizingMaskIntoConstraints = false
       return sizeLabel
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}


// MARK: - Setup Costraints

extension SizesCell {
    private func setupConstraints (){
        addSubview(sizeLabel)
        NSLayoutConstraint.activate([
            sizeLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            sizeLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
}
