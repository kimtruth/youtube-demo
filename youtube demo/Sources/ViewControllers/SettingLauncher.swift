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
  
  private struct Constant {
    static let animationDuration = 0.3
  }
  
  // MARK: UI
  
  private let blackView = UIView().then {
    $0.alpha = 0
    $0.backgroundColor = UIColor(white: 0, alpha: 0.5)
  }
  
  func showSettings() {
    if let window = UIApplication.shared.keyWindow {
      window.addSubview(self.blackView)
      
      self.blackView.frame = window.frame
      
      let recognizer = UITapGestureRecognizer(target: self, action: #selector(self.blackViewDidTap))
      self.blackView.addGestureRecognizer(recognizer)
      
      UIView.animate(withDuration: Constant.animationDuration, delay: 0, options: .curveEaseIn, animations: {
        self.blackView.alpha = 1
      })
    }
  }
  
  // MARK: Actions
  
  @objc private func blackViewDidTap() {
    UIView.animate(withDuration: Constant.animationDuration, delay: 0, options: .curveEaseIn, animations: {
      self.blackView.alpha = 0
    }) { finished in
      self.blackView.removeFromSuperview()
    }
  }
}
