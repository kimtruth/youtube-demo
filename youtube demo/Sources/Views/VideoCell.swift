//
//  VideoCell.swift
//  youtube demo
//
//  Created by truth on 2019. 2. 2..
//  Copyright © 2019년 kimtruth. All rights reserved.
//

import UIKit

final class VideoCell: UICollectionViewCell {
  
  // MARK: Cosntants
  
  private struct Metric {
    static let thumbnailImageViewMargin = 16.f
    
    static let userProfileImageViewTop = 8.f
    static let userProfileImageViewLeftBottom = 16.f
    static let userProfileImageViewSize = 44.f
    
    static let titleLabelLeft = 8.f
    static let titleLabelTop = 8.f
    static let titleLabelHeight = 20.f
    
    static let subtitleTextViewTop = 8.f
    static let subtitleTextViewHeight = 30.f
    static let subtitleTextViewBottom = 8.f
  }
  
  private struct Constant {
    static let videoRatio = 9.0 / 16
  }
  
  // MARK: UI
  
  private let thumbnailImageView = UIImageView().then {
    $0.image = UIImage(named: "taylor_swift_blank_space")
    $0.backgroundColor = .blue
    $0.contentMode = .scaleAspectFill
  }
  private let userProfileImageView = UIImageView().then {
    $0.image = UIImage(named: "taylor_swift_profile")
    $0.backgroundColor = .green
    $0.contentMode = .scaleAspectFill
  }
  private let titleLabel = UILabel().then {
    $0.text = "Taylor Swift - Blank Space"
  }
  private let subtitleTextView = UITextView().then {
    $0.text = "TaylorSwiftVEVO • 1,604,684,607 views • 2 years"
    $0.textColor = .lightGray
    $0.textContainer.lineFragmentPadding = 0
    $0.textContainerInset = .init(top: 0, left: 0, bottom: 0, right: 0)
  }
  private let separatorView = UIView().then {
    $0.backgroundColor = .gray
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
    self.addSubview(self.userProfileImageView)
    self.addSubview(self.titleLabel)
    self.addSubview(self.subtitleTextView)
    self.addSubview(self.separatorView)
    
    self.thumbnailImageView.snp.makeConstraints { (make) in
      make.top.left.right.equalToSuperview().inset(Metric.thumbnailImageViewMargin)
      make.height.equalTo(self.thumbnailImageView.snp.width).multipliedBy(Constant.videoRatio)
    }
    self.userProfileImageView.snp.makeConstraints { (make) in
      make.top.equalTo(self.thumbnailImageView.snp.bottom).offset(Metric.userProfileImageViewTop)
      make.left.equalToSuperview().inset(Metric.userProfileImageViewLeftBottom)
      make.width.height.equalTo(Metric.userProfileImageViewSize)
    }
    self.titleLabel.snp.makeConstraints { (make) in
      make.top.equalTo(self.thumbnailImageView.snp.bottom).offset(Metric.titleLabelTop)
      make.left.equalTo(self.userProfileImageView.snp.right).offset(Metric.titleLabelLeft)
      make.right.equalTo(self.thumbnailImageView.snp.right)
    }
    self.subtitleTextView.snp.makeConstraints { (make) in
      make.top.equalTo(self.titleLabel.snp.bottom).offset(Metric.subtitleTextViewTop)
      make.left.equalTo(self.titleLabel.snp.left)
      make.right.equalTo(self.thumbnailImageView.snp.right)
      make.bottom.equalToSuperview().offset(-Metric.subtitleTextViewBottom)
    }
    self.separatorView.snp.makeConstraints { (make) in
      make.left.right.bottom.equalToSuperview()
      make.height.equalTo(1)
    }
  }
}
