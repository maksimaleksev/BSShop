//
//  SubcategoryViewController.swift
//  BlackStarShop
//
//  Created by Maxim Alekseev on 23.04.2020.
//  Copyright © 2020 Maxim Alekseev. All rights reserved.
//

import UIKit
import SwiftUI

class SubcategoryViewController: UIViewController {
    
    private var subCategories: [Category] = [Category(catName: "Спортивные костюмы", catImage: "sportsuits"),
                                             Category(catName: "Толстовки и худи", catImage: "hoodies"),
                                             Category(catName: "Платья", catImage: "dresses"),
                                             Category(catName: "Рубашки", catImage: "shirts")]
    
    var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Женщинам"
        setUpTableView()
        setupConstraints()
    }
    
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
        return subCategories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CategoryCellTableViewCell.reuseId) as! CategoryCellTableViewCell
        cell.catImage.image = UIImage(named: subCategories[indexPath.row].catImage)
        cell.catNameLabel.text = subCategories[indexPath.row].catName
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

//MARK: - For Canvas prewiew (SwiftUI)

struct SubCategoryVCProvider: PreviewProvider {
    
    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        
        let viewController = SubcategoryViewController()
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<SubCategoryVCProvider.ContainerView>) -> SubcategoryViewController {
            return viewController
        }
        
        func updateUIViewController(_ uiViewController: SubCategoryVCProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<SubCategoryVCProvider.ContainerView>) {
            
        }
    }
    
}
