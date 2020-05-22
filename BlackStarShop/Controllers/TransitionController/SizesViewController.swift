//
//  SizesViewController.swift
//  Transition
//
//  Created by Maxim Alekseev on 06.05.2020.
//  Copyright © 2020 Maxim Alekseev. All rights reserved.
//

import UIKit

class SizesViewController: UIViewController {
        
   // private var shoppingProduct: ShoppingProductsResponse
    private var shopingProductOffers: [ShoppingProductsOffer]
    weak var delegate: SizesViewControllerDelegate?
    
    private let upperLineView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .customGrey()
        return view
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    init (shopingProductOffers: [ShoppingProductsOffer]) {
        self.shopingProductOffers = shopingProductOffers
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.layer.cornerRadius = 24
        setupConstraints()
        setUpTableView()
        setUpUpperView()
    }
    
}

//MARK: - Set Up TableView
extension SizesViewController {
    private func setUpTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        self.tableView.register(SizesCell.self, forCellReuseIdentifier: SizesCell.reuseId)
    }
}

//MARk: - Set up Upper View

extension SizesViewController {
    private func setUpUpperView () {
        upperLineView.layer.cornerRadius = 2
        upperLineView.clipsToBounds = true
    }
}

//MARK: - UITableViewDelegate, UITableViewDataSource
extension SizesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shopingProductOffers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SizesCell.reuseId) as! SizesCell
        let sizes = shopingProductOffers[indexPath.row].size
        cell.sizeLabel.text = sizes
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let currentCell = tableView.cellForRow(at: indexPath) as! SizesCell
        guard let productSize = currentCell.sizeLabel.text else { return }
        delegate?.cellSizeDataSet(to: productSize)
        self.dismiss(animated: true)
        
    }
    
}

// MARK: - Setup constraints


extension SizesViewController {
    private func setupConstraints () {
        view.addSubview(upperLineView)
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            //upperLineView
            upperLineView.topAnchor.constraint(equalTo: view.topAnchor, constant: 8),
            upperLineView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            upperLineView.heightAnchor.constraint(equalToConstant: 4),
            upperLineView.widthAnchor.constraint(equalToConstant: 56),
            
            // tableView
            tableView.topAnchor.constraint(equalTo: upperLineView.bottomAnchor, constant: 20),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}
