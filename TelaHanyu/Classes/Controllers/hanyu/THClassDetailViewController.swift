//
//  THClassDetailViewController.swift
//  TelaHanyu
//
//  Created by victor on 1/26/20.
//  Copyright © 2020 Telabytes. All rights reserved.
//  课程详情页面
//

import UIKit
import SnapKit

class THClassDetailViewController: UIViewController {
    
    // 课程索引
    public var classIndex: Int = 0
    // 课程封面图URL
    public var classCoverUrl: String = ""
    // 课程标题
    public var classCourseTitle: String = ""
    
    private let tableView: UITableView = UITableView(frame: CGRect(), style: .plain)
    private let dataList = [
        ["汉语综合教学-课时1", "汉语综合教学-课时2", "汉语综合教学-课时3",
         "汉语综合教学-课时4", "汉语综合教学-课时5", "汉语综合教学-课时6",
         "汉语综合教学-课时7", "汉语综合教学-课时8", "汉语综合教学-课时9", "汉语综合教学-课时10"],
        
        ["基础知识—词汇-课时1","基础知识—词汇-课时2","基础知识—词汇-课时3",
         "基础知识—词汇-课时4","基础知识—词汇-课时5","基础知识—词汇-课时6"],
        
        ["基础知识—词语法-课时1","基础知识—词语法-课时2","基础知识—词语法-课时3",
         "基础知识—词语法-课时4","基础知识—词语法-课时5","基础知识—词语法-课时6",
         "基础知识—词语法-课时7","基础知识—词语法-课时8","基础知识—词语法-课时9"],
        
        ["基础知识—文字-课时1","基础知识—文字-课时2","基础知识—文字-课时3",
         "基础知识—文字-课时4","基础知识—文字-课时5","基础知识—文字-课时6"],
        
        ["基础知识—语音-课时1","基础知识—语音-课时2","基础知识—语音-课时3",
         "基础知识—语音-课时4","基础知识—语音-课时5","基础知识—语音-课时6",
         "基础知识—语音-课时7","基础知识—语音-课时8","基础知识—语音-课时9",
         "基础知识—语音-课时10","基础知识—语音-课时11"],
        
        ["京师教师资格跨文化交际案例分析课时1","京师教师资格跨文化交际案例分析课时2","京师教师资格跨文化交际案例分析课时3",
         "京师教师资格跨文化交际案例分析课时4","京师教师资格跨文化交际案例分析课时5","京师教师资格跨文化交际案例分析课时6",
         "京师教师资格跨文化交际案例分析课时7","京师教师资格跨文化交际案例分析课时8","京师教师资格跨文化交际案例分析课时9",
         "京师教师资格跨文化交际案例分析课时10","京师教师资格跨文化交际案例分析课时11","京师教师资格跨文化交际案例分析课时12",
         "京师教师资格跨文化交际案例分析课时13"],
        
        ["中华文化及其传播课时1","中华文化及其传播课时2","中华文化及其传播课时3",
         "中华文化及其传播课时4","中华文化及其传播课时5","中华文化及其传播课时6"],
        
        ["汉办-国际汉语教师证书-面试01","汉办-国际汉语教师证书-面试02","汉办-国际汉语教师证书-面试03",
         "汉办-国际汉语教师证书-面试04","汉办-国际汉语教师证书-面试05","汉办-国际汉语教师证书-面试06"]
    ]
    
    private let courseIntroMenuLabel = UILabel()
    private let courseCatalogueLabel = UILabel()
    private let courseIntroDetailLabel = UILabel()
    private let bottomActiveLine = UIView()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = self.classCourseTitle
        self.view.backgroundColor = UIColor.white
        self.navigationItem.backBarButtonItem = UIBarButtonItem()
        
        let viewWidth = UIScreen.main.bounds.size.width
        //let viewHeight = UIScreen.main.bounds.size.height
        
