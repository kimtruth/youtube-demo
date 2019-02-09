//
//  VideoPlayerView.swift
//  youtube demo
//
//  Created by truth on 2019. 2. 9..
//  Copyright © 2019년 kimtruth. All rights reserved.
//

import UIKit
import AVFoundation

final class VideoPlayerView: UIView {
  
  // MARK: Properties
  
  private var player: AVPlayer?
  private var isPlaying = false
  
  // MARK: Constants
  
  private struct Metric {
    static let pauseButtonSize = 50.f
  }
  
  // MARK: UI
  
  private let activityIndicatorView = UIActivityIndicatorView(style: .whiteLarge).then {
    $0.startAnimating()
  }
  private let controlsContainerView = UIView().then {
    $0.backgroundColor = UIColor(white: 0, alpha: 0.5)
  }
  private lazy var controlButton = UIButton().then {
    $0.addTarget(self, action: #selector(self.controlButtonDidTap), for: .touchUpInside)
    $0.setImage(UIImage(named: "pause"), for: .normal)
    $0.tintColor = .white
    $0.isHidden = true
  }
  
  // MARK: Initializing
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    self.backgroundColor = .black
    
    self.setupPlayer()
    self.setupControls()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: Setups
  
  private func setupPlayer() {
    let urlString = "http://techslides.com/demos/sample-videos/small.mp4"
    guard let url = URL(string: urlString) else { return }
    
    self.player = AVPlayer(url: url)
    let playerLayer = AVPlayerLayer(player: player)
    playerLayer.frame = self.frame
    
    self.layer.addSublayer(playerLayer)
    self.player?.addObserver(self, forKeyPath: #keyPath(AVPlayer.currentItem.loadedTimeRanges), options: .new, context: nil)
    
    self.player?.play()
  }
  
  private func setupControls() {
    self.controlsContainerView.frame = self.frame
    self.controlsContainerView.addSubview(self.activityIndicatorView)
    
    self.addSubview(self.controlsContainerView)
    self.addSubview(self.controlButton)
    
    self.activityIndicatorView.snp.makeConstraints { (make) in
      make.centerX.centerY.equalToSuperview()
    }
    self.controlButton.snp.makeConstraints { (make) in
      make.width.height.equalTo(Metric.pauseButtonSize)
      make.centerX.centerY.equalToSuperview()
    }
  }
  
  // MARK: Actions
  
  @objc private func controlButtonDidTap() {
    if self.isPlaying {
      self.player?.pause()
      self.controlButton.setImage(UIImage(named: "play"), for: .normal)
    } else {
      self.player?.play()
      self.controlButton.setImage(UIImage(named: "pause"), for: .normal)
    }
    self.isPlaying = !self.isPlaying
  }
  
  // MARK: Observings
  
  override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
    
    if keyPath == #keyPath(AVPlayer.currentItem.loadedTimeRanges) {
      self.activityIndicatorView.stopAnimating()
      self.controlsContainerView.backgroundColor = .clear
      self.controlButton.isHidden = false
      self.isPlaying = true
    }
  }
}
