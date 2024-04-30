//
//  View.swift
//  CryptoViper
//
//  Created by Omer Keskin on 24.04.2024.
//

import Foundation
import UIKit

// talks to presenter
// class, protocol
// viewcontroller


protocol AnyView{
    
    var presenter: AnyPresenter? {get set}
    
    func update(with cryptos: [Crypto])
    func update(with error: String)
}


class CryptoView: UIViewController, AnyView, UITableViewDelegate, UITableViewDataSource{
    
    var presenter: (any AnyPresenter)?
    var cryptos : [Crypto] = []
    
    
    private let tableview : UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.isHidden = true
        return table
    }()
    
    private let messageLabel : UILabel = {
       let label = UILabel()
        label.isHidden = false
        label.text = "Downlaoding..."
        label.font = UIFont.systemFont(ofSize: 21)
        label.textColor = .black
        label.textAlignment = .center
        return label
        
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(messageLabel)
        view.addSubview(tableview)
        tableview.delegate = self
        tableview.dataSource = self
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableview.frame = view.bounds
        messageLabel.frame = CGRect(x: view.frame.width / 2 - 150, y: view.frame.height / 2 - 35, width: 300, height: 70)
    }
    
    
    
    func update(with cryptos: [Crypto]) {
        DispatchQueue.main.async {
            self.cryptos = cryptos
            self.messageLabel.isHidden = true
            self.tableview.reloadData()
            self.tableview.isHidden = false
            
        }
    }
    
    
    
    func update(with error: String) {
        DispatchQueue.main.async {
            self.cryptos = []
            self.tableview.isHidden = true
            self.messageLabel.text = error
            self.messageLabel.isHidden = false
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cryptos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        content.text = cryptos[indexPath.row].currency
        content.secondaryText = cryptos[indexPath.row].price
        cell.contentConfiguration = content
        cell.backgroundColor = .systemBackground
        
        return cell
    }
    
    
}
