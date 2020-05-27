//
//  UtilFunctions.swift
//  Viajabessa
//
//  Created by Fernanda Carvalho on 26/03/20.
//  Copyright © 2020 Fernanda Carvalho. All rights reserved.
//

import Foundation
import UIKit

class UtilFunctions {
    
    static var vSpinner : UIView?

    class func showActivityIndicatorView(onView : UIView) {
        vSpinner?.removeFromSuperview()
        vSpinner = nil
        let spinnerView = UIView.init(frame: UIScreen.main.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let ai = UIActivityIndicatorView.init(style: .whiteLarge)
        ai.startAnimating()
        ai.center = spinnerView.center
        
        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            onView.addSubview(spinnerView)
            vSpinner = spinnerView
        }
    }
    
    class func removeActivityIndicatorView() {
       DispatchQueue.main.async {
            vSpinner?.removeFromSuperview()
            vSpinner = nil
        }
    }
    
    class func downloadImage(from url: URL, completion: @escaping (UIImage?) -> (), failure: @escaping (Error?) -> ()) {
        getDataFromUrl(url: url) { data, response, error in
            guard let data = data, error == nil else {
                failure(error)
                return
            }
            if let image = UIImage(data: data) {
                completion(image)
            } else {
                completion(nil)
            }
        }
    }
    
    class func getDataFromUrl(url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
}
