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
    
    let totalAmountView: UIView = {
        let totalAmountView = UIView()
        totalAmountView.translatesAutoresizingMaskIntoConstraints = false
        return totalAmountView
    }()
    
    let totalAmountLabel: UILabel = {
       let totalLabel = UILabel()
        totalLabel.text = "Итого:"
        totalLabel.textColor = .black
        totalLabel.font = .sfProDisplay16()
        totalLabel.translatesAutoresizingMaskIntoConstraints = false
        return totalLabel
    }()
    
    var summLabel: UILabel = {
        let summLabel = UILabel()
        summLabel.text = "0 руб."
        summLabel.font = .sfProDisplay16()
        summLabel.textColor = .customGrey()
        summLabel.translatesAutoresizingMaskIntoConstraints = false
        return summLabel
    }()
    
    let totalAmountLineView: UIView = {
        let totalAmountLineView = UIView()
        totalAmountLineView.backgroundColor = .customGrey()
        totalAmountLineView.translatesAutoresizingMaskIntoConstraints = false
        return totalAmountLineView
    }()
    
    let bottomButtonView: UIView = {
        let bottomButtonView = UIView()
        bottomButtonView.translatesAutoresizingMaskIntoConstraints = false
        return bottomButtonView
    }()
    
    let createOrderButton = UIButton(title: "Оформить заказ",
                               backgroundColor: #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1), titleColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0),
                               font: .sfProDisplay15, cornerRadius: 24)

    var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUpTableView()
        setupConstraints()
        setNavigationBarItems()
    
    }
    
    func setUpTableView() {
           tableView.delegate = self
           tableView.dataSource = self
           tableView.tableFooterView = UIView()
           self.tableView.register(CartCell.self, forCellReuseIdentifier: CartCell.reuseId)
       }
    
    func setNavigationBarItems() {
        navigationItem.title = "Корзина"
        let leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "Close"), style: .plain, target: nil, action: nil)
        leftBarButtonItem.tintColor = .customGrey()
        navigationItem.leftBarButtonItem = leftBarButtonItem
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
        
        
//        bottomView
        
        NSLayoutConstraint.activate([
            bottomButtonView.heightAnchor.constraint(equalToConstant: 130),
            bottomButtonView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomButtonView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomButtonView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
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
        
        let viewController = CartViewController()
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<CartVCProvider.ContainerView>) -> CartViewController {
            return viewController
        }
        
        func updateUIViewController(_ uiViewController: CartVCProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<CartVCProvider.ContainerView>) {
            
        }
    }
    
}
