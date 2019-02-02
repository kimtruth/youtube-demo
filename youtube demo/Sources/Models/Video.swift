//
//  Video.swift
//  youtube demo
//
//  Created by truth on 2019. 2. 2..
//  Copyright © 2019년 kimtruth. All rights reserved.
//

import UIKit

struct Video: Decodable {
  var thumbnailImageName: String
  var title: String
  var numberOfViews: Int
  var channel: Channel
}
