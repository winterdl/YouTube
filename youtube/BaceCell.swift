//
//  BaceCell.swift
//  youtube
//
//  Created by Ihar Tsimafeichyk on 2/11/17.
//  Copyright © 2017 epam. All rights reserved.
//

import UIKit

class BaseCell : UICollectionViewCell {
    override init(frame: CGRect){
        super.init(frame: frame)
        setupViews()
    }
    
    func setupViews() {
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

