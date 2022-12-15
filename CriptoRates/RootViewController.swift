//
//  RootViewController.swift
//  CriptoRates
//
//  Created by Даниил Хантуров on 13.12.2022.
//

import UIKit

class RootViewController: UIViewController {
    private var current: UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addChild(current)
        current.view.frame = view.bounds
        view.addSubview(current.view)
        current.didMove(toParent: self)
    }
    
    func showCoinsListVC() {
        let new = UINavigationController(rootViewController: CoinsViewController())
        animateFadeTransition(to: new)
        addChild(new)
        new.view.frame = view.bounds
        view.addSubview(new.view)
        new.didMove(toParent: self)
        
        current.willMove(toParent: nil)
        current.view.removeFromSuperview()
        current.removeFromParent()
        current = new
    }
    
    func switchToLogout() {
        let logoutScreen = UINavigationController(rootViewController: LoginViewController())
        addChild(logoutScreen)
        logoutScreen.view.frame = view.bounds
        view.addSubview(logoutScreen.view)
        logoutScreen.didMove(toParent: self)

        current.willMove(toParent: nil)
        current.view.removeFromSuperview()
        current.removeFromParent()
        current = logoutScreen
    }
    
    private func animateFadeTransition(to new: UIViewController,
                                       complition: (() -> Void)? = nil) {
        current.willMove(toParent: nil)
        addChild(new)
        
        transition(from: current, to: new, duration: 0.3, options: [.transitionCrossDissolve, .curveEaseOut]) {
            new.view.frame = self.view.bounds
        } completion: { completed in
            self.current.removeFromParent()
            new.didMove(toParent: self)
            self.current = new
            complition?()
        }

    }
    
    private func animatedDismissTransition(to new: UIViewController,
                                           completion:(() -> Void)? = nil) {
        let initialFrame = CGRect(x: -view.bounds.width,
                                 y: 0,
                                 width: view.bounds.width,
                                 height: view.bounds.height)
        current.willMove(toParent: nil)
        addChild(new)
        new.view.frame = initialFrame
        
        transition(from: current, to: new, duration: 0.3, options: []) {
            new.view.frame = self.view.bounds
        } completion: { completed in
            self.current.removeFromParent()
            new.didMove(toParent: self)
            self.current = new
            completion?()
        }

    }
    
    init() {
        self.current = LoginViewController()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
