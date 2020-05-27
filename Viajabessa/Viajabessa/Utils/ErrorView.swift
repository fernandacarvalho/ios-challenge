//
//  ErrorView.swift
//  Viajabessa
//
//  Created by Fernanda Carvalho on 29/03/20.
//  Copyright © 2020 Fernanda Carvalho. All rights reserved.
//

import UIKit

class ErrorView: UIControl {
    
    private var tryAgainButton : UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = blue_medium
        
        let message = UILabel(frame: CGRect(x: 30, y: screenHeight/2.5, width: screenWidth - 60, height: 100))
        message.numberOfLines = 3
        message.text = "Não foi possível carregar as informações"
        message.textAlignment = .center
        message.textColor = gray_dark
        message.font = UIFont(name: fontRegular, size: 16)
        self.addSubview(message)
        
        self.tryAgainButton = UIButton(frame: CGRect(x: screenWidth/4, y: message.frame.maxY, width: screenWidth/2, height: 50))
        self.tryAgainButton.setTitle("TENTAR NOVAMENTE", for: .normal)
        self.tryAgainButton.addTarget(self, action: #selector(self.tryAgain), for: .touchUpInside)
        self.tryAgainButton.backgroundColor = purple
        self.tryAgainButton.layer.cornerRadius = 25
        self.tryAgainButton.clipsToBounds = true
        self.tryAgainButton.setTitleColor(beige, for: .normal)
        self.tryAgainButton.titleLabel?.font = UIFont(name: fontSemibold, size: 13)
        self.addSubview(self.tryAgainButton)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func tryAgain() {
        self.sendActions(for: .touchUpInside)
    }
}
