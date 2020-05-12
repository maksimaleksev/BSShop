//
//  SubcategoryViewController.swift
//  BlackStarShop
//
//  Created by Maxim Alekseev on 23.04.2020.
//  Copyright © 2020 Maxim Alekseev. All rights reserved.
//

import UIKit
import SDWebImage
import SwiftUI

class SubcategoryViewController: UIViewController {
    
    private var shoppingSubCategoriesData: [ShoppingSubCategoties]
    private var subCatViewControllerTitle: String
    
    init(shoppingSubCategoriesData: [ShoppingSubCategoties], subCatViewControllerTitle: String) {
        self.shoppingSubCategoriesData = shoppingSubCategoriesData
        self.subCatViewControllerTitle = subCatViewControllerTitle
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = subCatViewControllerTitle
        setUpTableView()
        setupConstraints()
    }
    
}

//MARK: - Setup Table View

extension SubcategoryViewController {
    private func setUpTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        self.tableView.register(CategoryCellTableViewCell.self, forCellReuseIdentifier: CategoryCellTableViewCell.reuseId)
    }

}

//MARK:- UITableViewDelegate, UITableViewDataSouce

extension SubcategoryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingSubCategoriesData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CategoryCellTableViewCell.reuseId) as! CategoryCellTableViewCell
        if let iconImage = shoppingSubCategoriesData[indexPath.row].iconImage {
            let imgUrlString = APIref.urlString + iconImage
            cell.catImage.sd_setImage(with: URL(string: imgUrlString))
        }
        cell.catNameLabel.text = shoppingSubCategoriesData[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}

//MARK: - Setup Constraints

extension SubcategoryViewController {
    
    private func setupConstraints() {
        self.view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}

