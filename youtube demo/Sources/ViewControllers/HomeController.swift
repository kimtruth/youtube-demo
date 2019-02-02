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
  
  // MARK: Constants
  
  private struct Font {
    static let titleLabel = UIFont.boldSystemFont(ofSize: 20)
  }
  
  // MARK: View Life Cycles
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.setupNavBar()
    self.setupCollectionView()
  }
  
  // MARK: Setups
  
  private func setupNavBar() {
    let title = "Home"
    self.navigationItem.title = title
    
    let titleLabel = UILabel().then {
      $0.font = Font.titleLabel
      $0.frame = .init(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height)
      $0.text = title
      $0.textColor = .white
    }
    self.navigationItem.titleView = titleLabel
  }
  
  private func setupCollectionView() {
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
    
    return VideoCell.size(width: self.view.frame.width, title: "Taylor Swift - Blank Space")
  }
}
