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
  
  private let cellId = "VideoCell"
  private let settingLauncher = SettingLauncher()
  private var videos: [Video]?
  
  // MARK: UI
  
  private let menubar = MenuBar()
  
  // MARK: Constants
  
  private struct Font {
    static let titleLabel = UIFont.boldSystemFont(ofSize: 20)
  }
  
  private struct Metric {
    static let menuBarHeight = 50.f
  }
  
  // MARK: View Life Cycles
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.fetchVideos()
    
    self.setupNavBar()
    self.setupNavBarButtons()
    self.setupMenuBar()
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
  
  private func setupNavBarButtons() {
    let searchImage =  UIImage(named: "search_icon")?.withRenderingMode(.alwaysOriginal)
    let searchButtonItem = UIBarButtonItem(
      image: searchImage,
      style: .plain,
      target: self,
      action: #selector(self.searchButtonDidTap)
    )
    
    let moreImage =  UIImage(named: "nav_more_icon")?.withRenderingMode(.alwaysOriginal)
    let moreButtonItem = UIBarButtonItem(
      image: moreImage,
      style: .plain,
      target: self,
      action: #selector(self.moreButtonDidTap)
    )
    
    self.navigationItem.rightBarButtonItems = [moreButtonItem, searchButtonItem]
  }
  
  private func setupMenuBar() {
    self.view.addSubview(self.menubar)
    self.menubar.snp.makeConstraints { (make) in
      make.top.width.equalToSuperview()
      make.height.equalTo(Metric.menuBarHeight)
    }
  }
  
  private func setupCollectionView() {
    self.collectionView.backgroundColor = .white
    self.collectionView.register(VideoCell.self, forCellWithReuseIdentifier: self.cellId)
    self.collectionView.contentInset = .init(top: Metric.menuBarHeight, left: 0, bottom: 0, right: 0)
    self.collectionView.scrollIndicatorInsets = .init(top: Metric.menuBarHeight, left: 0, bottom: 0, right: 0)
  }
  
  // MARK: Networking
  
  private func fetchVideos() {
    let urlString = "https://s3-us-west-2.amazonaws.com/youtubeassets/home.json"
    guard let url = URL(string: urlString) else { return }
    
    URLSession.shared.dataTask(with: url) { (data, res, err) in
      guard let data = data else { return }
      
      let decoder = JSONDecoder()
      decoder.keyDecodingStrategy = .convertFromSnakeCase
      do {
        let videos = try decoder.decode([Video].self, from: data)
        print(videos)
        
        self.videos = videos
        DispatchQueue.main.async {
          self.collectionView.reloadData()
        }
      } catch let jsonErr {
        print("json decode error:", jsonErr)
      }
    }.resume()
  }

  // MARK: Actions
  
  @objc private func searchButtonDidTap() {
  }
  
  @objc private func moreButtonDidTap() {
    self.settingLauncher.showSettings()
  }
  
}

// MARK: - UICollectionViewDataSource

extension HomeController {
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return self.videos?.count ?? 0
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.cellId, for: indexPath) as! VideoCell
    if let video = self.videos?[indexPath.item] {
      cell.configure(video: video)
    }
    return cell
  }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension HomeController: UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
    return VideoCell.size(width: self.view.frame.width, title: "Taylor Swift - Blank Space")
  }
}
