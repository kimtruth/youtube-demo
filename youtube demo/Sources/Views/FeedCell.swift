//
//  FeedCell.swift
//  youtube demo
//
//  Created by truth on 2019. 2. 7..
//  Copyright © 2019년 kimtruth. All rights reserved.
//

import UIKit

final class FeedCell: BaseCell {
  
  // MARK: Properties
  
  private let cellId = "VideoCell"
  private var videos: [Video]?
  
  // MARK: Constants
  
  private struct Metric {
    static let menuBarHeight = 50.f
  }
  
  // MARK: UI
  
  private let collectionView = UICollectionView(
    frame: .zero,
    collectionViewLayout: UICollectionViewFlowLayout()
  ).then {
    $0.backgroundColor = .white
  }
  
  // MARK: Setups
  
  override func setupViews() {
    super.setupViews()
    
    self.collectionView.dataSource = self
    self.collectionView.delegate = self
    
    self.setupCollectionView()
  }
  
  private func setupCollectionView() {
    self.addSubview(self.collectionView)
    self.collectionView.snp.makeConstraints { (make) in
      make.edges.equalToSuperview()
    }
    
    self.collectionView.backgroundColor = .white
    self.collectionView.register(VideoCell.self, forCellWithReuseIdentifier: self.cellId)
    self.collectionView.contentInset = .init(top: Metric.menuBarHeight, left: 0, bottom: 0, right: 0)
    self.collectionView.scrollIndicatorInsets = .init(top: Metric.menuBarHeight, left: 0, bottom: 0, right: 0)
  }
  
  // MARK: Networking
  
  private func fetchVideos(page: Feed) {
    FeedService.feed(page: page) { [weak self] videos in
      guard let `self` = self else { return }
      
      self.videos = videos
      self.collectionView.reloadData()
    }
  }
  
  // MARK: Configuring
  
  func configure(page: Feed) {
    self.fetchVideos(page: page)
  }
}

// MARK: - UICollectionViewDataSource

extension FeedCell: UICollectionViewDataSource {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return self.videos?.count ?? 0
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.cellId, for: indexPath) as! VideoCell
    if let video = self.videos?[indexPath.item] {
      cell.configure(video: video)
    }
    return cell
  }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension FeedCell: UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
    return VideoCell.size(width: self.frame.width, title: "Taylor Swift - Blank Space")
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let videoLauncher = VideoLauncher()
    videoLauncher.showVideoPlayer()
  }
}
