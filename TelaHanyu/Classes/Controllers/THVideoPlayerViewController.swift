//
//  THVideoPlayerViewController.swift
//  TelaHanyu
//
//  Created by victor on 1/26/20.
//  Copyright © 2020 Telabytes. All rights reserved.
//

import UIKit
import AVFoundation

public class THVideoPlayerViewController: UIViewController {

    public var videoUrlStr: String = ""
    private var player: AVPlayer?
    
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        
        guard let url = URL(string: self.videoUrlStr) else {
            print("The video url cannot be empty!")
            return
        }
        let playerItem = AVPlayerItem(url: url)
        self.player = AVPlayer(playerItem: playerItem)
        
        let playerLayer = AVPlayerLayer(player: self.player)
        playerLayer.frame = self.view.bounds
        playerLayer.videoGravity = .resizeAspect
        self.view.layer.addSublayer(playerLayer)
      
        //playerLayer.transform = CGAffineTransform(rotationAngle: -CGFloat.pi / 2.0)
        //playerLayer.frame = UIScreen.main.bounds
    }

}
