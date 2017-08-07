//
//  App.swift
//  AppStoreClone
//
//  Created by Aidan Aden on 4/8/17.
//  Copyright © 2017 Aidan Aden. All rights reserved.
//

import UIKit

class App: NSObject {
    
    var id: NSNumber?
    var name: String?
    var category: String?
    var price: NSNumber?
    var imageName: String?
    var screenshots: [String]?
    var desc: String?
    var appInformation: Any?
    
    override func setValue(_ value: Any?, forKey key: String) {
        
        if key == "description" {
            self.desc = value as? String
        } else {
            super.setValue(value, forKey: key)
        }
    }
    
}




















