//
//  APIServiceType.swift
//  youtube demo
//
//  Created by truth on 2019. 2. 7..
//  Copyright © 2019년 kimtruth. All rights reserved.
//

protocol APIServiceType {
}

extension APIServiceType {
  static func url(_ path: String) -> String {
    return "https://s3-us-west-2.amazonaws.com/youtubeassets/" + path
  }
}
