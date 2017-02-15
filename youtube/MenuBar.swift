//
//  MenuBar.swift
//  youtube
//
//  Created by Ihar Tsimafeichyk on 2/11/17.
//  Copyright © 2017 epam. All rights reserved.
//

import UIKit

class MenuBar: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.rgb(red: 230, green: 32, blue: 31)
        cv.delegate = self
        cv.dataSource = self
        return cv
    }()
    
    var homeController: HomeController?
    let cellId = "cellId"
    let imageNames = ["home", "trending", "subscriptions", "account"]
    
    override init(frame: CGRect){
        super.init(frame: frame)
        
        // register the collectionViewCell
        collectionView.register(MenuCell.self, forCellWithReuseIdentifier: cellId)
        
        
        addSubview(collectionView)
        addConstraintsWithFormat(format: "H:|[v0]|", views: collectionView)
        addConstraintsWithFormat(format: "V:|[v0]|", views: collectionView)
     
        backgroundColor = UIColor.rgb(red: 230, green: 32, blue: 31)
        
        // select first item on startup
        let selectedIndexPath = IndexPath(item: 0, section: 0)
        collectionView.selectItem(at: selectedIndexPath, animated: false, scrollPosition: .top)
        
        setupHorisontalBar()
    }
    
    var horisontalBarLeftAncorConstrains: NSLayoutConstraint?
    
    func setupHorisontalBar(){
        let horisontalView = UIView()
        horisontalView.backgroundColor = UIColor(white: 0.95, alpha: 1)
        horisontalView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(horisontalView)
        
        
        // This is the way how to create the views in iOS9-10
        // x
        horisontalBarLeftAncorConstrains = horisontalView.leftAnchor.constraint(equalTo: self.leftAnchor)
        horisontalBarLeftAncorConstrains?.isActive = true
        // y
        horisontalView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        // width
        horisontalView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/4).isActive = true
        // heigh
        horisontalView.heightAnchor.constraint(equalToConstant: 4).isActive = true

        // old school way was based on using frames:
        //  horisontalView.frame.CGRect(...)
        
    }
    
    // make move the white bottom line workflow
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

//        let x = CGFloat(indexPath.item) * frame.width / 4
//        horisontalBarLeftAncorConstrains?.constant = x
//        
//        // some slide animation
//        UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
//            self.layoutIfNeeded()
//        }, completion: nil)
        
        // code above commented since same functionality provided by the scrollview (line of code below)
        
        homeController?.scrollToMenueIndex(menuIndex: indexPath.item)
        
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MenuCell
        
        cell.imageView.image = UIImage(named: imageNames[indexPath.item])?.withRenderingMode(.alwaysTemplate)
        cell.tintColor = UIColor.rgb(red: 91, green: 14, blue: 13)
        
        return cell
    }
    
    // MARK: - Cell size
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: frame.width / 4 , height: frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