        let classImgView = UIImageView()
        if let url1 = URL(string: self.classCoverUrl) {
            classImgView.yy_setImage(with: url1, placeholder: UIImage(), options: .progressiveBlur, completion: nil)
        }
        classImgView.isUserInteractionEnabled = true
        classImgView.contentMode = .scaleToFill
//        let leftItemImgViewGesture = UITapGestureRecognizer(target: self, action: #selector(openClass0))
//        leftItemImgView.addGestureRecognizer(leftItemImgViewGesture)
        self.view.addSubview(classImgView)
        classImgView.snp.makeConstraints {
            if #available(iOS 11.0, *) {
                $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            } else {
                // Fallback on earlier versions
                $0.top.equalToSuperview()
            }
            $0.left.right.equalToSuperview()
            $0.height.equalTo(viewWidth * 0.6)
        }
        
        let playImgView = UIImageView(image: UIImage(named: "PlayIcon"))
        playImgView.isUserInteractionEnabled = true
        playImgView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(playCourseVideoEvent)))
        classImgView.addSubview(playImgView)
        playImgView.snp.makeConstraints {
            $0.width.height.equalTo(60)
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        
        let courseDetailView = UIView()
        self.view.addSubview(courseDetailView)
        courseDetailView.snp.makeConstraints {
            $0.top.equalTo(classImgView.snp.bottom)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(50)
        }
        
        self.courseIntroMenuLabel.textColor = UIColor(rgb: 0x161F39)
        self.courseIntroMenuLabel.font = UIFont.boldSystemFont(ofSize: 20)
        self.courseIntroMenuLabel.text = "课程详情"
        self.courseIntroMenuLabel.textAlignment = .center
        self.courseIntroMenuLabel.isUserInteractionEnabled = true
        let courseIntroGesture = UITapGestureRecognizer(target: self, action: #selector(switchToCourseIntro))
        self.courseIntroMenuLabel.addGestureRecognizer(courseIntroGesture)
        courseDetailView.addSubview(self.courseIntroMenuLabel)
        self.courseIntroMenuLabel.snp.makeConstraints {
            $0.top.equalTo(0)
            $0.left.equalTo(20)
            $0.width.equalToSuperview().dividedBy(2)
            $0.height.equalTo(50)
        }
        
        let middleLine = UIView()
        middleLine.backgroundColor = UIColor(red: 21, green: 126, blue: 251)
        courseDetailView.addSubview(middleLine)
        middleLine.snp.makeConstraints {
            $0.top.equalTo(10)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(1)
            $0.height.equalTo(30)
        }
        
        self.courseCatalogueLabel.textColor = UIColor(rgb: 0x161F39)
        self.courseCatalogueLabel.font = UIFont.boldSystemFont(ofSize: 20)
        self.courseCatalogueLabel.text = "课程目录"
        self.courseCatalogueLabel.textAlignment = .center
        self.courseCatalogueLabel.isUserInteractionEnabled = true
        let courseCatalogueGesture = UITapGestureRecognizer(target: self, action: #selector(switchToCourseCatalog))
        self.courseCatalogueLabel.addGestureRecognizer(courseCatalogueGesture)
        courseDetailView.addSubview(self.courseCatalogueLabel)
        self.courseCatalogueLabel.snp.makeConstraints {
            $0.top.equalTo(0)
            $0.right.equalTo(-20)
            $0.width.equalToSuperview().dividedBy(2)
            $0.height.equalTo(50)
        }
        
        self.bottomActiveLine.backgroundColor = UIColor(red: 21, green: 126, blue: 251)
        courseDetailView.addSubview(self.bottomActiveLine)
        self.bottomActiveLine.snp.makeConstraints {
            $0.top.equalTo(48.5)
            $0.left.equalTo(0)
            $0.width.equalTo(self.view.bounds.size.width/2)
            $0.height.equalTo(1.5)
        }
        
        self.courseIntroDetailLabel.textColor = UIColor.gray
        self.courseIntroDetailLabel.font = UIFont.systemFont(ofSize: 18)
        self.courseIntroDetailLabel.text = "国际汉语教师考试命题依据考试标准和考试大纲，主要考查申请人从事教师职业应具备的职业道德、心理素养和教育教学能力。突出专业导向、能力导向和实践导向。 \r\n\r\n1、专职教研队伍，深入研究试题命题规律，对考点进行考频分析，判断趋势重点 \r\n\r\n2、结合多方信息及自身经验，全面、深入分析考题方向，提供准确的前沿信息。"
        self.courseIntroDetailLabel.numberOfLines = 0
        self.view.addSubview(self.courseIntroDetailLabel)
        self.courseIntroDetailLabel.snp.makeConstraints {
            $0.top.equalTo(courseDetailView.snp.bottom)
            $0.left.equalTo(20)
            $0.right.equalTo(-20)
            $0.height.equalTo(250)
        }
     
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = UIColor.lightGray
        refreshControl.layer.zPosition = -1
        refreshControl.addTarget(self, action: #selector(refreshDataList), for: .valueChanged)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.separatorStyle = .none
        self.tableView.refreshControl = refreshControl
        self.tableView.isHidden = true
        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints {
            $0.top.equalTo(courseDetailView.snp.bottom)
            $0.left.bottom.right.equalToSuperview()
        }
    }
    
    @objc func playCourseVideoEvent() {
        let alertVC = UIAlertController(title: "", message: "请根据以下课程目录进行观看", preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "好的", style: .cancel, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.tableView.reloadData()
    }
    
    @objc func refreshDataList() {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
            self.tableView.refreshControl?.endRefreshing()
        }
    }
    
    @objc func switchToCourseIntro() {
        // 课程介绍
        self.courseIntroDetailLabel.isHidden = false
        self.tableView.isHidden = true
        
        self.bottomActiveLine.snp.updateConstraints {
            $0.left.equalTo(0)
        }
    }
    
    @objc func switchToCourseCatalog() {
        // 课程目录
        self.courseIntroDetailLabel.isHidden = true
        self.tableView.isHidden = false
        
        self.bottomActiveLine.snp.updateConstraints {
            $0.left.equalTo(self.view.bounds.size.width/2)
        }
    }
    
}


extension THClassDetailViewController: UITableViewDataSource {
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return self.dataList.count
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let items = self.dataList[section]
        return items.count
    }
    
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: 45))
        headerView.backgroundColor = UIColor.white
        let titleLabel = UILabel()
        titleLabel.textColor = UIColor(rgb: 0x161F39)
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        headerView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(10)
            $0.left.equalTo(20)
            $0.right.equalTo(-20)
            $0.bottom.equalTo(-10)
        }
        if section == 0 {
            titleLabel.text = "汉语综合教学"
        } else if section == 1 {
            titleLabel.text = "基础知识-词汇"
        } else if section == 2 {
            titleLabel.text = "基础知识-词语法"
        } else if section == 3 {
            titleLabel.text = "基础知识-文字"
        } else if section == 4 {
            titleLabel.text = "基础知识-语音"
        } else if section == 5 {
            titleLabel.text = "京师教师资格跨文化交际案例分析"
        } else if section == 6 {
            titleLabel.text = "中华文化及其传播课"
        } else if section == 7 {
            titleLabel.text = "国际汉语教师面试"
        }
        return headerView
    }
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 45
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = self.dataList[indexPath.section]
        let cell = UITableViewCell(style: .default, reuseIdentifier: "kTHClassDetailViewControllerCellId")
        cell.textLabel?.textColor = UIColor.gray
        cell.textLabel?.font = UIFont.systemFont(ofSize: 17)
        cell.textLabel?.text = item[indexPath.row]
        if let videoPlayingDuration = UserDefaults.standard.value(forKey: item[indexPath.row]) as? String {
            cell.textLabel?.text = "\(item[indexPath.row]) 【已观看：\(videoPlayingDuration)】"
        } else if let lastPlayedVideoName = UserDefaults.standard.value(forKey: "LastPlayedVideoName") as? String {
            if lastPlayedVideoName == item[indexPath.row] {
                cell.textLabel?.text = "\(item[indexPath.row]) 【最后一次观看】"
            } 
        }
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
}


extension THClassDetailViewController: UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = self.dataList[indexPath.section]
        let videoName = item[indexPath.row]
        guard let videoUrl = "http://cdn.hanyu.telabytes.com/hanyu/video/\(videoName).mp4".encodeUrl() else {
            return
        }
        print("当前正在播放的视频链接地址=\(videoUrl)")
        
        // 存储最后一次播放的视频
        let userDefaults = UserDefaults.standard
        userDefaults.set(videoName, forKey: "LastPlayedVideoName")
        userDefaults.synchronize()
        
        let videoPlayerVC = THVideoPlayerViewController()
        videoPlayerVC.videoCourseName = videoName
        videoPlayerVC.videoUrlStr = videoUrl
        self.present(videoPlayerVC, animated: false, completion: nil)
    }
    
}


