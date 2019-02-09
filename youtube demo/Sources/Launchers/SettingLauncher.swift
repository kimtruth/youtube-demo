//
//  SettingLauncher.swift
//  youtube demo
//
//  Created by truth on 2019. 2. 2..
//  Copyright © 2019년 kimtruth. All rights reserved.
//

import UIKit

final class SettingLauncher: NSObject {
  
  // MARK: Properties
  
  var homeController: HomeController?
  private let cellId = "SettingCell"
  private let settings = [
    Setting(name: "Settings", imageName: "settings"),
    Setting(name: "Terms & privacy policy", imageName: "privacy"),
    Setting(name: "Send Feedback", imageName: "feedback"),
    Setting(name: "Help", imageName: "help"),
    Setting(name: "Switch Account", imageName: "switch_account"),
    Setting(name: "Cancel", imageName: "cancel"),
  ]
  
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
  
  // MARK: Initializing
  
  override init() {
    super.init()
    
    self.collectionView.delegate = self
    self.collectionView.dataSource = self
    
    self.collectionView.register(SettingCell.self, forCellWithReuseIdentifier: self.cellId)
  }
  
  func showSettings() {
    guard let window = UIApplication.shared.keyWindow else { return }
    window.addSubview(self.blackView)
    window.addSubview(self.collectionView)
    
    self.blackView.frame = window.frame
    
    let recognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismiss))
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
  
  @objc private func dismiss(completion: (()-> Void)? = nil) {
    UIView.animate(withDuration: Constant.animationDuration, delay: 0, options: .curveEaseIn, animations: {
      self.blackView.alpha = 0
      var frame = self.collectionView.frame
      frame.origin.y += self.collectionView.frame.height
      self.collectionView.frame = frame
    }) { finished in
      self.blackView.removeFromSuperview()
      self.collectionView.removeFromSuperview()
      
      completion?()
    }
  }
}

// MARK: - UICollectionViewDataSource

extension SettingLauncher: UICollectionViewDataSource {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return self.settings.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.cellId, for: indexPath) as! SettingCell
    let setting = self.settings[indexPath.item]
    
    cell.configure(setting: setting)
    
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let setting = self.settings[indexPath.item]
    self.dismiss {
      // execute if not a cancel cell
      if indexPath.item + 1 != self.settings.count {
        self.homeController?.showController(setting: setting)
      }
    }
  }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension SettingLauncher: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let height = Metric.collectionViewHeight / CGFloat(self.settings.count)
    
    return .init(width: self.collectionView.frame.width, height: height)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 0
  }
}
