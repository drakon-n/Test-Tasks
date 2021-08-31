//
//  ViewController.swift
//  Sber RSS
//
//  Created by Влад on 07.10.2020.
//  Copyright © 2020 Влад. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {
    
    var headerView: UIView!
    var titleLabel: UILabel!
    var sourseButton: UIButton!
    var loginButton: UIButton!
    
        //let newViewController = NewsViewController()
        //self.navigationController?.pushViewController(newViewController, animated: true)
    
    override func viewDidLoad() {
        
        self.view.backgroundColor = UIColor.white
        super.viewDidLoad()
    
        headerView = UIView()
        headerView.backgroundColor = UIColor.orange
        self.view.addSubview(headerView)
        
        titleLabel = UILabel()
        titleLabel.text = "RSS News"
        titleLabel.textColor = UIColor.white
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont(name: titleLabel.font.fontName, size: 30)
        headerView.addSubview(titleLabel)
        
        sourseButton = UIButton()
        sourseButton.setTitle("Lenta", for: .normal)
        sourseButton.backgroundColor = UIColor.orange
        sourseButton.layer.cornerRadius = 5
        sourseButton.addTarget(self, action: #selector(StartViewController.buttonAction(sender:)), for: UIControl.Event.touchUpInside)
        self.view.addSubview(sourseButton)
        
        
        headerView.translatesAutoresizingMaskIntoConstraints = false
        headerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        headerView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        headerView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1).isActive = true
        headerView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.15).isActive = true
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.centerXAnchor.constraint(equalTo: headerView.centerXAnchor).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: headerView.bottomAnchor).isActive = true
        titleLabel.widthAnchor.constraint(equalTo: headerView.widthAnchor, multiplier: 0.4).isActive = true
        titleLabel.heightAnchor.constraint(equalTo: headerView.heightAnchor, multiplier: 0.5).isActive = true
        
        sourseButton.translatesAutoresizingMaskIntoConstraints = false
        sourseButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        sourseButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        sourseButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.7).isActive = true
        sourseButton.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.15).isActive = true
        
    }
    
    
    @objc func buttonAction(sender: UIButton!){
        let newViewController = NewsViewController()
        self.navigationController?.pushViewController(newViewController, animated: true)
        self.present(newViewController, animated: true)
    }
}

