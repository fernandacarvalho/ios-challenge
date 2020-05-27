//
//  PackageDetailController.swift
//  Viajabessa
//
//  Created by Fernanda Carvalho on 26/03/20.
//  Copyright © 2020 Fernanda Carvalho. All rights reserved.
//

import UIKit

class PackageDetailController: UIViewController {
    
    weak var travelPackage: TravelPackage?
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var text: UILabel!
    @IBOutlet weak var installments: UILabel!
    @IBOutlet weak var imageUnavailableLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.updateScreen()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    func updateScreen() {
        guard let package = self.travelPackage else {
            return
        }
        
        self.name.text = package.name 
        self.price.text = "\(package.value)".formattedCurrency()
        self.installments.text = self.travelPackage?.installments
        self.text.text = package.packageDescription
        
        if let url = URL(string: package.locationImageUrl) {
            UtilFunctions.downloadImage(from: url, completion: { (image) in
                if let locationImage = image {
                    DispatchQueue.main.async() {
                        self.image.image = locationImage
                    }
                }
            }) { (error) in
                self.imageUnavailableLabel.isHidden = false
            }
        } else {
            self.imageUnavailableLabel.isHidden = false
        }
    }
}
