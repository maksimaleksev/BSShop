//
//  ProductListViewController.swift
//  BlackStarShop
//
//  Created by Maxim Alekseev on 24.04.2020.
//  Copyright © 2020 Maxim Alekseev. All rights reserved.
//

import UIKit
import SDWebImage
import SwiftUI

class ProductListViewController: UIViewController {
    
    private var shoppingProductsList: [ShoppingProductsResponse] = []
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
    
    let activiityIndicator: UIActivityIndicatorView = {
        let activiityIndicator = UIActivityIndicatorView()
        activiityIndicator.hidesWhenStopped = true
        activiityIndicator.style = .medium
        return activiityIndicator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activiityIndicator.startAnimating()
        view.backgroundColor = .white
        setupNavigationBar()
        setupCollectionView()
        setupConstraints()
        loadProductList()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar()
    }
}

//MARK: - Setup navigation bar

extension ProductListViewController {
    private func setupNavigationBar() {
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationItem.title = titleProductList
        self.navigationController?.navigationBar.topItem?.title = ""
    }
}


// MARK: - Load data for Product List VC

extension ProductListViewController {
    func loadProductList () {
        NetworkDataFetcher.shared.fetchShoppingProducts(from: shoppingProductsId) {[weak self] (productListResponse) in
            var shoppingUnsortedList:[ShoppingProductsResponse] = []
            if let productListResponse = productListResponse {
                for ( _, value) in productListResponse {
                    shoppingUnsortedList.append(value)
                }
                
                self?.shoppingProductsList = shoppingUnsortedList.sorted { product1, product2 -> Bool in
                    guard let sortNumber1 = product1.sortOrderInt, let sortNumber2 = product2.sortOrderInt else { return false}
                    return sortNumber1 < sortNumber2
                }
                
                self?.collectionView.reloadData()
                self?.activiityIndicator.stopAnimating()
            }
        }
    }
}


//MARK:- Setup Collection View

extension ProductListViewController {
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ProductCollectionViewCell.self, forCellWithReuseIdentifier: ProductCollectionViewCell.reuseId)
        collectionView.backgroundColor = .clear
    }
    
}


//MARK: - ProductCollectionViewCell Delegate

extension ProductListViewController: ProductCollectionViewCellDelegate {
    func didTapBuyButton(shoppingProduct: ShoppingProductsResponse) {
        let productVC = ProductViewController(shoppingProduct: shoppingProduct)
        self.navigationController?.pushViewController(productVC, animated: true)
    }
    
    
}

//MARK: - Collection View Delegate and DataSource
extension ProductListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        shoppingProductsList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCollectionViewCell.reuseId, for: indexPath) as! ProductCollectionViewCell
        let shoppingProductResponse = shoppingProductsList[indexPath.row]
        cell.setProductCellValues(shoppingProductResponse: shoppingProductResponse)
        cell.delegate = self
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
        self.view.addSubview(activiityIndicator)
        self.view.addSubview(collectionView)
        activiityIndicator.center = self.view.center
        collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}

