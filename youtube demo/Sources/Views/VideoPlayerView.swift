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
  
  // MARK: Initializing
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    self.backgroundColor = .black
    
    let urlString = "http://techslides.com/demos/sample-videos/small.mp4"
    
    guard let url = URL(string: urlString) else { return }
    let player = AVPlayer(url: url)
    let playerLayer = AVPlayerLayer(player: player)
    
    self.layer.addSublayer(playerLayer)
    playerLayer.frame = self.frame
    
    player.play()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
