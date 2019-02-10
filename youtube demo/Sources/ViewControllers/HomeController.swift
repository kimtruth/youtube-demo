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
  
  private let cellId = "FeedCell"
  private let titles = ["Home", "Trending", "Subscriptions", "Account"]
  private lazy var settingLauncher = SettingLauncher().then {
    $0.homeController = self
  }
  private var videos: [Video]?
  
  // MARK: UI
  
  private let redBackgroundView = UIView().then {
    $0.backgroundColor = UIColor.rgb(red: 230, green: 32, blue: 31)
  }
  private lazy var menubar = MenuBar().then {
    $0.homeController = self
  }
  
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
      make.left.right.equalToSuperview()
      make.height.equalTo(Metric.menuBarHeight)
    }
  }
  
  private func setupCollectionView() {
    if let layout = self.collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
      layout.scrollDirection = .horizontal
    }
    self.collectionView.isPagingEnabled = true
    self.collectionView.backgroundColor = .white
    self.collectionView.register(FeedCell.self, forCellWithReuseIdentifier: self.cellId)
  }
  
  private func setTitleFor(index: Int) {
    guard let titleLabel = self.navigationItem.titleView as? UILabel else { return }
    
    titleLabel.text = self.titles[index]
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
  
  func scrollToMenu(index: Int) {
    let indexPath = IndexPath(item: index, section: 0)
    
    self.setTitleFor(index: index)
    self.collectionView.scrollToItem(at: indexPath, at: .left, animated: true)
  }
  
}

// MARK: - UIScrollViewDelegate

extension HomeController {
  
  override func scrollViewDidScroll(_ scrollView: UIScrollView) {
    let x = scrollView.contentOffset.x / CGFloat(self.titles.count)
    self.menubar.updateBarLeftConstraint(x: x)
  }
  
  override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
    let index = Int(targetContentOffset.pointee.x / self.view.frame.width)
    let indexPath = IndexPath(item: index, section: 0)
    
    self.setTitleFor(index: index)
    self.menubar.selectItemAt(indexPath: indexPath)
  }
}

// MARK: - UICollectionViewDataSource

extension HomeController {
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return self.titles.count
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.cellId, for: indexPath) as! FeedCell
    
    if indexPath.item == 0 {
      cell.configure(page: .home)
    }
    else if indexPath.item == 1 {
      cell.configure(page: .trending)
    }
    else if indexPath.item == 2 {
      cell.configure(page: .subscriptions)
    }
    
    return cell
  }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension HomeController: UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return .init(width: self.view.frame.width, height: self.view.frame.height)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 0
  }
}
