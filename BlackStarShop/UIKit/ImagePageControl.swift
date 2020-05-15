//
//  ImagePageControl.swift
//  BlackStarShop
//
//  Created by Maxim Alekseev on 15.05.2020.
//  Copyright © 2020 Maxim Alekseev. All rights reserved.
//

import UIKit

class ImagePageControl: UIPageControl {
    
    override var numberOfPages: Int {
        didSet {
            updateDots()
        }
    }
    
    override var currentPage: Int {
        didSet {
            updateDots()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let noneColor = UIColor.white.withAlphaComponent(0)
        pageIndicatorTintColor = noneColor
        currentPageIndicatorTintColor = noneColor
        clipsToBounds = false
    }
    
    private func updateDots() {
        for (index, subview) in subviews.enumerated() {
            let color = UIColor.white.withAlphaComponent(0.7).cgColor
            subview.layer.borderColor = color
            if currentPage == index {
                subview.layer.borderWidth = 0
            }else{
                subview.layer.borderWidth = 1
            }
        }
    }
}
