//
//  CartViewController.swift
//  BlackStarShop
//
//  Created by Maxim Alekseev on 27.04.2020.
//  Copyright © 2020 Maxim Alekseev. All rights reserved.
//

import UIKit
import SwiftUI

class CartViewController: UIViewController {
    
    private let cartProducts: [Product] = [Product(productName: "Mafia BS",
                                                   productDescription: "Description",
                                                   price: "5900",
                                                   productSize: "XL",
                                                   productColor: "Вlack",
                                                   productImage: "mafiaBS")]
    
    private let totalAmountView: UIView = {
        let totalAmountView = UIView()
        totalAmountView.translatesAutoresizingMaskIntoConstraints = false
        return totalAmountView
    }()
    
    private let totalAmountLabel: UILabel = {
        let totalLabel = UILabel()
        totalLabel.text = "Итого:"
        totalLabel.textColor = .black
        totalLabel.font = .sfProDisplay16()
        totalLabel.translatesAutoresizingMaskIntoConstraints = false
        return totalLabel
    }()
    
    private var summLabel: UILabel = {
        let summLabel = UILabel()
        summLabel.text = "0 руб."
        summLabel.font = .sfProDisplay16()
        summLabel.textColor = .customGrey()
        summLabel.translatesAutoresizingMaskIntoConstraints = false
        return summLabel
    }()
    
    private let totalAmountLineView: UIView = {
        let totalAmountLineView = UIView()
        totalAmountLineView.backgroundColor = .customGrey()
        totalAmountLineView.translatesAutoresizingMaskIntoConstraints = false
        return totalAmountLineView
    }()
    
    private let bottomButtonView: UIView = {
        let bottomButtonView = UIView()
        bottomButtonView.translatesAutoresizingMaskIntoConstraints = false
        return bottomButtonView
    }()
    
    private let createOrderButton = UIButton(title: "Оформить заказ",
                                     backgroundColor: #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1), titleColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0),
                                     font: .sfProDisplay15, cornerRadius: 24)
    
    private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    
    private let backgroundForSizeView: UIView = {
        let backgroundForSizeView = UIView()
        backgroundForSizeView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        backgroundForSizeView.layer.opacity = 0
        return backgroundForSizeView
    }()
    
    private let delView = DelView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUpTableView()
        setupConstraints()
        setNavigationBarItems()
        
    }
    
    private func setUpTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        self.tableView.register(CartCell.self, forCellReuseIdentifier: CartCell.reuseId)
    }
    
    private func setNavigationBarItems() {
        navigationItem.title = "Корзина"
        let leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "Close"), style: .done, target: self, action: #selector(delAll))
        leftBarButtonItem.tintColor = .customGrey()
        navigationItem.leftBarButtonItem = leftBarButtonItem
    }
    
    func callDeleteAlert() {
        self.view.addSubview(backgroundForSizeView)
        self.view.addSubview(delView)
        delView.layer.opacity = 1
        backgroundForSizeView.frame.size = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        delView.frame.size = CGSize(width: UIScreen.main.bounds.width - 32, height: 240)
        delView.frame.origin = CGPoint(x: 16, y: UIScreen.main.bounds.height)
        delView.layer.cornerRadius = delView.frame.width / 16
        delView.backgroundColor = .white
        UIView.animate(withDuration: 0.3, animations: {
            self.delView.frame.origin = CGPoint(x: 16, y: UIScreen.main.bounds.height / 4)
            self.backgroundForSizeView.layer.opacity = 1
        }, completion: {
            complete in
            self.delView.frame.origin = CGPoint(x: 16, y: UIScreen.main.bounds.height / 4)
            self.backgroundForSizeView.layer.opacity = 1
        })
    }
    
    @objc private func delAll() {
        callDeleteAlert()
    }
    
}


//MARK: - TableViewDelegate, TableViewDataSource

extension CartViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cartProducts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CartCell.reuseId) as! CartCell
        cell.itemImage.image = UIImage(named: cartProducts[indexPath.row].productImage)
        cell.itemLabel.text = cartProducts[indexPath.row].productName
        cell.colorLabel.text = "Цвет: " + cartProducts[indexPath.row].productColor
        cell.sizeLabel.text = "Размер: " + cartProducts[indexPath.row].productSize
        cell.priceLabel.text = cartProducts[indexPath.row].price + " руб."
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 96
    }
}

//MARK: - Setup constraints

extension CartViewController {
    
    private func setupConstraints() {
        createOrderButton.translatesAutoresizingMaskIntoConstraints = false
        totalAmountView.addSubview(totalAmountLabel)
        totalAmountView.addSubview(summLabel)
        totalAmountView.addSubview(totalAmountLineView)
        bottomButtonView.addSubview(createOrderButton)
        self.view.addSubview(tableView)
        self.view.addSubview(totalAmountView)
        self.view.addSubview(bottomButtonView)
        
        
        let heightBottomPadding = self.tabBarController!.tabBar.frame.height
        
        
        //        bottomView
        
        NSLayoutConstraint.activate([
            bottomButtonView.heightAnchor.constraint(equalToConstant: 100),
            bottomButtonView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomButtonView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomButtonView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -heightBottomPadding),
            createOrderButton.leadingAnchor.constraint(equalTo: bottomButtonView.leadingAnchor, constant: 16),
            createOrderButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            createOrderButton.heightAnchor.constraint(equalToConstant: 48),
            createOrderButton.centerYAnchor.constraint(equalTo: bottomButtonView.centerYAnchor)
        ])
        
        //      totalAmountView
        
        NSLayoutConstraint.activate([
            totalAmountView.heightAnchor.constraint(equalToConstant: 64),
            totalAmountView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            totalAmountView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            totalAmountView.bottomAnchor.constraint(equalTo: bottomButtonView.topAnchor),
            totalAmountLabel.leadingAnchor.constraint(equalTo: totalAmountView.leadingAnchor, constant: 16),
            totalAmountLabel.centerYAnchor.constraint(equalTo: totalAmountView.centerYAnchor),
            summLabel.trailingAnchor.constraint(equalTo: totalAmountView.trailingAnchor, constant: -16),
            summLabel.centerYAnchor.constraint(equalTo: totalAmountView.centerYAnchor),
            totalAmountLineView.heightAnchor.constraint(equalToConstant: 1),
            totalAmountLineView.leadingAnchor.constraint(equalTo: totalAmountView.leadingAnchor, constant: 8),
            totalAmountLineView.trailingAnchor.constraint(equalTo: totalAmountView.trailingAnchor, constant: -8),
            totalAmountLineView.bottomAnchor.constraint(equalTo: totalAmountView.bottomAnchor)
        ])
        
        //        tableView
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: totalAmountView.topAnchor)
        ])
    }
}

//MARK: - For Canvas prewiew (SwiftUI)

struct CartVCProvider: PreviewProvider {
    
    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        
        let tabBarVC = MainTabBarController()
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<CartVCProvider.ContainerView>) -> MainTabBarController {
            return tabBarVC
        }
        
        func updateUIViewController(_ uiViewController: CartVCProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<CartVCProvider.ContainerView>) {
            
        }
    }
    
}
