//
//  TravelPackage.swift
//  Viajabessa
//
//  Created by Fernanda Carvalho on 28/03/20.
//  Copyright © 2020 Fernanda Carvalho. All rights reserved.
//

import Foundation

class TravelPackage: NSObject, Codable {
    var id : Int64 = 0
    var title : String = ""
    var name : String = ""
    var bannerImageUrl : String = ""
    var locationImageUrl : String = ""
    var value : Float64 = 0
    var installments : String = ""
    var packageDescription : String = ""
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case name
        case bannerImageUrl
        case locationImageUrl
        case value
        case installments
        case packageDescription
    }

}
