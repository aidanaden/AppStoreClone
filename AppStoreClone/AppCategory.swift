//
//  AppCategory.swift
//  AppStoreClone
//
//  Created by Aidan Aden on 4/8/17.
//  Copyright © 2017 Aidan Aden. All rights reserved.
//

import UIKit
import Alamofire


class AppCategory: NSObject {
    
    var name: String?
    var apps: [App]?
    var type: String?
    
    
    override func setValue(_ value: Any?, forKey key: String) {
        
        if key == "apps" {
            
            apps = [App]()
            
            for dict in value as! [[String: Any]] {
                
                let app = App()
                app.setValuesForKeys(dict)
                
                apps?.append(app)
            }
            
        } else {
            super.setValue(value, forKey: key)
        }
    }
    
    static func fetchFeaturedApps(_ complete: @escaping (FeaturedApps) -> ()) {
        
        let urlString = "https://api.letsbuildthatapp.com/appstore/featured"
        
        Alamofire.request(urlString).responseJSON { (response) in
            
            if let error = response.error {
                print(error.localizedDescription)
                return
            }
            
            do {
                
                let json = try(JSONSerialization.jsonObject(with: response.data!, options: .mutableContainers)) as! [String: Any]
                
                let featuredApps = FeaturedApps()
                featuredApps.setValuesForKeys(json)
                
                DispatchQueue.main.async {
                    complete(featuredApps)
                }
                
                
            } catch let err {
                print(err)
            }
        }
    }
    
    
}















