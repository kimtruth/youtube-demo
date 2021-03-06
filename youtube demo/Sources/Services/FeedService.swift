//
//  FeedService.swift
//  youtube demo
//
//  Created by truth on 2019. 2. 7..
//  Copyright © 2019년 kimtruth. All rights reserved.
//

import UIKit

struct FeedService: APIServiceType {
  static func feed(page: Feed, completion: @escaping(([Video]) -> Void)) {
    
    var urlString = "https://s3-us-west-2.amazonaws.com/youtubeassets/"
    
    switch page {
    case .home:
      urlString += "home.json"
    case .trending:
      urlString += "trending.json"
    case .subscriptions:
      urlString += "subscriptions.json"
    }
    
    guard let url = URL(string: urlString) else { return }
    
    URLSession.shared.dataTask(with: url) { (data, res, err) in
      guard let data = data else { return }
      
      let decoder = JSONDecoder()
      decoder.keyDecodingStrategy = .convertFromSnakeCase
      do {
        let videos = try decoder.decode([Video].self, from: data)
        DispatchQueue.main.async {
          completion(videos)
        }
      } catch let jsonErr {
        print("json decode error:", jsonErr)
      }
      
    }.resume()
  }
}
