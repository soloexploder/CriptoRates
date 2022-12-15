//
//  DetailCoinViewController.swift
//  CriptoRates
//
//  Created by Даниил Хантуров on 13.12.2022.
//

import UIKit

class CoinDetailsViewController: UIViewController {
     var coin: Coin?
    
    private var detailLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 300, height: 400))
        label.center = CGPoint(x: 160, y: 285)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setup(subviews: detailLabel)
      
        self.detailLabel.text = coin?.description ?? "unknown"
    }
    
    private func setup(subviews: UIView...) {
        subviews.forEach { subview in
            view.addSubview(subview)
        }
    }
}
