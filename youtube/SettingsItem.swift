//
//  SettingsItem.swift
//  youtube
//
//  Created by Ihar Tsimafeichyk on 2/13/17.
//  Copyright © 2017 epam. All rights reserved.
//

import Foundation

class SettingsItem: NSObject {
    
    var itemName: SettingString
    var itemImageName: String
    
    init(itemName: SettingString, itemImageName : String) {
        self.itemName = itemName
        self.itemImageName = itemImageName
    }

}
