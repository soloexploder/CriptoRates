//
//  CoinsListViewController.swift
//  CriptoRates
//
//  Created by Даниил Хантуров on 13.12.2022.
//

import UIKit

class CoinsViewController: UITableViewController {
    
    private let coinsNames = ["btc","eth","tron", "luna", "polkadot",
                              "dogecoin", "tether", "stellar", "cardano", "xrp"]
    private var coins: [Coin] = []
    
    private var spinnerView = UIActivityIndicatorView(style: .large)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        setupNavigationBar()
        //spinnerView = showSpinner(in: view)
        showSpinner(in: view)
        fetchStaticData()
    }
    
    private func setupNavigationBar() {
        navigationItem.title = "Crypto Coins"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()

        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        
        navBarAppearance.backgroundColor = UIColor(
            red: 21/255,
            green: 101/255,
            blue: 192/255,
            alpha: 194/255
        )
        
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .close, target: self, action: #selector(logout))
    }
    
    private func showSpinner(in view: UIView) {
 
        spinnerView.color = .gray
        spinnerView.startAnimating()
        tableView.backgroundView = spinnerView
        spinnerView.hidesWhenStopped = true
    }
    
    @objc func logout() {
        AppDelegate.shared.rootViewController.switchToLogout()
    }
    
    
    func fetchStaticData() {
        for coin in coinsNames {
            NetworkManager.shared.fetchData(from: coin) { coin in
                self.coins.append(coin)
                self.tableView.reloadData()
                if self.spinnerView.isAnimating {
                    self.spinnerView.stopAnimating()                    
                }
            }
        }
    }
}

extension CoinsViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coins.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        content.text = coins[indexPath.row].data.name
        cell.contentConfiguration = content
        return cell
    }
    
    
}

// MARK: - UITableViewDelegate
extension CoinsViewController  {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let coin = self.coins[indexPath.row]
        let detailVC = CoinDetailsViewController()
        detailVC.coin = coin
        navigationController?.pushViewController(detailVC, animated: false)

    }
}



