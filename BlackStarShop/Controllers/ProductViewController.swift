//
//  ProductViewController.swift
//  BlackStarShop
//
//  Created by Maxim Alekseev on 01.05.2020.
//  Copyright © 2020 Maxim Alekseev. All rights reserved.
//

import UIKit
import SDWebImage
import SwiftUI

class ProductViewController: UIViewController {
    
    private var frame = CGRect(x: 0, y: 0, width: 0, height: 0)
    private let sizes = ["XL", "L", "M", "S"]
    
    private var shoppingProduct: ShoppingProductsResponse
    
    init(shoppingProduct: ShoppingProductsResponse) {
        self.shoppingProduct = shoppingProduct
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    
    let pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.pageIndicatorTintColor = .gray
        pageControl.currentPageIndicatorTintColor = .green
        return pageControl
    }()
    
    let titleView: UIView = {
        let titleView = UIView()
        titleView.translatesAutoresizingMaskIntoConstraints = false
        return titleView
    }()
    
    var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = .akzidenzGroteskPro36
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 2
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        return titleLabel
    }()
    
    let lineView: UIView = {
        let totalAmountLineView = UIView()
        totalAmountLineView.backgroundColor = .customGrey()
        totalAmountLineView.translatesAutoresizingMaskIntoConstraints = false
        return totalAmountLineView
    }()
    
    let costLabel = UILabel(text: "Стоимость:", font: .helvetica16)
    var costValueLabel: UILabel = {
        let costValueLabel = UILabel()
        costValueLabel.font = .helveticaBold16
        costValueLabel.textColor = .gray
        costValueLabel.textAlignment = .right
        return costValueLabel
    }()
    
    let addToCartButton = UIButton(title: "добавить в корзину".uppercased(),
                                   backgroundColor: #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1), titleColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0),
                                   font: .sfProDisplay15, cornerRadius: 10)
    
    var aboutProductLabel: UILabel = {
        let aboutProductLabel = UILabel()
        aboutProductLabel.font = .roboto16
        aboutProductLabel.textAlignment = .left
        aboutProductLabel.numberOfLines = 0
        aboutProductLabel.translatesAutoresizingMaskIntoConstraints = false
        return aboutProductLabel
    }()
    
    private let transition = PanelTransition()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupValuesForUIElements()
        setupConstraints()
        pageControlSetup()
        setupScrollView()
        addToCartButton.addTarget(self, action: #selector(addToCartButtonPressed), for: .touchUpInside)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar()
    }
    
    @objc func addToCartButtonPressed() {
        
        let child = SizesViewController(sizes: sizes)
        child.transitioningDelegate = transition
        child.modalPresentationStyle = .custom
        
        present(child, animated: true)
        //        navigationItem.rightBarButtonItem?.setBadge(text: "24")
    }
}

// MARK: - Setup values for UI elements

extension ProductViewController {
    func setupValuesForUIElements () {
        titleLabel.text = shoppingProduct.name
        costValueLabel.text = shoppingProduct.priceUnwarped
        aboutProductLabel.text = shoppingProduct.description
    }
}

//MARK: - Setup navigation bar

extension ProductViewController {
    private func setupNavigationBar() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        let leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "BackButton"), style: .plain, target: self, action: #selector(back(sender:)))
        let rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "cart"), style: .plain, target: nil, action: nil)
        rightBarButtonItem.tintColor = .white
        leftBarButtonItem.tintColor = .white
        navigationItem.rightBarButtonItem = rightBarButtonItem
        navigationItem.leftBarButtonItem = leftBarButtonItem
    }
    
    @objc private func back(sender: UIBarButtonItem) {
        _ = navigationController?.popViewController(animated: true)
    }
}

//MARK: - Setup ScrollView

extension ProductViewController {
    
    private func setupScrollView() {
        let images = shoppingProduct.productImages
        scrollView.contentSize = CGSize (width: scrollView.frame.size.width * CGFloat(images.count), height: scrollView.frame.size.height)
        scrollView.delegate = self
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.contentSize.height = 1.0
    }
    
}

//MARK: - Page Control Setup

extension ProductViewController {
    private func pageControlSetup() {
        let images = shoppingProduct.productImages
        pageControl.numberOfPages = images.count
        scrollView.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: 4 * view.frame.width/3)
        for (index, _) in images.enumerated() {
            frame.origin.x = scrollView.frame.size.width * CGFloat(index)
            frame.size = scrollView.frame.size
            guard let imageString = images[index].imageURL else { return }
            let imageURL = URL(string: APIref.urlString + imageString)
            let imageView = UIImageView(frame: frame)
            imageView.sd_setImage(with: imageURL, completed: nil)
            imageView.contentMode = .scaleAspectFill
            scrollView.addSubview(imageView)
        }
    }
}

// MARK: - Setup Constraints

extension ProductViewController {
    private func setupConstraints() {
        let productVCViews = [scrollView, pageControl, titleView]
        productVCViews.forEach { (productVCView) in
            self.view.addSubview(productVCView)
        }
        
        titleView.addSubview(titleLabel)
        titleView.addSubview(lineView)
        
        let costStackView = UIStackView(arrangedSubviews: [costLabel, costValueLabel], axis: .horizontal, spacing: 1)
        costStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(costStackView)
        
        let bottomStackView = UIStackView(arrangedSubviews: [addToCartButton, aboutProductLabel], axis: .vertical, spacing: 32)
        bottomStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bottomStackView)
        
        let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        let topPadding = window?.safeAreaInsets.top ?? 0
        
        let titleLabelHeight = titleLabel.text?.height(withConstrainedWidth: view.frame.size.width - 8, font: UIFont.akzidenzGroteskPro36!)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: -44 - topPadding),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.heightAnchor.constraint(equalToConstant: 4 * view.frame.width/3),
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pageControl.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -4),
            titleView.topAnchor.constraint(equalTo: scrollView.bottomAnchor),
            titleView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            titleView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            titleView.heightAnchor.constraint(equalToConstant: titleLabelHeight ?? 0 + 2),
            titleLabel.topAnchor.constraint(equalTo: titleView.topAnchor, constant: 1),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.widthAnchor.constraint(equalToConstant: view.frame.size.width - 8),
            lineView.bottomAnchor.constraint(equalTo: titleView.bottomAnchor),
            lineView.leadingAnchor.constraint(equalTo: titleView.leadingAnchor, constant: 24),
            lineView.trailingAnchor.constraint(equalTo: titleView.trailingAnchor, constant: -24),
            lineView.heightAnchor.constraint(equalToConstant: 1),
            costStackView.topAnchor.constraint(equalTo: titleView.bottomAnchor, constant: 8),
            costStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            costStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            bottomStackView.topAnchor.constraint(equalTo: costStackView.bottomAnchor, constant: 16),
            addToCartButton.heightAnchor.constraint(equalToConstant: 48),
            bottomStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            bottomStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24)
        ])
    }
}

//MARK: - ScrolViewDelegate

extension ProductViewController: UIScrollViewDelegate{
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = round(Double(scrollView.contentOffset.x / scrollView.frame.size.width))
        pageControl.currentPage = Int(pageNumber)
    }
}


