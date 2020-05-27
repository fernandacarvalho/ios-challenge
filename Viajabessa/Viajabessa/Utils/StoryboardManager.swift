//
//  StoryboardManager.swift
//  Viajabessa
//
//  Created by Fernanda Carvalho on 25/03/20.
//  Copyright © 2020 Fernanda Carvalho. All rights reserved.
//

import UIKit

class StoryboardManager: NSObject {
    class var packages: UIStoryboard {
        return UIStoryboard(name: "PackageListView", bundle: nil)
    }
    
    class var packageDetail: UIStoryboard {
        return UIStoryboard(name: "PackageDetailView", bundle: nil)
    }
}
