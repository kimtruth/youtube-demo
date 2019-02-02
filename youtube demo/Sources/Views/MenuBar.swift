//
//  MenuBar.swift
//  youtube demo
//
//  Created by truth on 2019. 2. 2..
//  Copyright © 2019년 kimtruth. All rights reserved.
//

import UIKit

final class MenuBar: UIView {
  
  // MARK: Properties
  
  private let cellId = "MenuCell"
  
  // MARK: UI
  
  private lazy var collectionView = UICollectionView(
    frame: .zero,
    collectionViewLayout: UICollectionViewFlowLayout()
  ).then {
    $0.backgroundColor = UIColor.rgb(red: 230, green: 32, blue: 31)
    $0.dataSource = self
    $0.delegate = self
  }
  
  // MARK: View Life Cycles
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    self.addSubview(self.collectionView)
    self.collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: self.cellId)
    self.collectionView.snp.makeConstraints { (make) in
      make.edges.equalToSuperview()
    }
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}

// MARK: - UICollectionViewDataSource

extension MenuBar: UICollectionViewDataSource {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 4
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.cellId, for: indexPath)
    cell.backgroundColor = .white
    
    return cell
  }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension MenuBar: UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return 0
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return .init(width: self.frame.width / 4, height: self.frame.height)
  }
}
