//
//  TravelPackageTableViewCell.swift
//  Viajabessa
//
//  Created by Fernanda Carvalho on 25/03/20.
//  Copyright © 2020 Fernanda Carvalho. All rights reserved.
//

import UIKit

protocol ListItemDelegate: class {
    func didTapItem(with id: Int64)
}

class TravelPackageTableViewCell: UITableViewCell {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var packageImage: UIImageView!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var tapView: UIView!
    @IBOutlet weak var installments: UILabel!
    weak var package: TravelPackage?
    weak var delegate: ListItemDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCellWith(package: TravelPackage) {
        self.startActivityIndicator()
        self.addGesture()
        self.package = package
        
        if let url = URL(string: package.bannerImageUrl) {
            UtilFunctions.downloadImage(from: url, completion: { (image) in
                if let promoImage = image {
                    DispatchQueue.main.async() {
                        self.packageImage.image = promoImage
                    }
                }
                self.stopActivityIndicator()
            }) { (error) in
                self.stopActivityIndicator()
            }
        } else {
            self.stopActivityIndicator()
        }
        
        self.title.text = package.title
        self.price.text = "\(package.value)".formattedCurrency()
        self.installments.text = package.installments
    }
    
    func addGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.handleTap))
        self.tapView.addGestureRecognizer(tapGesture)
    }
    
    @objc func handleTap(gesture: UITapGestureRecognizer) {
        if let travelPackage = self.package {
            self.delegate?.didTapItem(with: travelPackage.id)
        }
    }
    
    func startActivityIndicator() {
        self.activityIndicator.isHidden = false
        self.activityIndicator.startAnimating()
    }
    
    func stopActivityIndicator() {
        DispatchQueue.main.async() {
            self.activityIndicator.isHidden = true
            self.activityIndicator.stopAnimating()
        }
    }
}
