//
//  VideoCell.swift
//  youtube demo
//
//  Created by truth on 2019. 2. 2..
//  Copyright © 2019년 kimtruth. All rights reserved.
//

import UIKit

final class VideoCell: UICollectionViewCell {
  
  // MARK: UI
  
  private let thumbnailImageView = UIImageView().then {
    $0.backgroundColor = .blue
  }
  
  // MARK: Initializing
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.setupViews()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: Setups
  
  func setupViews() {
    self.addSubview(self.thumbnailImageView)
    
    self.thumbnailImageView.snp.makeConstraints { (make) in
      make.edges.equalToSuperview().inset(16)
    }
  }
}
