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
  
  // MARK: UI
  
  private let activityIndicatorView = UIActivityIndicatorView(style: .whiteLarge).then {
    $0.startAnimating()
  }
  
  private let controlsContainerView = UIView().then {
    $0.backgroundColor = UIColor(white: 0, alpha: 0.5)
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
    let player = AVPlayer(url: url)
    let playerLayer = AVPlayerLayer(player: player)
    
    self.layer.addSublayer(playerLayer)
    playerLayer.frame = self.frame
    
    player.play()
  }
  
  private func setupControls() {
    self.controlsContainerView.frame = self.frame
    self.addSubview(self.controlsContainerView)
    
    self.controlsContainerView.addSubview(self.activityIndicatorView)
    self.activityIndicatorView.snp.makeConstraints { (make) in
      make.centerX.centerY.equalToSuperview()
    }
  }
}
