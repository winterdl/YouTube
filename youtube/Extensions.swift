//
//  Extensions.swift
//  youtube
//
//  Created by Ihar Tsimafeichyk on 2/11/17.
//  Copyright © 2017 epam. All rights reserved.
//

import UIKit

extension UIColor {
    
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
    
}

extension UIView {
    func addConstraintsWithFormat(format: String,  views: UIView...)  {
        var viewDictionary = [String:UIView]()
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            view.translatesAutoresizingMaskIntoConstraints = false
            viewDictionary[key] = view
        }
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format,
                                                      options: NSLayoutFormatOptions(),
                                                      metrics: nil, views: viewDictionary))
    }
}

let imageCache = NSCache<NSString, UIImage>()

class CustomImageView : UIImageView {

    var imageUrlString: String?
    
    func loadImageUsing(urlString: String) {
        
        imageUrlString = urlString
        
        let url = URL(string: urlString)!
        
        image = nil
        
        if let imageFromCache = imageCache.object(forKey: urlString as NSString) {
            self.image = imageFromCache
            return
        }
        
        URLSession.shared.dataTask(with: url) {
            (data, responds, error) in
            
            if error != nil {
                print (error ?? "error")
                return
            }
            // Bounce back to the main thread to update the UI
            DispatchQueue.main.async {
                
                let imageToCache = UIImage.init(data: data!)

                
                if self.imageUrlString == urlString {
                    self.image = imageToCache
                }
                
                imageCache.setObject(imageToCache!, forKey: urlString as NSString)
            }
            
            }.resume()

    }

}
