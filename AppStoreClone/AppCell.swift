//
//  AppCell.swift
//  AppStoreClone
//
//  Created by Aidan Aden on 3/8/17.
//  Copyright © 2017 Aidan Aden. All rights reserved.
//

import UIKit


class AppCell: UICollectionViewCell {
    
    var app: App? {
        didSet {
            
            if let title = app?.name {
                
                titleLbl.text = title
                
                let rect = NSString(string: title).boundingRect(with: CGSize(width: frame.width, height: 1000), options: NSStringDrawingOptions.usesFontLeading.union(NSStringDrawingOptions.usesLineFragmentOrigin), attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 14)], context: nil)
                
                if rect.height > 20 {
                    // length of app name requires 2 lines
                    categoryLbl.frame = CGRect(x: 0, y: frame.width + 38, width: frame.width, height: 20)
                    priceLbl.frame = CGRect(x: 0, y: frame.width + 56, width: frame.width, height: 20)
                    
                } else {
                    // length of app name only requires 1 line
                    categoryLbl.frame = CGRect(x: 0, y: frame.width + 20, width: frame.width, height: 20)
                    priceLbl.frame = CGRect(x: 0, y: frame.width + 40, width: frame.width, height: 20)
                }
                
                titleLbl.frame = CGRect(x: 0, y: frame.width + 2, width: frame.width, height: 40)
                titleLbl.sizeToFit()
            }
            
            if let category = app?.category {
                
                categoryLbl.text = category
            }
            
            if let price = app?.price?.stringValue {
                
                priceLbl.text = "$\(price)"
                
            } else {
                
                priceLbl.text = ""
            }
            
            if let imageName = app?.imageName {
                
                imageView.image = UIImage(named: imageName)
            }
            
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    let titleLbl: UILabel = {
        
        let lbl = UILabel()
        lbl.text = "Disney Build It: Frozen"
        lbl.font = UIFont.systemFont(ofSize: 14)
        lbl.numberOfLines = 2
        return lbl
    }()
    
    let categoryLbl: UILabel = {
        
        let lbl = UILabel()
        lbl.text = "Entertainment"
        lbl.font = UIFont.systemFont(ofSize: 13)
        lbl.textColor = .darkGray
        lbl.numberOfLines = 2
        return lbl
    }()
    
    let priceLbl: UILabel = {
        
        let lbl = UILabel()
        lbl.text = "$3.99"
        lbl.textColor = .darkGray
        lbl.font = UIFont.systemFont(ofSize: 13)
        return lbl
    }()
    
    let imageView: UIImageView = {
       
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 20
        return iv
    }()
    
    func setupViews() {
        
        addSubview(imageView)
        addSubview(titleLbl)
        addSubview(categoryLbl)
        addSubview(priceLbl)
        
        imageView.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.width)
        titleLbl.frame = CGRect(x: 0, y: frame.width + 2, width: frame.width, height: 40)
        categoryLbl.frame = CGRect(x: 0, y: frame.width + 38, width: frame.width, height: 20)
        priceLbl.frame = CGRect(x: 0, y: frame.width + 56, width: frame.width, height: 20)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}




