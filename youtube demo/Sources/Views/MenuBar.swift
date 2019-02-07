//
//  MenuBar.swift
//  youtube demo
//
//  Created by truth on 2019. 2. 2..
//  Copyright © 2019년 kimtruth. All rights reserved.
//

import UIKit

import SnapKit

final class MenuBar: UIView {
  
  // MARK: Properties
  
  private let cellId = "MenuCell"
  private let imageNames = ["home", "trending", "subscriptions", "account"]
  private var barLeftConstraint: Constraint?
  var homeController: HomeController?
  
  // MARK: Constants
  
  private struct Constant {
    static let animationDuration = 0.25
  }
  
  private struct Metric {
    static let horizontalBarViewHeight = 4.f
  }
  
  // MARK: UI
  
  private lazy var collectionView = UICollectionView(
    frame: .zero,
    collectionViewLayout: UICollectionViewFlowLayout()
  ).then {
    $0.backgroundColor = UIColor.rgb(red: 230, green: 32, blue: 31)
    $0.dataSource = self
    $0.delegate = self
  }
  private let horizontalBarView = UIView().then {
    $0.backgroundColor = UIColor(white: 0.95, alpha: 1)
  }
  
  // MARK: Initializing
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    self.setupCollectionView()
    self.setupHorizontalBarView()
    
    /// default page: home
    let selectedIndexPath = IndexPath(item: 0, section: 0)
    self.collectionView.selectItem(at: selectedIndexPath, animated: false, scrollPosition: .bottom)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: Setups
  
  private func setupCollectionView() {
    self.addSubview(self.collectionView)
    self.collectionView.register(MenuCell.self, forCellWithReuseIdentifier: self.cellId)
    self.collectionView.snp.makeConstraints { (make) in
      make.edges.equalToSuperview()
    }
  }
  
  private func setupHorizontalBarView() {
    self.addSubview(self.horizontalBarView)
    self.horizontalBarView.snp.makeConstraints { (make) in
      self.barLeftConstraint = make.left.equalToSuperview().constraint
      make.bottom.equalToSuperview()
      make.width.equalToSuperview().multipliedBy(1 / Float(self.imageNames.count))
      make.height.equalTo(Metric.horizontalBarViewHeight)
    }
  }
  
  // MARK: Actions
  
  func updateBarLeftConstraint(x: CGFloat) {
    self.barLeftConstraint?.update(offset: x)
  }
  
  func selectItemAt(indexPath: IndexPath) {
    self.collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .left)
  }
}

// MARK: - UICollectionViewDataSource

extension MenuBar: UICollectionViewDataSource {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return self.imageNames.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.cellId, for: indexPath) as! MenuCell
    let image = UIImage(named: self.imageNames[indexPath.item])
    cell.imageView.image = image?.withRenderingMode(.alwaysTemplate)
    
    return cell
  }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension MenuBar: UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return 0
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let width = self.frame.width / CGFloat(self.imageNames.count)
    return .init(width: width, height: self.frame.height)
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    self.homeController?.scrollToMenu(index: indexPath.item)
  }
}
