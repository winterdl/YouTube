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

    let activityIndicatorView: UIActivityIndicatorView = {
        let aiv = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        aiv.startAnimating()
        aiv.translatesAutoresizingMaskIntoConstraints = false
        return aiv
    }()
    
    let pausePlayButton: UIButton = {
        let pb = UIButton()
        pb.setImage(UIImage(named: "pause"), for: .normal)
        pb.translatesAutoresizingMaskIntoConstraints = false
        pb.tintColor = .white
        pb.isHidden = true
        pb.addTarget(self, action: #selector(handlePause), for: .touchUpInside)
        
        return pb
    }()

    var isPlaying = false
    
    func handlePause() {
        
        if isPlaying {
            player?.pause()
            pausePlayButton.setImage(UIImage(named: "play"), for: .normal)
        } else {
            player?.play()
            pausePlayButton.setImage(UIImage(named: "pause"), for: .normal)

        }
      
        isPlaying = !isPlaying
    }
    
    let controlsContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 1)
        return view
    }()
    
    let videoLengthLabel : UILabel = {
        let label = UILabel()
        label.text = "00:00"
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.textAlignment = .right
        return label
    }()
    
    let currenTimeLabel : UILabel = {
        let label = UILabel()
        label.text = "00:00"
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.textAlignment = .right
        return label
    }()
    
    let videoSlide: UISlider = {
        let slider = UISlider()
        
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.minimumTrackTintColor = .red
        slider.maximumTrackTintColor = .white
        slider.setThumbImage(UIImage(named: "thumb"), for: .normal)
        slider.addTarget(self, action: #selector(handleSliderChanged), for: .valueChanged)
        return slider
    }()
    
    
    func handleSliderChanged() {
    
        if let duration = player?.currentItem?.duration {
            let totalSeconds = CMTimeGetSeconds(duration)
        
            let value = Float64(videoSlide.value) * totalSeconds
        
            let seekTime = CMTime(value: Int64(value), timescale: 1)
                player?.seek(to: seekTime, completionHandler: {
                    (completedSeek) in
            
                })
        }
    
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupPlayerView()
        
        setupGradienLayer()
        
        controlsContainerView.frame = frame
        addSubview(controlsContainerView)
        

        addSubview(activityIndicatorView)
        activityIndicatorView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        activityIndicatorView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        controlsContainerView.addSubview(pausePlayButton)
        pausePlayButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        pausePlayButton.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        pausePlayButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        pausePlayButton.widthAnchor.constraint(equalToConstant: 50).isActive = true

        controlsContainerView.addSubview(videoLengthLabel)
        videoLengthLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -8).isActive = true
        videoLengthLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -2).isActive = true
        videoLengthLabel.widthAnchor.constraint(equalToConstant: 50).isActive = true
        videoLengthLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        controlsContainerView.addSubview(currenTimeLabel)
        currenTimeLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: -4).isActive = true
        currenTimeLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -2).isActive = true
        currenTimeLabel.widthAnchor.constraint(equalToConstant: 50).isActive = true
        currenTimeLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true

        controlsContainerView.addSubview(videoSlide)
        videoSlide.rightAnchor.constraint(equalTo: videoLengthLabel.leftAnchor).isActive = true
        videoSlide.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        videoSlide.leftAnchor.constraint(equalTo: currenTimeLabel.rightAnchor, constant: 8).isActive = true
        videoSlide.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        backgroundColor = .black

    }
    
    func setupGradienLayer() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradientLayer.locations = [0.7, 1.2]
        
        
        controlsContainerView.layer.addSublayer(gradientLayer)
    }
    
    var player: AVPlayer?
    
    func setupPlayerView () {
        let urlString = "https://firebasestorage.googleapis.com/v0/b/gameofchats-762ca.appspot.com/o/message_movies%2F12323439-9729-4941-BA07-2BAE970967C7.mov?alt=media&token=3e37a093-3bc8-410f-84d3-38332af9c726"
        if let url = URL(string: urlString) {
            
            player = AVPlayer(url: url)
            
            let playerlayer = AVPlayerLayer(player: player)
            self.layer.addSublayer(playerlayer)
            playerlayer.frame = self.frame
            
            player?.play()
            
            player?.addObserver(self, forKeyPath: "currentItem.loadedTimeRanges", options: .new, context: nil)
            
            // track player progress
            
            let interval = CMTime(value: 1, timescale: 2)
            
            player?.addPeriodicTimeObserver(forInterval: interval, queue: DispatchQueue.main, using: {
                (progressTime) in
                    let seconds = CMTimeGetSeconds(progressTime)
                    let secondsString = String(format: "%02d", Int(seconds) % 60)
                    let minutesString = String(format: "%02d", Int(seconds) / 60)
                    self.currenTimeLabel.text = "\(minutesString):\(secondsString)"
                
                // move the slider thumb
                if let duration = self.player?.currentItem?.duration {
                    let durationSeconds = CMTimeGetSeconds(duration)

                    self.videoSlide.value = Float(seconds / durationSeconds)
                }
                
            })
            
        }
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "currentItem.loadedTimeRanges" {
            activityIndicatorView.stopAnimating()
            controlsContainerView.backgroundColor = .clear
            pausePlayButton.isHidden = false
            isPlaying = true
            
            if let duration = player?.currentItem?.duration {
                let seconds = CMTimeGetSeconds(duration)
                
                let secondsText = Int(seconds) % 60
                let minutesText = String(format: "%02d", Int(seconds) / 60) // this line will give 00:
                
                videoLengthLabel.text = "\(minutesText):\(secondsText)"
            }
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
