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

    public var videoCourseName: String = ""
    public var videoUrlStr: String = ""
    private var player: AVPlayer?
    
    private var isPlaying: Bool = true // 是否正在播放，默认就是开启了播放
    private var videoTotalSeconds: Float64 = 0
    
    private let pauseBtn = UIButton()  // 视频播放暂停按钮
    private let videoOverlayView = UIView()
    private let slider = UISlider()
    private let timeLabel = UILabel()
    private var periodicTimeObserver: Any?
    
    private var watchingVideoCourseTimer: Timer? // 记录用户观看视频的时长的Timer
    private var watchingVideoCourseTimerTotalSeconds: Int = 0 // 记录用户观看视频的时长
    
    public override var prefersStatusBarHidden: Bool {
        return true
    }

    
    override public func viewDidLoad() {
        super.viewDidLoad()
        //self.view.backgroundColor = UIColor.white
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        // 旋转当前控制器的视图90度
        //self.view.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi * 90.0 / 180.0))
        // 当前视图旋转90度
        self.view.layer.setAffineTransform(CGAffineTransform(rotationAngle: CGFloat(Double.pi * 90.0 / 180.0)))
        self.view.frame = UIScreen.main.bounds
        
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
        self.player?.play()
      
        self.createSubviews()
        
        let pauseVideoGesture = UITapGestureRecognizer(target: self, action: #selector(onClickHiddenOp))
        self.view.addGestureRecognizer(pauseVideoGesture)
        
        self.player?.currentItem?.addObserver(self, forKeyPath: "status", options: NSKeyValueObservingOptions.new, context: nil)
        self.player?.currentItem?.addObserver(self, forKeyPath: "loadedTimeRanges", options: NSKeyValueObservingOptions.new, context: nil)
        
        self.periodicTimeObserver = self.player?.addPeriodicTimeObserver(forInterval: CMTime(value: 1, timescale: 1), queue: DispatchQueue.main, using: { [weak self] (time) in
            let current = CMTimeGetSeconds(time)
            if let duration = self?.player?.currentItem?.duration {
                let total = CMTimeGetSeconds(duration)
                let rate = current / total
                self?.slider.setValue(Float(rate), animated: true)
                if let t = self?.secondsToHoursMinutesSeconds(Int(current)) {
                    var elapsedTime = "\(t.1)"
                    if t.1 < 10 {
                        elapsedTime = "0\(t.1)"
                    }
                    if t.2 < 10 {
                        elapsedTime = "\(elapsedTime):0\(t.2)"
                    } else {
                        elapsedTime = "\(elapsedTime):\(t.2)"
                    }
                    self?.timeLabel.text = String(format:"\(elapsedTime)/%.2f", total/60.0).replacingOccurrences(of: ".", with: ":")
                }
                //print("current=\(current)   \(current/60.0/2)    rate=\(rate)")
            }
        })
        
        // 即时用户把手机调成静音模式，也可以播放音频
        // https://stackoverflow.com/questions/35284722/how-can-i-detect-whether-an-ios-device-is-in-silent-mode-or-not
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            
        }
        
        // 计时：记录用户观看这个视频多久了
        self.watchingVideoCourseTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(recordUserWatchingVideoCourse), userInfo: nil, repeats: true)
        self.watchingVideoCourseTimer?.fire()
        
        NotificationCenter.default.addObserver(self, selector: #selector(appDidEnterBackground(_:)), name: NSNotification.Name(rawValue: kNotificationNameAppDidEnterBackground), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(appWillEnterForeground(_:)), name: NSNotification.Name(rawValue: kNotificationNameAppWillEnterForeground), object: nil)
    }
    
    @objc func recordUserWatchingVideoCourse() {
        self.watchingVideoCourseTimerTotalSeconds += 1
        print("当前：\(self.watchingVideoCourseTimerTotalSeconds)")
    }
    
    @objc func appDidEnterBackground(_ notification: Notification) {
        self.pauseVideo()
    }
    
    @objc func appWillEnterForeground(_ notification: Notification) {
        self.playVideo()
    }
    
    func secondsToHoursMinutesSeconds(_ seconds : Int) -> (Int, Int, Int) {
        return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
    }
    
    func createSubviews() {
        let videoOverlayViewGesture = UITapGestureRecognizer(target: self, action: #selector(onClickHiddenOp))
        self.videoOverlayView.addGestureRecognizer(videoOverlayViewGesture)
        self.view.addSubview(self.videoOverlayView)
        self.videoOverlayView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        let backBtn = UIButton()
        backBtn.addTarget(self, action: #selector(backToVC), for: .touchUpInside)
        backBtn.setImage(UIImage(named: "BackIcon"), for: .normal)
        backBtn.imageEdgeInsets = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        self.videoOverlayView.addSubview(backBtn)
        backBtn.snp.makeConstraints {
            $0.top.left.equalTo(0)
            $0.width.height.equalTo(70)
        }
        
        let bottomView = UIView()
        self.videoOverlayView.addSubview(bottomView)
        bottomView.snp.makeConstraints {
            $0.left.bottom.right.equalToSuperview()
            $0.height.equalTo(45)
        }
        
        let translucentBGView = UIView()
        translucentBGView.backgroundColor = UIColor.black
        translucentBGView.alpha = 0.8
        bottomView.addSubview(translucentBGView)
        translucentBGView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        self.pauseBtn.setImage(UIImage(named: "PauseIcon"), for: .normal)
        self.pauseBtn.addTarget(self, action: #selector(pauseVideoBtn), for: .touchUpInside)
        self.pauseBtn.imageEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        bottomView.addSubview(self.pauseBtn)
        self.pauseBtn.snp.makeConstraints {
            $0.top.left.bottom.equalTo(0)
            $0.width.equalTo(45)
        }
        
        self.slider.addTarget(self, action: #selector(onChangeSliderValue(_:)), for: .valueChanged)
        bottomView.addSubview(self.slider)
        self.slider.snp.makeConstraints {
            $0.top.equalTo(10)
            $0.left.equalTo(self.pauseBtn.snp.right).offset(15)
            $0.right.equalToSuperview().offset(-120)
            $0.height.equalTo(25)
        }
        
        self.timeLabel.text = "00:00/00:00"
        self.timeLabel.textColor = UIColor.white
        self.timeLabel.font = UIFont.systemFont(ofSize: 14)
        bottomView.addSubview(self.timeLabel)
        self.timeLabel.snp.makeConstraints {
            $0.top.equalTo(5)
            $0.left.equalTo(self.slider.snp.right).offset(10)
            $0.right.equalToSuperview().offset(-5)
            $0.height.equalTo(35)
        }
    }
    
    @objc func onChangeSliderValue(_ slider: UISlider) {
        self.pauseVideo() // 暂停播放
        let slidingToSeconds = self.videoTotalSeconds * Float64(slider.value)
        let seconds = CMTimeMakeWithSeconds(slidingToSeconds, preferredTimescale: Int32(NSEC_PER_SEC))
        self.player?.currentItem?.seek(to: seconds, completionHandler: { (finished) in
            if finished {
                self.playVideo() // 继续播放
            }
        })
    }
    
    @objc func onClickHiddenOp() {
        if self.videoOverlayView.alpha == 0.0 {
            self.videoOverlayView.alpha = 1.0
        } else {
            self.videoOverlayView.alpha = 0.0
        }
    }
    
    @objc func backToVC() {
        if self.watchingVideoCourseTimerTotalSeconds > 10 {
            // 当用户观看此视频找过10秒后，才记录起来
            let t = self.secondsToHoursMinutesSeconds(self.watchingVideoCourseTimerTotalSeconds)
            let userDefaults = UserDefaults.standard
            userDefaults.set("\(t.1):\(t.2)", forKey: self.videoCourseName)
            userDefaults.synchronize()
        }
        self.watchingVideoCourseTimer?.invalidate()
        self.watchingVideoCourseTimer = nil
        
        self.player?.pause()
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationController?.popViewController(animated: false)
    }
    
    @objc func pauseVideoBtn() {
        self.onPauseVideo()
    }
    
    @objc func onPauseVideo() {
        if self.isPlaying {
            self.pauseVideo()
        } else {
            self.playVideo()
        }
    }
    
    func pauseVideo() {
        self.isPlaying = false
        self.player?.pause()
        self.pauseBtn.setImage(UIImage(named: "PlayIcon"), for: .normal)
    }
    
    func playVideo() {
        self.isPlaying = true
        self.player?.play()
        self.pauseBtn.setImage(UIImage(named: "PauseIcon"), for: .normal)
    }
    
    public override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if let playerItem = object as? AVPlayerItem {
            if keyPath == "status" {
                if let newValue = change?[NSKeyValueChangeKey.newKey] as? Int {
                    if newValue == AVPlayer.Status.readyToPlay.rawValue {
                        let allSeconds = CMTimeGetSeconds(playerItem.duration)
                        //print("视频总时长：\(CMTimeGetSeconds(playerItem.duration))  \(allSeconds / 60)")
                        self.timeLabel.text = String(format:"00:00/%.2f", allSeconds / 60.0).replacingOccurrences(of: ".", with: ":")
                        self.videoTotalSeconds = allSeconds
                    }
                }
            } else if keyPath == "loadedTimeRanges" {
//                if let timeRangeValue = playerItem.loadedTimeRanges.first?.timeRangeValue {
//                    let startSeconds = CMTimeGetSeconds(timeRangeValue.start)
//                    let durationSeconds = CMTimeGetSeconds(timeRangeValue.duration)
//                    let totalBuffer = TimeInterval(startSeconds + durationSeconds)
//                    print("共缓冲：\(totalBuffer)")
//                }
            }
        }
    }
    
    func removeObserver() {
        if let o = self.periodicTimeObserver {
            self.player?.removeTimeObserver(o)
            self.periodicTimeObserver = nil
        }
        do {
            self.player?.currentItem?.removeObserver(self, forKeyPath: "status")
            self.player?.currentItem?.removeObserver(self, forKeyPath: "loadedTimeRanges")
        } catch {
            
        }
        self.player = nil
    }

    deinit {
        removeObserver()
        print("视频播放器被释放掉了")
        
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: kNotificationNameAppDidEnterBackground), object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: kNotificationNameAppWillEnterForeground), object: nil)
    }
}
