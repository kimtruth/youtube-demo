//
//  MenuCell.swift
//  youtube demo
//
//  Created by truth on 2019. 2. 2..
//  Copyright © 2019년 kimtruth. All rights reserved.
//

import UIKit

final class MenuCell: BaseCell {
  
  // MARK: Properties
  
  override var isHighlighted: Bool {
    didSet {
      self.imageView.tintColor = isHighlighted ? Color.imageViewHighlightTint : Color.imageViewDefaultTint
    }
  }
  override var isSelected: Bool {
    didSet {
      self.imageView.tintColor = isSelected ? Color.imageViewHighlightTint : Color.imageViewDefaultTint
    }
  }
  
  // MARK: Constants
  
  private struct Color {
    static let imageViewDefaultTint = UIColor.rgb(red: 91, green: 14, blue: 13)
    static let imageViewHighlightTint = UIColor.white
  }
  
  private struct Metric {
    static let imageViewSize = 28.f
  }
  
  // MARK: UI
  
  let imageView = UIImageView().then {
    $0.tintColor = Color.imageViewDefaultTint
  }
  
  // MARK: Setups
  
  override func setupViews() {
    super.setupViews()
    
    self.addSubview(self.imageView)
    self.imageView.snp.makeConstraints { (make) in
      make.centerX.centerY.equalToSuperview()
      make.width.height.equalTo(Metric.imageViewSize)
    }
  }
}
