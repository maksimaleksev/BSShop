//
//  CategoryViewController.swift
//  BlackStarShop
//
//  Created by Maxim Alekseev on 21.04.2020.
//  Copyright © 2020 Maxim Alekseev. All rights reserved.
//

import UIKit
import SwiftUI

class CategoryViewController: UIViewController {
    
    private var categories: [Category] = [Category(catName: "Мужчинам", catImage: "men"),
                                          Category(catName: "Женщинам", catImage: "women"),
                                          Category(catName: "Детям", catImage: "kids"),
                                          Category(catName: "Аксесуары", catImage: "accessories")]
    var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Категории"
        setUpTableView()
        setupConstraints()
    }
    
    func setUpTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        self.tableView.register(CategoryCellTableViewCell.self, forCellReuseIdentifier: CategoryCellTableViewCell.reuseId)
    }
    
}

//MARK:- UITableViewDelegate, UITableViewDataSouce

extension CategoryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CategoryCellTableViewCell.reuseId) as! CategoryCellTableViewCell
        cell.catImage.image = UIImage(named: categories[indexPath.row].catImage)
        cell.catNameLabel.text = categories[indexPath.row].catName
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}

//MARK: - Setup Constraints

extension CategoryViewController {
    
    private func setupConstraints() {
        self.view.addSubview(tableView)
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
