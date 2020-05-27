//
//  MainNavigationController.swift
//  Viajabessa
//
//  Created by Fernanda Carvalho on 25/03/20.
//  Copyright © 2020 Fernanda Carvalho. All rights reserved.
//

import UIKit

class MainNavigationController: UINavigationController {
        
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.styleNavbar()
    }
    
    func styleNavbar() {
        self.navigationBar.barTintColor = blue_dark
        self.navigationBar.tintColor = .white
        if let font = UIFont(name: fontBold, size: 18) {
            self.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: font, NSAttributedString.Key.foregroundColor: UIColor.white]
        }
    }
}
