//
//  CategoryViewController.swift
//  BlackStarShop
//
//  Created by Maxim Alekseev on 21.04.2020.
//  Copyright © 2020 Maxim Alekseev. All rights reserved.
//

import UIKit
import SDWebImage
import SwiftUI

class CategoryViewController: UIViewController {
    
    private var shopingCategoriesResponse: ShopingCategoriesResponse?
    
    private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private let activiityIndicator: UIActivityIndicatorView = {
        let activiityIndicator = UIActivityIndicatorView()
        activiityIndicator.hidesWhenStopped = true
        activiityIndicator.style = .medium
        return activiityIndicator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activiityIndicator.startAnimating()
        setUpTableView()
        setupConstraints()
        loadCategories()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUpNavigationBar()
        setTabBarCartIconBadge()
    }
    
}

//MARK: - Setup Tab bar CartIconBadge

extension CategoryViewController {
    private func setTabBarCartIconBadge() {
        let cartCount = RealmDataService.shared.loadObjects().count
        
        if let tabItems = tabBarController?.tabBar.items {
            if cartCount > 0 {
                let tabItem = tabItems[2]
                tabItem.badgeValue = String(cartCount)
            } else {
                let tabItem = tabItems[2]
                tabItem.badgeValue = nil
            }
        }
    }
}

//MARK: - Setup Navigation Controller
extension CategoryViewController {
    private func setUpNavigationBar() {
        self.navigationItem.title = "Категории"
        self.navigationController?.navigationBar.shadowImage = nil
        self.navigationController?.navigationBar.layer.shadowColor = UIColor.clear.cgColor
    }
}

//MARK: - Load data (Categories)

extension CategoryViewController {
    private func loadCategories () {
        NetworkDataFetcher.shared.fetchCategories { [weak self] shopingCategoriesResponse in
            self?.shopingCategoriesResponse = shopingCategoriesResponse
            self?.tableView.reloadData()
            self?.activiityIndicator.stopAnimating()
        }
    }
}


//MARK: - Table View set up

extension CategoryViewController {
    private func setUpTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        self.tableView.register(CategoryCellTableViewCell.self, forCellReuseIdentifier: CategoryCellTableViewCell.reuseId)
    }
}

//MARK: - Navigate to subcategories VC

extension CategoryViewController {
    private func goTosubCategoriesVC (with shoppingSubCategoriesData: [ShoppingSubCategoties], and title: String) {
        let subCatVC = SubcategoryViewController(shoppingSubCategoriesData: shoppingSubCategoriesData, subCatViewControllerTitle: title)
        self.navigationController?.pushViewController(subCatVC, animated: true)
    }
}

//MARK:- UITableViewDelegate, UITableViewDataSouce

extension CategoryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let shopingCategories = shopingCategoriesResponse?.shopingCategories else { return 0 }
        return shopingCategories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CategoryCellTableViewCell.reuseId) as! CategoryCellTableViewCell
        if let shopingCategories = shopingCategoriesResponse?.shopingCategories,
            let shopingCategory = shopingCategories[indexPath.row],
            let stringImageUrl = shopingCategory.image {
            if stringImageUrl != "" {
                let imageURL = URL (string: APIref.urlString + stringImageUrl)
                cell.catImage.sd_setImage(with: imageURL)
            } else {
                cell.catImage.image = UIImage(named: "defaultcatimage")
            }
            cell.catNameLabel.text = shopingCategory.name
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let shopingCategoriesResponse = shopingCategoriesResponse,
            let collection = shopingCategoriesResponse.shopingCategories[indexPath.row],
            let nameCollection = collection.name,
            nameCollection == "Коллекции" {
            let subVCTitle = nameCollection
            goTosubCategoriesVC(with: shopingCategoriesResponse.collectionSorted(), and: subVCTitle)
        } else {
            guard let shoppingSubCategoriesData = shopingCategoriesResponse?.shopingCategories[indexPath.row]?.categoryFiltered(),
                let subVCTitle = shopingCategoriesResponse?.shopingCategories[indexPath.row]?.name else { return }
            goTosubCategoriesVC(with: shoppingSubCategoriesData, and: subVCTitle)
        }
    }
}


//MARK: - Setup Constraints

extension CategoryViewController {
    
    private func setupConstraints() {
        self.view.addSubview(tableView)
        self.view.addSubview(activiityIndicator)
        activiityIndicator.center = self.view.center
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
}


//MARK: - For Canvas prewiew (SwiftUI)

struct CategoryVCProvider: PreviewProvider {
    
    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        
        let viewController = CategoryViewController()
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<CategoryVCProvider.ContainerView>) -> CategoryViewController {
            return viewController
        }
        
        func updateUIViewController(_ uiViewController: CategoryVCProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<CategoryVCProvider.ContainerView>) {
            
        }
    }
    
}
