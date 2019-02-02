//
//  CustomImageView.swift
//  youtube demo
//
//  Created by truth on 2019. 2. 2..
//  Copyright © 2019년 kimtruth. All rights reserved.
//

import UIKit

final class CustomImageView: UIImageView {
  
  private var imageUrl: String?
  private var imageCache = NSCache<NSString, UIImage>()
  
  func setImage(with urlString: String) {
    guard let url = URL(string: urlString) else { return }
    
    self.imageUrl = urlString
    self.image = nil
    
    if let cacheImage = self.imageCache.object(forKey: urlString as NSString) {
      self.image = cacheImage
      return
    }
    
    URLSession.shared.dataTask(with: url) { (data, response, err) in
      guard let data = data else { return }
      
      DispatchQueue.main.async {
        guard let imageToCache = UIImage(data: data) else { return }
        
        if self.imageUrl == urlString {
          self.image = UIImage(data: data)
        }
        
        self.imageCache.setObject(imageToCache, forKey: urlString as NSString)
      }
      }.resume()
  }
}
