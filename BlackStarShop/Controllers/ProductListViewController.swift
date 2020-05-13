//
//  ProductListViewController.swift
//  BlackStarShop
//
//  Created by Maxim Alekseev on 24.04.2020.
//  Copyright © 2020 Maxim Alekseev. All rights reserved.
//

import UIKit
import SwiftUI

class ProductListViewController: UIViewController {
    
    private var productList: [Product] = [Product(productName: "Mafia BS",
                                                  productDescription: "Description",
                                                  price: "5900 ₽",
                                                  productSize: "XL",
                                                  productColor: "black",
                                                  productImage: "mafiaBS"),
                                          Product(productName: "Aspen Gold", productDescription: "Description",
                                                  price: "2500 ₽",
                                                  productSize: "",
                                                  productColor: "",
                                                  productImage: "aspenGold"),
                                          Product(productName: "Gothic Wings", productDescription: "Descripiotn",
                                                  price: "3500 ₽",
                                                  productSize: "", productColor: "", productImage: "gothicWings"),
                                          Product(productName: "BlackStar Collection",
                                                  productDescription: "Description",
                                                  price: "3500 ₽",
                                                  productSize: "", productColor: "", productImage: "blackStarCollection")
    ]
    
    private var shoppingProductsId: String
    private var titleProductList: String
    
    init(shoppingProductsId: String, titleProductList: String) {
        self.shoppingProductsId = shoppingProductsId
        self.titleProductList = titleProductList
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        layout.scrollDirection = .vertical
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.navigationItem.title = titleProductList
        setupCollectionView()
        setupConstraints()
        loadProductList()
    }
    
}

// MARK: - Load data for Product List VC

extension ProductListViewController {
    func loadProductList () {
        NetworkDataFetcher.shared.fetchShoppingProducts(from: shoppingProductsId) { (productListResponse) in
            print(productListResponse)
        }
    }
}


//MARK:- Setup Collection View
 
extension ProductListViewController {
    private func setupCollectionView() {
        self.view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ProductCollectionViewCell.self, forCellWithReuseIdentifier: ProductCollectionViewCell.reuseId)
        collectionView.backgroundColor = .clear
    }
    
}

//MARK: - Collection View Delegate and DataSource
extension ProductListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        productList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCollectionViewCell.reuseId, for: indexPath) as! ProductCollectionViewCell
        cell.productNameLabel.text = productList[indexPath.row].productName
        cell.productDescriptionLabel.text = productList[indexPath.row].productDescription
        cell.priceLabel.text = productList[indexPath.row].price
        cell.productImageView.image = UIImage(named: productList[indexPath.row].productImage)
        return cell
    }
    
}

//MARK: - Collection View Flow Layout

extension ProductListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = view.frame.width/2 - 6
        let height: CGFloat = 248
        return CGSize(width: width, height: height)
    }
}

// MARK: - Setup constraints

extension ProductListViewController {
    
    private func setupConstraints() {
        collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}

