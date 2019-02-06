//
//  SettingCell.swift
//  youtube demo
//
//  Created by truth on 2019. 2. 6..
//  Copyright © 2019년 kimtruth. All rights reserved.
//

import UIKit

final class SettingCell: BaseCell {
  
  // MARK: Properties
  
  override var isHighlighted: Bool {
    didSet {
      self.backgroundColor = self.isHighlighted ? .darkGray : .white
      self.nameLabel.textColor = self.isHighlighted ? .white : .black
      self.iconImageView.tintColor = self.isHighlighted ? .white : .darkGray
    }
  }
  
  // MARK: Constants
  
  private struct Font {
    static let nameLabel = UIFont.systemFont(ofSize: 13)
  }
  
  private struct Metric {
    static let iconImageViewInset = 8.f
  }
  
  // MARK: UI
  
  private let nameLabel = UILabel().then {
    $0.text = "Setting"
    $0.font = Font.nameLabel
  }
  private let iconImageView = UIImageView().then {
    $0.image = UIImage(named: "settings")
    $0.tintColor = .darkGray
  }
  
  // MARK: Setups
  
  override func setupViews() {
    super.setupViews()
    
    self.addSubview(self.nameLabel)
    self.addSubview(self.iconImageView)
    
    self.nameLabel.snp.makeConstraints { (make) in
      make.left.equalTo(self.iconImageView.snp.right).offset(Metric.iconImageViewInset)
      make.top.right.bottom.equalToSuperview()
    }
    self.iconImageView.snp.makeConstraints { (make) in
      make.top.left.bottom.equalToSuperview().inset(Metric.iconImageViewInset)
      make.width.equalTo(self.iconImageView.snp.height)
    }
  }
  
  // MARK: Configuring
  
  func configure(setting: Setting) {
    self.nameLabel.text = setting.name
    self.iconImageView.image = UIImage(named: setting.imageName)?.withRenderingMode(.alwaysTemplate)
  }
  
}
