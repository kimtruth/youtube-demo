//
//  VideoLauncher.swift
//  youtube demo
//
//  Created by truth on 2019. 2. 9..
//  Copyright © 2019년 kimtruth. All rights reserved.
//

import UIKit

final class VideoLauncher {
  
  func showVideoPlayer() {
    guard let window = UIApplication.shared.keyWindow else { return }
    
    let view = UIView().then {
      $0.backgroundColor = .white
      $0.frame = .init(x: window.frame.width - 10, y: window.frame.height - 10, width: 10, height: 10)
    }
    
    let playerView = VideoPlayerView()
    let height = window.frame.width * 9 / 16
    playerView.frame = .init(x: 0, y: 0, width: window.frame.width, height: height)
    
    view.addSubview(playerView)
    
    window.addSubview(view)
    
    UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
      view.frame = window.frame
      UIApplication.shared.isStatusBarHidden = true
    })
  }
}
