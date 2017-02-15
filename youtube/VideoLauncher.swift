//
//  VideoLauncher.swift
//  youtube
//
//  Created by Ihar Tsimafeichyk on 2/15/17.
//  Copyright © 2017 epam. All rights reserved.
//

import UIKit
import AVFoundation

class VideoPlayerView: UIView {

    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .black
        
        let urlString = "https://firebasestorage.googleapis.com/v0/b/gameofchats-762ca.appspot.com/o/message_movies%2F12323439-9729-4941-BA07-2BAE970967C7.mov?alt=media&token=3e37a093-3bc8-410f-84d3-38332af9c726"
        if let url = URL(string: urlString) {
         
            let player = AVPlayer(url: url)
            
            let playerlayer = AVPlayerLayer(player: player)
            self.layer.addSublayer(playerlayer)
            playerlayer.frame = self.frame
            
            player.play()
        }
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

class VideoLauncher: NSObject {
    
    func showVideoPlayer() {
        if let keyWindow = UIApplication.shared.keyWindow {
            let playerView = UIView()
            playerView.backgroundColor = UIColor.white
            
            playerView.frame  = CGRect(x: keyWindow.frame.width - 10 , y: keyWindow.frame.height - 10, width: 10, height: 10)
            
            keyWindow.addSubview(playerView)
            
            // 16 x 9 is the aspect ratio of all HD videos
            let height = keyWindow.frame.width * 9 / 16
            let videoPlayerView = VideoPlayerView(frame: CGRect(x: 0, y: 0, width: keyWindow.frame.width, height: height))
            playerView.addSubview(videoPlayerView)
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations:{
                
                playerView.frame = keyWindow.frame
                
            }, completion: { (completionAnimation) in
                    UIApplication.shared.setStatusBarHidden(true, with: .fade)
            
            })
            
        }
        
    }
}
