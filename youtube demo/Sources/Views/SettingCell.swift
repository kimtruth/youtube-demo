//
//  SettingCell.swift
//  youtube demo
//
//  Created by truth on 2019. 2. 6..
//  Copyright © 2019년 kimtruth. All rights reserved.
//

import UIKit

final class SettingCell: BaseCell {
  
  // MARK: UI
  
  private let nameLabel = UILabel().then {
    $0.text = "Setting"
  }
  private let iconImageView = UIImageView().then {
    $0.image = UIImage(named: "settings")
  }
  
  // MARK: Setups
  
  override func setupViews() {
    super.setupViews()
    
    self.backgroundColor = .lightGray
    self.addSubview(self.nameLabel)
    self.addSubview(self.iconImageView)
    
    
    self.nameLabel.snp.makeConstraints { (make) in
      make.left.equalTo(self.iconImageView.snp.right)
      make.top.right.bottom.equalToSuperview()
    }
    self.iconImageView.snp.makeConstraints { (make) in
      make.top.left.bottom.equalToSuperview()
      make.width.equalTo(self.iconImageView.snp.height)
    }
  }
}
