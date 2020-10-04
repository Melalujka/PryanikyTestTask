//
//  ImageLoadManager.swift
//  PryanikyTestTask
//
//  Created by Melalujka on 02.10.2020.
//  Copyright © 2020 Melalujka. All rights reserved.
//

import UIKit

let imageCache = NSCache<NSString, UIImage>()

class ImageLoadManager {
    
    private var imageLoader: ImageLoader?
    
    init(_ imageLoader: ImageLoader = NetworkManager()) {
        self.imageLoader = imageLoader
    }
    
    func download(_ urlString: String, placeHolder: UIImage?, imageView: UIImageView?) {
        if let cachedImage = imageCache.object(forKey: NSString(string: urlString)) {
            imageView?.image = cachedImage
            return
        }
        
        guard let url = URL(string: urlString) else {
            imageView?.image = placeHolder
            return
        }
        
        imageLoader?.downloadPicture(url: url) { [weak imageView] image in
            
            guard let newImage = image else {
                imageView?.image = placeHolder
                return
            }
            
            imageCache.setObject(newImage, forKey: NSString(string: urlString))
            imageView?.image = newImage
        }
    }
    
    func cancel() {
        imageLoader?.cancel()
    }
}
