//
//  PhotoDownloader.swift
//  MessageBoardApp
//
//  Created by curtis scott on 06/07/2020.
//  Copyright © 2020 CurtisScott. All rights reserved.
//

import Foundation
import UIKit
class PhotoDownloader {
    
    static let imageSession = URLSession(configuration: .ephemeral)

    static let cache = NSCache<NSURL, UIImage>()

    static func loadImage(from url: URL, completion: @escaping (UIImage?,Error?) -> Void)
    {
      if let image = cache.object(forKey: url as NSURL)
      {
        completion(image,nil)
      }
      else
      {
        let task = imageSession.dataTask(with: url) { (imageData, _, error) in
          guard let imageData = imageData,
          let image = UIImage(data: imageData)
            else { completion(nil,error)
            return
                
            }
          
         self.cache.setObject(image, forKey: url as NSURL)
            completion(image,nil)
          
        }
        task.resume()
      }
    }
    
   
    
}
