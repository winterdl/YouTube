//
//  SettingCell.swift
//  youtube
//
//  Created by Ihar Tsimafeichyk on 2/12/17.
//  Copyright © 2017 epam. All rights reserved.
//

import UIKit

class SettingCell: BaseCell {
    
    override var isHighlighted: Bool {
        didSet{
            backgroundColor = isHighlighted ? UIColor.darkGray : UIColor.white
            nameLabel.textColor = isHighlighted ? UIColor.white : UIColor.black
            
            
            
            itemImage.tintColor = isHighlighted ? UIColor.white : UIColor.darkGray
        }
    }
    
    var settingsItem: SettingsItem? {
        didSet{
            nameLabel.text = settingsItem?.itemName.rawValue
            
            if let image = settingsItem?.itemImageName {
                itemImage.image = UIImage(named: image)?.withRenderingMode(.alwaysTemplate)// allows to change image tintColor propertie
                itemImage.tintColor = UIColor.darkGray
            }
        }
    }
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()
    
    let itemImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    
    override func setupViews() {
        super.setupViews()
        
        isUserInteractionEnabled = true
        
        addSubview(nameLabel)
        addSubview(itemImage)
        
        addConstraintsWithFormat(format: "H:|-8-[v0(30)]-8-[v1]|", views: itemImage, nameLabel)
        addConstraintsWithFormat(format: "V:|[v0]|", views: nameLabel)
        addConstraintsWithFormat(format: "V:[v0(30)]", views: itemImage)
        
        addConstraint(NSLayoutConstraint(item: itemImage, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
    }
}
