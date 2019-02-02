//
//  Int+delimiter.swift
//  youtube demo
//
//  Created by truth on 2019. 2. 2..
//  Copyright © 2019년 kimtruth. All rights reserved.
//

import UIKit

extension Int {
  private static var numberFormatter = NumberFormatter().then {
    $0.numberStyle = .decimal
  }
  
  var delimiter: String {
    return Int.numberFormatter.string(from: NSNumber(value: self)) ?? ""
  }
}
