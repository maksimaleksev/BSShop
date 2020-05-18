//
//  CartViewController.swift
//  BlackStarShop
//
//  Created by Maxim Alekseev on 27.04.2020.
//  Copyright © 2020 Maxim Alekseev. All rights reserved.
//

import UIKit
import SwiftUI
import RealmSwift

class CartViewController: UIViewController {
    
    private var cartProducts: Results<CartModel>!
    
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
        summLabel.text = "0₽"
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
        cartProducts = RealmDataService.shared.loadObjects()
        view.backgroundColor = .white
        setUpTableView()
        setupConstraints()
        setNavigationBarItems()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        cartProducts = RealmDataService.shared.loadObjects()
        tableView.reloadData()
        setSummLabelData()
    }
        
}

// MARK: - Set Tab Bar CartIconBadge
extension CartViewController {
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

// MARK: - Calculating and set data for summLabel

extension CartViewController {
    private func setSummLabelData() {
        let sum = Array(cartProducts).map { Int($0.price) ?? 0 }.reduce(0, +)
        summLabel.text = String(sum) + "₽"
    }
}


//MARK: - Set Up TableView

extension CartViewController {
    private func setUpTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        self.tableView.register(CartCell.self, forCellReuseIdentifier: CartCell.reuseId)
    }
    
}

//MARK: - Set Navigation Bar Items
extension CartViewController {
    private func setNavigationBarItems() {
        navigationItem.title = "Корзина"
        let leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "Close"), style: .done, target: self, action: #selector(delAll(sender:)))
        leftBarButtonItem.tintColor = .customGrey()
        navigationItem.leftBarButtonItem = leftBarButtonItem
        self.navigationController?.navigationBar.shadowImage = nil
        self.navigationController?.navigationBar.layer.shadowColor = UIColor.clear.cgColor
    }
    
    @objc private func delAll(sender: UIBarButtonItem) {
        callDeleteAlert(with: "все товары")
        delView.completion = { [weak self] result in
            if result {
                RealmDataService.shared.delAllObjects()
                self?.dismissDelAlert()
                self?.tableView.reloadData()
                self?.setSummLabelData()
                self?.setTabBarCartIconBadge()
            } else {
                self?.dismissDelAlert()
            }
        }
    }

}

//MARK: - Call and dismiss delete Alerts

extension CartViewController {
    private func callDeleteAlert(with text: String) {
        self.view.addSubview(backgroundForSizeView)
        self.view.addSubview(delView)
        delView.layer.opacity = 1
        backgroundForSizeView.frame.size = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        delView.frame.size = CGSize(width: UIScreen.main.bounds.width - 32, height: 240)
        delView.frame.origin = CGPoint(x: 16, y: UIScreen.main.bounds.height)
        delView.layer.cornerRadius = delView.frame.width / 16
        delView.backgroundColor = .white
        delView.setDelLabelText(text: text)
        UIView.animate(withDuration: 0.3, animations: {
            self.delView.frame.origin = CGPoint(x: 16, y: UIScreen.main.bounds.height / 4)
            self.backgroundForSizeView.layer.opacity = 1
        }, completion: {
            complete in
            self.delView.frame.origin = CGPoint(x: 16, y: UIScreen.main.bounds.height / 4)
            self.backgroundForSizeView.layer.opacity = 1
        })
    }
    
    private func dismissDelAlert() {
        UIView.animate(withDuration: 0.3, animations: {
            self.delView.layer.opacity = 0
            self.backgroundForSizeView.layer.opacity = 0
            
        }, completion: {
            complete in
            self.delView.removeFromSuperview()
            self.backgroundForSizeView.removeFromSuperview()
        })
    }
}

//MARK: - CartCell Delegate

extension CartViewController: CartCellDelegate {
    func delCellData(data: CartModel) {
        callDeleteAlert(with:"товар")
        delView.completion = {[weak self] result in
            if result {
                RealmDataService.shared.delObject(object: data)
                self?.dismissDelAlert()
                self?.tableView.reloadData()
                self?.setSummLabelData()
                self?.setTabBarCartIconBadge()
            } else {
                self?.dismissDelAlert()
            }
        }
    }
}


//MARK: - TableViewDelegate, TableViewDataSource

extension CartViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cartProducts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CartCell.reuseId) as! CartCell
        let cellData = cartProducts[indexPath.row]
        cell.setCellData(data: cellData)
        cell.delegate = self
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
