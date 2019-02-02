//
//  HomeController.swift
//  youtube demo
//
//  Created by truth on 2019. 2. 2..
//  Copyright © 2019년 kimtruth. All rights reserved.
//

import UIKit

final class HomeController: UICollectionViewController {

  // MARK: Properties
  
  let cellId = "VideoCell"
  
  // MARK: View Life Cycles
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.collectionView.backgroundColor = .white
    self.collectionView.register(VideoCell.self, forCellWithReuseIdentifier: self.cellId)
  }

}

// MARK: - UICollectionViewDataSource

extension HomeController {
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 5
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.cellId, for: indexPath) as! VideoCell
    
    return cell
  }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension HomeController: UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return .init(width: self.view.frame.width, height: 200)
  }
}
