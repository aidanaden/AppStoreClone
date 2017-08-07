//
//  ScreenshotCell.swift
//  AppStoreClone
//
//  Created by Aidan Aden on 7/8/17.
//  Copyright © 2017 Aidan Aden. All rights reserved.
//

import UIKit


class ScreenshotCell: BaseCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    var app: App? {
        didSet {
            screenShotCollectionView.reloadData()
        }
    }
    
    private let cellId = "CellId"
    
    let screenShotCollectionView: UICollectionView = {
        
        let layout = SnappingCollectionViewLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        return cv
    }()
    
    let dividerLineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.init(white: 0.4, alpha: 0.4)
        return view
    }()
    
    override func setupViews() {
        super.setupViews()
        
        screenShotCollectionView.delegate = self
        screenShotCollectionView.dataSource = self
        
        screenShotCollectionView.register(ScreenshotImageCell.self, forCellWithReuseIdentifier: cellId)
        
        screenShotCollectionView.decelerationRate = UIScrollViewDecelerationRateFast
        screenShotCollectionView.contentInset = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        
        addSubview(screenShotCollectionView)
        addSubview(dividerLineView)
        
        addConstraintsWithFormat(format: "H:|-14-[v0]|", views: dividerLineView)
        
        addConstraintsWithFormat(format: "H:|[v0]|", views: screenShotCollectionView)
        addConstraintsWithFormat(format: "V:|[v0][v1(1)]|", views: screenShotCollectionView, dividerLineView)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if let total = app?.screenshots?.count {
            
            return total
            
        } else {
            
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = screenShotCollectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ScreenshotImageCell
        
        if let imageName = app?.screenshots?[indexPath.item] {
            
            cell.imageView.image = UIImage(named: imageName)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 240, height: frame.height - 28)
    }
    
    private class ScreenshotImageCell: BaseCell {
        
        let imageView: UIImageView = {
            
            let iv = UIImageView()
            iv.contentMode = .scaleAspectFill
            iv.backgroundColor = .green
            iv.clipsToBounds = true
            return iv
        }()
        
        override func setupViews() {
            super.setupViews()
            
            addSubview(imageView)
            
            addConstraintsWithFormat(format: "V:|[v0]|", views: imageView)
            addConstraintsWithFormat(format: "H:|[v0]|", views: imageView)
        }
    }
}

















