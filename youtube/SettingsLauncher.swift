//
//  SettingsLauncher.swift
//  youtube
//
//  Created by Ihar Tsimafeichyk on 2/12/17.
//  Copyright © 2017 epam. All rights reserved.
//

import UIKit

// Enum used here to prevent any issues 
// related to the changes of cell names
enum SettingString : String {
    case settings = "Settings"
    case terms = "Terms and privacy policy"
    case feedback = "Send Feedback"
    case help = "Help"
    case switchAccount = "Switch Account"
    case cancel = "Cancel"
}


class SettingsLauncher : NSObject, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    let blackView = UIView()
    
    let cellId = "cellID"
    let cellHeight : CGFloat = 50

    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.white
        return cv
    }()
    
    
    // Settings data source
    let settingsItems: [SettingsItem] = {
        
        return [
            SettingsItem(itemName: .settings, itemImageName: "settings"),
            SettingsItem(itemName: .terms, itemImageName: "privacy"),
            SettingsItem(itemName: .feedback, itemImageName: "feedback"),
            SettingsItem(itemName: .help, itemImageName: "help"),
            SettingsItem(itemName: .switchAccount, itemImageName: "switch_account"),
            SettingsItem(itemName: .cancel, itemImageName: "cancel")
        ]
        
    }()
    
    func showSettings () {
        
        if let window = UIApplication.shared.keyWindow {
            
            blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissHandler)))
            
            blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
            blackView.frame = window.frame
            blackView.alpha = 0
            
            window.addSubview(blackView)
            window.addSubview(collectionView)
            
            let height: CGFloat = CGFloat(settingsItems.count) * cellHeight
            
            let y = window.frame.height - height
            
            self.collectionView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: window.frame.height)

            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.blackView.alpha = 1
                self.collectionView.frame = CGRect(x: 0, y: y, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
            }, completion: nil)
            
        }
    }
    
    var homeViewController : HomeController?
    
    func dismissHandler(settingsItem: SettingsItem) {
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.blackView.alpha = 0
            if let window = UIApplication.shared.keyWindow {
                self.collectionView.frame = CGRect(x: 0, y: window.frame.height, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
            }
        
        }, completion: { (complited: Bool) in
            // show related settings controller
            if  settingsItem.itemName != .cancel {
                self.homeViewController?.showControllerForSettings(settingsItem: settingsItem)
            }
        })
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return settingsItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SettingCell

        cell.settingsItem = settingsItems[indexPath.item]
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let setting = settingsItems[indexPath.item]
        dismissHandler(settingsItem: setting)
    }
    
    override init() {
        super.init()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(SettingCell.self, forCellWithReuseIdentifier: cellId)

    }
}
