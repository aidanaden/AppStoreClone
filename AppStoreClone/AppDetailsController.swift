//
//  AppDetailsController.swift
//  AppStoreClone
//
//  Created by Aidan Aden on 7/8/17.
//  Copyright © 2017 Aidan Aden. All rights reserved.
//

import UIKit
import Alamofire


class AppDetailsController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var app: App? {
        didSet {
            
            if app?.screenshots != nil {
                return
            }
            
            if let id = app?.id?.stringValue {
                
                let urlString = "https://api.letsbuildthatapp.com/appstore/appdetail?id=\(id)"
                Alamofire.request(urlString).responseJSON(completionHandler: { (response) in
                    
                    if response.error != nil {
                        print(response.error?.localizedDescription)
                        return
                    }
                    
                    do {
                        
                        let json = try(JSONSerialization.jsonObject(with: response.data!, options: .mutableContainers)) as! [String: Any]
                        
                        let appDetail = App()
                        appDetail.setValuesForKeys(json)
                        
                        self.app = appDetail
                        
                        self.collectionView?.reloadData()
                        
                    } catch let err {
                        print(err)
                    }
                })
            }
        }
    }
    
    private let headerId = "headerId"
    private let cellId = "cellId"
    private let descriptionCellId = "descriptionCellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.backgroundColor = .white
        collectionView?.alwaysBounceVertical = true
        
        collectionView?.register(AppDetailHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerId)
        collectionView?.register(ScreenshotCell.self, forCellWithReuseIdentifier: cellId)
        collectionView?.register(AppDetailDescriptionCell.self, forCellWithReuseIdentifier: descriptionCellId)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! AppDetailHeader
        header.app = app
        
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        return CGSize(width: view.frame.width, height: 170)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.item == 1 {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: descriptionCellId, for: indexPath) as! AppDetailDescriptionCell
            cell.textView.attributedText = descriptionAttributeText()
            return cell
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ScreenshotCell
        cell.app = app
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.item == 1 {
            
            let dummySize = CGSize(width: view.frame.width - 8 - 8, height: 1000)
            let options = NSStringDrawingOptions.usesFontLeading.union(NSStringDrawingOptions.usesLineFragmentOrigin)
            let rect = descriptionAttributeText().boundingRect(with: dummySize, options: options, context: nil)
            
            return CGSize(width: view.frame.width, height: rect.height + 30)
        }
        
        return CGSize(width: view.frame.width, height: 180)
    }
    
    private func descriptionAttributeText() -> NSAttributedString {
        
        let attributedText = NSMutableAttributedString(string: "Description\n", attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 14)])
        
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 10
        
        let range = NSRange(location: 0, length: attributedText.string.characters.count)
        attributedText.addAttribute(NSParagraphStyleAttributeName, value: style, range: range)
        
        if let desc = app?.desc {
            attributedText.append(NSAttributedString(string: desc, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 11), NSForegroundColorAttributeName: UIColor.darkGray]))
        }
        return attributedText
    }
}

class AppDetailDescriptionCell: BaseCell {
    
    let textView: UITextView = {
        
        let tv = UITextView()
        tv.text = "SAMPLE TEXT STUFF"
        return tv
    }()
    
    let dividerLineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.init(white: 0.4, alpha: 0.4)
        return view
    }()
    
    override func setupViews() {
        super.setupViews()
        
        addSubview(textView)
        addSubview(dividerLineView)
        
        addConstraintsWithFormat(format: "H:|-8-[v0]-8-|", views: textView)
        addConstraintsWithFormat(format: "V:|-4-[v0]-4-[v1(1)]|", views: textView,dividerLineView)
        
        addConstraintsWithFormat(format: "H:|-14-[v0]|", views: dividerLineView)
    }
}


class AppDetailHeader: BaseCell {
    
    var app: App? {
        didSet {
            
            if let imageName = app?.imageName {
                imageView.image = UIImage(named: imageName)
            }
            
            if let name = app?.name {
                nameLbl.text = name
            }
            
            if let price = app?.price {
                buyButton.setTitle("$\(price)", for: .normal)
            }
        }
    }
    
    let imageView: UIImageView = {
       
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 20
        return iv
    }()
    
    let segmentedController: UISegmentedControl = {
        
        let sc = UISegmentedControl(items: ["Details","Reviews","Related"])
        sc.tintColor = .darkGray
        sc.selectedSegmentIndex = 0
        return sc
    }()
    
    let nameLbl: UILabel = {
        
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 16)
        return lbl
    }()
    
    let buyButton: UIButton = {
       
        let btn = UIButton(type: .system)
        btn.setTitle("BUY", for: .normal)
        btn.layer.borderColor = UIColor(red: 0, green: 129/255, blue: 250/255, alpha: 1).cgColor
        btn.layer.borderWidth = 1
        btn.layer.cornerRadius = 5
        btn.clipsToBounds = true
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        return btn
    }()
    
    let dividerLineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.init(white: 0.4, alpha: 0.4)
        return view
    }()
    
    override func setupViews() {
        super.setupViews()
        
        
        addSubview(imageView)
        addSubview(segmentedController)
        addSubview(nameLbl)
        addSubview(buyButton)
        addSubview(dividerLineView)
    
        
        addConstraintsWithFormat(format: "H:|-14-[v0(100)]-8-[v1]|", views: imageView, nameLbl)
        addConstraintsWithFormat(format: "V:|-14-[v0(100)]", views: imageView)
        
        addConstraintsWithFormat(format: "V:|-14-[v0(20)]", views: nameLbl)
        
        addConstraintsWithFormat(format: "H:|-40-[v0]-40-|", views: segmentedController)
        addConstraintsWithFormat(format: "V:[v0(34)]-8-|", views: segmentedController)
        
        addConstraintsWithFormat(format: "H:[v0(60)]-14-|", views: buyButton)
        addConstraintsWithFormat(format: "V:[v0(32)]-58-|", views: buyButton)
        
        addConstraintsWithFormat(format: "H:|[v0]|", views: dividerLineView)
        addConstraintsWithFormat(format: "V:[v0(0.5)]|", views: dividerLineView)
    }
}

extension UIView {
    
    func addConstraintsWithFormat(format: String, views: UIView... ) {
        
        var viewsDictionary = [String: UIView]()
        
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            viewsDictionary[key] = view
            view.translatesAutoresizingMaskIntoConstraints = false
        }
    
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
    }
}

class BaseCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    
    func setupViews() {
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



















