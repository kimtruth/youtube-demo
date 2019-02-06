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
  private lazy var settingLauncher = SettingLauncher().then {
    $0.homeController = self
  }
  private var videos: [Video]?
  
  // MARK: UI
  
  private let redBackgroundView = UIView().then {
    $0.backgroundColor = UIColor.rgb(red: 230, green: 32, blue: 31)
  }
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
    
    self.navigationController?.hidesBarsOnSwipe = true
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
    self.view.addSubview(self.redBackgroundView)
    self.redBackgroundView.snp.makeConstraints { (make) in
      make.top.width.equalToSuperview()
      make.height.equalTo(Metric.menuBarHeight)
    }
    
    self.view.addSubview(self.menubar)
    self.menubar.snp.makeConstraints { (make) in
      make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
      make.width.equalToSuperview()
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
  
  func showController(setting: Setting) {
    let vc = UIViewController().then {
      $0.view.backgroundColor = .white
      $0.navigationItem.title = setting.name
    }
    self.navigationController?.navigationBar.tintColor = .white
    self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    self.navigationController?.pushViewController(vc, animated: true)
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
