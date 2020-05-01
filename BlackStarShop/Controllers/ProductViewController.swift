//
//  ProductViewController.swift
//  BlackStarShop
//
//  Created by Maxim Alekseev on 01.05.2020.
//  Copyright © 2020 Maxim Alekseev. All rights reserved.
//

import UIKit
import SwiftUI

class ProductViewController: UIViewController {
    
    let scrollView: UIScrollView = {
         let scrollView = UIScrollView()
          scrollView.translatesAutoresizingMaskIntoConstraints = false
          return scrollView
      }()
      
      
      let pageControl: UIPageControl = {
         let pageControl = UIPageControl()
          pageControl.translatesAutoresizingMaskIntoConstraints = false
          pageControl.pageIndicatorTintColor = .lightGray
          pageControl.currentPageIndicatorTintColor = .white
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
        titleLabel.text = "Aspen Gold"
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
       let costValeLabel = UILabel()
        costValeLabel.text = "2500 ₽"
        costValeLabel.font = .helveticaBold16
        costValeLabel.textColor = .customGrey()
        costValeLabel.textAlignment = .right
        return costValeLabel
    }()
    
    let addToCartButton = UIButton(title: "добавить в корзину".uppercased(),
    backgroundColor: #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1), titleColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0),
    font: .sfProDisplay15, cornerRadius: 10)
    
    var aboutProductLabel: UILabel = {
        let aboutProductLabel = UILabel()
        aboutProductLabel.font = .roboto16
        aboutProductLabel.textAlignment = .left
        aboutProductLabel.numberOfLines = 0
        aboutProductLabel.text = "Женский лонгслив ASPEN GOLD представлен в коллекции молодежного бренда Black Star Wear. Модель белого цвета из натурального хлопка удачно впишется в базовый гардероб городской жительницы."
        aboutProductLabel.translatesAutoresizingMaskIntoConstraints = false
        return aboutProductLabel
    }()
    
      private var images = ["0", "1", "2" ]
      private var frame = CGRect(x: 0, y: 0, width: 0, height: 0)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupConstraints()
        pageControlSetup()
        setupScrollView()
        setupNavigationBar()
        addToCartButton.addTarget(self, action: #selector(addToCartButtonPressed), for: .touchUpInside)

    }

    private func pageControlSetup() {
        pageControl.numberOfPages = images.count
        scrollView.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height/2)
        for index in 0..<images.count {
            frame.origin.x = scrollView.frame.size.width * CGFloat(index)
            frame.size = scrollView.frame.size
            let imageView = UIImageView(frame: frame)
            imageView.image = UIImage(named: images[index])
            imageView.contentMode = .scaleAspectFill
            scrollView.addSubview(imageView)
        }
    }
    
    private func setupScrollView() {
        scrollView.contentSize = CGSize (width: scrollView.frame.size.width * CGFloat(images.count), height: scrollView.frame.size.height)
        scrollView.delegate = self
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.contentSize.height = 1.0
    }
    
    private func setupNavigationBar() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        let leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "BackButton"), style: .plain, target: nil, action: nil)
        let rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "cart"), style: .plain, target: nil, action: nil)
        rightBarButtonItem.tintColor = .white
        leftBarButtonItem.tintColor = .white
        navigationItem.rightBarButtonItem = rightBarButtonItem
        navigationItem.leftBarButtonItem = leftBarButtonItem
    }

    @objc func addToCartButtonPressed() {
        navigationItem.rightBarButtonItem?.setBadge(text: "24")
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
        let topPadding = window?.safeAreaInsets.top
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: -44 - (topPadding ?? 0)),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.heightAnchor.constraint(equalToConstant: view.frame.height/2),
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pageControl.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -4),
            titleView.topAnchor.constraint(equalTo: scrollView.bottomAnchor),
            titleView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            titleView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            titleView.heightAnchor.constraint(equalToConstant: 48),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: titleView.topAnchor, constant: 1),
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

struct ProductVCProvider: PreviewProvider {
    
    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        
        let navVC = UINavigationController(rootViewController: ProductViewController())
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<ProductVCProvider.ContainerView>) -> UINavigationController {
            return navVC
        }
        
        func updateUIViewController(_ uiViewController: ProductVCProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<ProductVCProvider.ContainerView>) {
            
        }
    }
    
}
