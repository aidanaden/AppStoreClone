//
//  FeaturedApps.swift
//  AppStoreClone
//
//  Created by Aidan Aden on 4/8/17.
//  Copyright © 2017 Aidan Aden. All rights reserved.
//

import UIKit
import Alamofire

class FeaturedApps: NSObject {
    
    var bannerCategory: AppCategory?
    var appCategories: [AppCategory]?
    
    override func setValue(_ value: Any?, forKey key: String) {
        if key == "categories" {
            appCategories = [AppCategory]()
            
            for dict in value as! [[String: Any]] {
                
                let appCategory = AppCategory()
                appCategory.setValuesForKeys(dict)
                
                appCategories?.append(appCategory)
            }
        } else if key == "bannerCategory" {
            bannerCategory = AppCategory()
            bannerCategory?.setValuesForKeys(value as! [String: Any])
        } else {
            super.setValue(value, forKey: key)
        }
    }
}

















