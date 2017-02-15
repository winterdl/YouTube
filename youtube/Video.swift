//
//  Video.swift
//  youtube
//
//  Created by Ihar Tsimafeichyk on 2/11/17.
//  Copyright © 2017 epam. All rights reserved.
//

import UIKit

class SafeJesonObject : NSObject {
    
    override func setValue(_ value: Any?, forKey key: String) {
        let uppercasedFirstCharacter = String(key.characters.first!).uppercased()
        
        let range = NSMakeRange(0, 1)
        let selectorString = NSString(string: key).replacingCharacters(in: range, with: uppercasedFirstCharacter)
        
        let selector = NSSelectorFromString("set\(selectorString):")
        let responds = self.responds(to: selector)
        
        if !responds {
            return
        }
            super.setValue(value, forKey: key)
    }
}

class Video : SafeJesonObject {
    
    var thumbnail_image_name: String?
    var title : String?
    var number_of_views: NSNumber?
    var uploadDate: NSData?
    var duration: NSNumber?
    
    var channel: Channel?
    
    override func setValue(_ value: Any?, forKey key: String) {
        if key == "channel" {
            // custom channel setup
            let channelDictionary = value as! [String: AnyObject]
            self.channel = Channel()
            channel?.setValuesForKeys(channelDictionary)
            
        } else {
            super.setValue(value, forKey: key)
        }
    }
    
    init(dictionary: [String: Any]) {
        super.init()
        setValuesForKeys(dictionary)
    }
}

class Channel : SafeJesonObject {
    var name: String?
    var profile_image_name: String?
}
