//
//  ApplicationData.swift
//  Viajabessa
//
//  Created by Fernanda Carvalho on 27/03/20.
//  Copyright © 2020 Fernanda Carvalho. All rights reserved.
//

import Foundation
import Alamofire

private let data = ApplicationData()

class ApplicationData : NSObject {
    var headers : HTTPHeaders!
    
    class var sharedInstance : ApplicationData {
        return data
    }
    
    override init() {
        super.init()
        self.setHeaders()
    }
    
    func setHeaders() {
        let brand = UIDevice.current.model
        let systemVersion = UIDevice.current.systemVersion
        let model = UIDevice.current.name
        
        self.headers = ["Brand": brand, "IOS": systemVersion, "Model": model, "Content-Type": "application/json"]
    }
    
    func getTravelPackages(completion: @escaping ([TravelPackage]?) -> (), failure: @escaping () -> ()) {
        let url = UrlFactory.listPackagesUrl
        
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: self.headers).response { (response) in
            
            if let status = response.response?.statusCode, status != 200 {
                failure()
                return
            }
            
            guard let responseData = response.data else {
                failure()
                return
            }
            
            
            let decoder = JSONDecoder()

            do {
                let packages = try decoder.decode([TravelPackage].self, from: responseData)
                completion(packages)
            } catch {
                failure()
            }
        }
    }
}
