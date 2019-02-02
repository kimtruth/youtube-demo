//
//  String+BoundingRect.swift
//  youtube demo
//
//  Created by truth on 2019. 2. 2..
//  Copyright © 2019년 kimtruth. All rights reserved.
//

import UIKit

extension String {
  
  func size(width: CGFloat, font: UIFont, numberOfLines: Int = 0) -> CGSize {
    let maximumHeight = numberOfLines == 0
      ? CGFloat.greatestFiniteMagnitude
      : font.lineHeight * CGFloat(numberOfLines)
    let constraintSize = CGSize(width: width, height: maximumHeight)
    let options: NSStringDrawingOptions = [.usesFontLeading, .usesLineFragmentOrigin]
    let attributes = [NSAttributedString.Key.font: font]
    let boundingRect = self.boundingRect(
      with: constraintSize,
      options: options,
      attributes: attributes,
      context: nil
    )
    return .init(width: ceil(boundingRect.width), height: ceil(boundingRect.height))
  }
}
