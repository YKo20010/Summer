//
//  Extension.swift
//  Summer
//
//  Created by Artesia Ko on 12/27/18.
//  Copyright © 2018 Yanlam. All rights reserved.
//

import UIKit
import Firebase

let imageCache = NSCache<AnyObject, AnyObject>()

extension UIImageView {
    
    func loadImage(urlString: String) {
        
        if let cachedImage = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
            self.image = cachedImage
            return
        }
        
        let url = URL(string: urlString)
        URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
            if error != nil {
                print(error)
                return
            }
            DispatchQueue.main.async {
                if let dlImage = UIImage(data: data!) {
                    imageCache.setObject(dlImage, forKey: urlString as AnyObject)
                    self.image = dlImage
                }
            }
        }).resume()
    }
    
}


