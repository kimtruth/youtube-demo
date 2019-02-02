//
//  SettingLauncher.swift
//  youtube demo
//
//  Created by truth on 2019. 2. 2..
//  Copyright © 2019년 kimtruth. All rights reserved.
//

import UIKit

final class SettingLauncher {
  
  // MARK: Constants
  
  private struct Metric {
    static let collectionViewHeight = 300.f
  }
  private struct Constant {
    static let animationDuration = 0.2
  }
  
  // MARK: UI
  
  private let blackView = UIView().then {
    $0.alpha = 0
    $0.backgroundColor = UIColor(white: 0, alpha: 0.5)
  }
  private let collectionView = UICollectionView(
    frame: .zero,
    collectionViewLayout: UICollectionViewFlowLayout()
  ).then {
      $0.backgroundColor = .white
  }
  
  func showSettings() {
    guard let window = UIApplication.shared.keyWindow else { return }
    window.addSubview(self.blackView)
    window.addSubview(self.collectionView)
    
    self.blackView.frame = window.frame
    
    let recognizer = UITapGestureRecognizer(target: self, action: #selector(self.blackViewDidTap))
    self.blackView.addGestureRecognizer(recognizer)
    
    self.collectionView.frame = .init(
      x: 0,
      y: window.frame.height,
      width: window.frame.width,
      height: Metric.collectionViewHeight
    )
    
    UIView.animate(withDuration: Constant.animationDuration, delay: 0, options: .curveEaseIn, animations: {
      self.blackView.alpha = 1
      var frame = self.collectionView.frame
      frame.origin.y -= self.collectionView.frame.height
      self.collectionView.frame = frame
    })
  }
  
  // MARK: Actions
  
  @objc private func blackViewDidTap() {
    UIView.animate(withDuration: Constant.animationDuration, delay: 0, options: .curveEaseIn, animations: {
      self.blackView.alpha = 0
      var frame = self.collectionView.frame
      frame.origin.y += self.collectionView.frame.height
      self.collectionView.frame = frame
    }) { finished in
      self.blackView.removeFromSuperview()
      self.collectionView.removeFromSuperview()
    }
  }
}
