//
//  Video.swift
//  youtube
//
//  Created by Ihar Tsimafeichyk on 2/11/17.
//  Copyright © 2017 epam. All rights reserved.
//

import UIKit

class Video : NSObject {
    
    var thumbnailImageName: String?
    var title : String?
    var numberOfViews: NSNumber?
    var uploadDate: NSData?
    
    var channel: Channel?
    
}

class Channel : NSObject {

    var name: String?
    var profileImageName: String?
}
