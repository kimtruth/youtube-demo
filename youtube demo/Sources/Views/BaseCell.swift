//
//  BaseCell.swift
//  youtube demo
//
//  Created by truth on 2019. 2. 2..
//  Copyright © 2019년 kimtruth. All rights reserved.
//

import UIKit

class BaseCell: UICollectionViewCell {
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.setupViews()
  }
  
  func setupViews() {
    
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
