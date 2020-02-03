//
//  THHomeCourseViewController.swift
//  TelaHanyu
//
//  Created by victor on 1/23/20.
//  Copyright © 2020 Telabytes. All rights reserved.
//

import UIKit
import SnapKit
import YYWebImage


protocol THHomeCourse1TableViewCellDelegate {
    
    func homeCourse1TableViewCell(_ cell: THHomeCourse1TableViewCell, didOpenClassWith index: Int)
    
}



class THHomeCourse1TableViewCell : UITableViewCell {
    
    public var tableViewCellDelegate: THHomeCourse1TableViewCellDelegate?
    
    public var imgViewAvatarUrls: [String] = [
        "http://hzjy.010jiaoshi.com/data/upload/2019/1008/15/5d9c35b62015f_580_320_580_320.jpg",
        "http://hzjy.010jiaoshi.com/data/upload/2019/1008/15/5d9c34bb8f583_580_320_580_320.jpg"
    ]
    
    public var courseTitles: [String] = [
        "国际汉语教育报名",
        "国际汉语金牌保障班"
    ]
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        //let viewWidth = UIScreen.main.bounds.size.width
        //let viewHeight = UIScreen.main.bounds.size.height

        let margin: CGFloat = 15
        //let itemWidth = (viewWidth - margin) / 2
        
        let leftItem = UIView()
        self.contentView.addSubview(leftItem)
        leftItem.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.left.equalToSuperview()
            $0.width.equalToSuperview().dividedBy(2)
        }
        let leftItemImgView = UIImageView()
        if let url1 = URL(string: self.imgViewAvatarUrls[0]) {
            leftItemImgView.yy_setImage(with: url1, placeholder: UIImage(), options: .progressiveBlur, completion: nil)
        }
        leftItemImgView.isUserInteractionEnabled = true
        leftItemImgView.contentMode = .scaleToFill
        let leftItemImgViewGesture = UITapGestureRecognizer(target: self, action: #selector(openClass0))
        leftItemImgView.addGestureRecognizer(leftItemImgViewGesture)
        leftItem.addSubview(leftItemImgView)
        leftItemImgView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.left.equalTo(margin)
            $0.right.equalTo(-margin)
            $0.height.equalTo(120)
        }
        let leftItemTitle = UILabel()
        leftItemTitle.textColor = UIColor(rgb: 0x161F39)
        leftItemTitle.font = UIFont.boldSystemFont(ofSize: 18)
        leftItemTitle.text = self.courseTitles[0]
        leftItem.addSubview(leftItemTitle)
        leftItemTitle.snp.makeConstraints {
            $0.top.equalTo(leftItemImgView.snp.bottom)
            $0.left.equalTo(margin)
            $0.right.equalTo(-margin)
            $0.height.equalTo(35)
        }
        let leftItemTuitionLabel = UILabel()
        leftItemTuitionLabel.textColor = UIColor(rgb: 0xfe6d00)
        leftItemTuitionLabel.font = UIFont.systemFont(ofSize: 14)
        leftItemTuitionLabel.text = "付费:￥2300"
        leftItem.addSubview(leftItemTuitionLabel)
        leftItemTuitionLabel.snp.makeConstraints {
            $0.top.equalTo(leftItemTitle.snp.bottom)
            $0.left.equalTo(margin)
            $0.right.equalTo(-margin)
            $0.height.equalTo(25)
        }
        let leftItemPurchaseCountTitle = UILabel()
        leftItemPurchaseCountTitle.textColor = UIColor.lightGray
        leftItemPurchaseCountTitle.font = UIFont.systemFont(ofSize: 12)
        leftItemPurchaseCountTitle.text = "37189人购买"
        leftItemPurchaseCountTitle.textAlignment = .right
        leftItem.addSubview(leftItemPurchaseCountTitle)
        leftItemPurchaseCountTitle.snp.makeConstraints {
            $0.top.equalTo(leftItemTitle.snp.bottom)
            $0.left.equalTo(margin)
            $0.right.equalTo(-margin)
            $0.height.equalTo(22)
        }
        
        
        let rightItem = UIView()
        self.contentView.addSubview(rightItem)
        rightItem.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.right.equalToSuperview()
            $0.width.equalToSuperview().dividedBy(2)
        }
        let rightItemImgView = UIImageView()
        if let url2 = URL(string: self.imgViewAvatarUrls[1]) {
            rightItemImgView.yy_setImage(with: url2, placeholder: UIImage(), options: .progressiveBlur, completion: nil)
        }
        rightItemImgView.isUserInteractionEnabled = true
        rightItemImgView.contentMode = .scaleToFill
        let rightItemImgViewGesture = UITapGestureRecognizer(target: self, action: #selector(openClass1))
        rightItemImgView.addGestureRecognizer(rightItemImgViewGesture)
        rightItem.addSubview(rightItemImgView)
        rightItemImgView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.left.equalTo(margin)
            $0.right.equalTo(-margin)
            $0.height.equalTo(120)
        }
        let rightItemTitle = UILabel()
        rightItemTitle.textColor = UIColor(rgb: 0x161F39)
        rightItemTitle.font = UIFont.boldSystemFont(ofSize: 18)
        rightItemTitle.text = self.courseTitles[1]
        rightItem.addSubview(rightItemTitle)
        rightItemTitle.snp.makeConstraints {
            $0.top.equalTo(rightItemImgView.snp.bottom)
            $0.left.equalTo(margin)
            $0.right.equalTo(-margin)
            $0.height.equalTo(35)
        }
        let rightItemTuitionLabel = UILabel()
        rightItemTuitionLabel.textColor = UIColor(rgb: 0xfe6d00)
        rightItemTuitionLabel.font = UIFont.systemFont(ofSize: 14)
        rightItemTuitionLabel.text = "付费:￥6800"
        rightItem.addSubview(rightItemTuitionLabel)
        rightItemTuitionLabel.snp.makeConstraints {
            $0.top.equalTo(rightItemTitle.snp.bottom)
            $0.left.equalTo(margin)
            $0.right.equalTo(-margin)
            $0.height.equalTo(25)
        }
        let rightItemPurchaseCountTitle = UILabel()
        rightItemPurchaseCountTitle.textColor = UIColor.lightGray
        rightItemPurchaseCountTitle.font = UIFont.systemFont(ofSize: 12)
        rightItemPurchaseCountTitle.text = "12109人购买"
        rightItemPurchaseCountTitle.textAlignment = .right
        rightItem.addSubview(rightItemPurchaseCountTitle)
        rightItemPurchaseCountTitle.snp.makeConstraints {
            $0.top.equalTo(rightItemTitle.snp.bottom)
            $0.left.equalTo(margin)
            $0.right.equalTo(-margin)
            $0.height.equalTo(22)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func openClass0() {
        self.tableViewCellDelegate?.homeCourse1TableViewCell(self, didOpenClassWith: 0)
    }
    
    @objc func openClass1() {
        self.tableViewCellDelegate?.homeCourse1TableViewCell(self, didOpenClassWith: 1)
    }
}


class THHomeCourse2TableViewCell : UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        
        let margin: CGFloat = 15
        
        let leftItem = UIView()
        self.contentView.addSubview(leftItem)
        leftItem.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.left.equalToSuperview()
            $0.width.equalToSuperview().dividedBy(2)
        }
        let leftItemImgView = UIImageView()
        if let url1 = URL(string: "http://hzjy.010jiaoshi.com/addons/theme/stv1/_static/images2/bb-1.jpg") {
            leftItemImgView.yy_setImage(with: url1, placeholder: UIImage(), options: .progressiveBlur, completion: nil)
        }
        leftItemImgView.contentMode = .scaleToFill
        leftItem.addSubview(leftItemImgView)
        leftItemImgView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.left.equalTo(margin)
            $0.right.equalTo(-(margin / 2))
            $0.height.equalTo(120)
        }
        
        let leftItemImgView1 = UIImageView()
        if let url1 = URL(string: "http://hzjy.010jiaoshi.com/addons/theme/stv1/_static/images2/bb-4.jpg") {
            leftItemImgView1.yy_setImage(with: url1, placeholder: UIImage(), options: .progressiveBlur, completion: nil)
        }
        leftItemImgView1.contentMode = .scaleToFill
        leftItem.addSubview(leftItemImgView1)
        leftItemImgView1.snp.makeConstraints {
            $0.top.equalTo(leftItemImgView.snp.bottom).offset(margin)
            $0.left.equalTo(margin)
            $0.right.equalTo(-(margin / 2))
            $0.height.equalTo(120)
        }
        
        let rightItem = UIView()
        self.contentView.addSubview(rightItem)
        rightItem.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.right.equalToSuperview()
            $0.width.equalToSuperview().dividedBy(2)
        }
        let rightItemImgView = UIImageView()
        if let url2 = URL(string: "http://hzjy.010jiaoshi.com/addons/theme/stv1/_static/images2/bb-3.jpg") {
            rightItemImgView.yy_setImage(with: url2, placeholder: UIImage(), options: .progressiveBlur, completion: nil)
        }
        rightItemImgView.contentMode = .scaleToFill
        rightItem.addSubview(rightItemImgView)
        rightItemImgView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.left.equalTo(margin / 2)
            $0.right.equalTo(-margin)
            $0.height.equalTo(120)
        }
        
        let rightItemImgView1 = UIImageView()
        if let url2 = URL(string: "http://hzjy.010jiaoshi.com/addons/theme/stv1/_static/images2/bb-2.jpg") {
            rightItemImgView1.yy_setImage(with: url2, placeholder: UIImage(), options: .progressiveBlur, completion: nil)
        }
        rightItemImgView1.contentMode = .scaleToFill
        rightItem.addSubview(rightItemImgView1)
        rightItemImgView1.snp.makeConstraints {
            $0.top.equalTo(rightItemImgView.snp.bottom).offset(margin)
            $0.left.equalTo(margin / 2)
            $0.right.equalTo(-margin)
            $0.height.equalTo(120)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


class THHomeCourse3TableViewCell : UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        
        let margin: CGFloat = 15
        
        let leftItem = UIView()
        self.contentView.addSubview(leftItem)
        leftItem.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.left.equalToSuperview()
            $0.width.equalToSuperview().dividedBy(2)
        }
        let leftItemImgView = UIImageView()
        if let url1 = URL(string: "http://hzjy.010jiaoshi.com/data/upload/2019/1021/15/5dad61af8ae91_180_126_180_126.jpg") {
            leftItemImgView.yy_setImage(with: url1, placeholder: UIImage(), options: .progressiveBlur, completion: nil)
        }
        leftItemImgView.contentMode = .scaleToFill
        leftItem.addSubview(leftItemImgView)
        leftItemImgView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.left.equalTo(margin)
            $0.right.equalTo(-margin)
            $0.height.equalTo(120)
        }
        let leftItemTitle = UILabel()
        leftItemTitle.textColor = UIColor(rgb: 0x161F39)
        leftItemTitle.font = UIFont.systemFont(ofSize: 15)
        leftItemTitle.text = "2020年美国汉语教师开始报名啦，2月初..."
        leftItemTitle.numberOfLines = 0
        leftItem.addSubview(leftItemTitle)
        leftItemTitle.snp.makeConstraints {
            $0.top.equalTo(leftItemImgView.snp.bottom)
            $0.left.equalTo(margin)
            $0.right.equalTo(-margin)
            $0.bottom.equalToSuperview()
        }
        
        
        let rightItem = UIView()
        self.contentView.addSubview(rightItem)
        rightItem.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.right.equalToSuperview()
            $0.width.equalToSuperview().dividedBy(2)
        }
        let rightItemImgView = UIImageView()
        if let url2 = URL(string: "http://hzjy.010jiaoshi.com/data/upload/2019/1021/15/5dad623c01a92_180_126_180_126.jpg") {
            rightItemImgView.yy_setImage(with: url2, placeholder: UIImage(), options: .progressiveBlur, completion: nil)
        }
        rightItemImgView.contentMode = .scaleToFill
        rightItem.addSubview(rightItemImgView)
        rightItemImgView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.left.equalTo(margin)
            $0.right.equalTo(-margin)
            $0.height.equalTo(120)
        }
        let rightItemTitle = UILabel()
        rightItemTitle.textColor = UIColor(rgb: 0x161F39)
        rightItemTitle.font = UIFont.systemFont(ofSize: 15)
        rightItemTitle.text = "对外汉语教师分享那些老外学中文的趣事~"
        rightItemTitle.numberOfLines = 0
        rightItem.addSubview(rightItemTitle)
        rightItemTitle.snp.makeConstraints {
            $0.top.equalTo(rightItemImgView.snp.bottom)
            $0.left.equalTo(margin)
            $0.right.equalTo(-margin)
            $0.bottom.equalToSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}





@objc(THHomeCourseViewController)
public class THHomeCourseViewController: UIViewController {
    
    private var languageSwitch = THLanguageSwitch.shared()

    private let bannerImageView: UIImageView = UIImageView()
    private let tableView: UITableView = UITableView(frame: CGRect(), style: .plain)
    

    override public func viewDidLoad() {
        super.viewDidLoad()
        self.title = self.languageSwitch.localizedString("Course Mall")
        self.view.backgroundColor = UIColor.white
        self.navigationItem.backBarButtonItem = UIBarButtonItem()
        
        self.createBanner()
        self.createTableView()
        
    }
    
    func createBanner() {
        let bannerUrlStr = "http://hzjy.010jiaoshi.com/data/upload/2019/1204/17/5de783865bff8_1920_420_1920_420.jpg"
        if let url = URL(string: bannerUrlStr) {
            self.bannerImageView.yy_setImage(with: url, placeholder: UIImage(), options: .progressiveBlur, completion: nil)
        }
        self.view.addSubview(self.bannerImageView)
        self.bannerImageView.snp.makeConstraints {
            if #available(iOS 11.0, *) {
                $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            } else {
                // Fallback on earlier versions
                $0.top.equalToSuperview()
            }
            $0.left.right.equalToSuperview()
            $0.height.equalTo(180)
        }
    }
    
    func createTableView() {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = UIColor.lightGray
        refreshControl.layer.zPosition = -1
        refreshControl.addTarget(self, action: #selector(refreshDataList), for: .valueChanged)
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.separatorStyle = .none
        self.tableView.refreshControl = refreshControl
        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints {
            $0.top.equalTo(self.bannerImageView.snp.bottom).offset(10)
            $0.left.bottom.right.equalToSuperview()
        }
    }
    
    @objc func refreshDataList() {
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(1500)) {
            self.tableView.refreshControl?.endRefreshing()
        }
    }

}


extension THHomeCourseViewController: UITableViewDataSource {
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: 60))
        headerView.backgroundColor = UIColor.white
        let titleLabel = UILabel()
        titleLabel.textColor = UIColor(rgb: 0x161F39)
        titleLabel.font = UIFont.boldSystemFont(ofSize: 22)
        headerView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(10)
            $0.left.equalTo(20)
            $0.right.equalTo(-20)
            $0.bottom.equalTo(-10)
        }
        if section == 0 {
            titleLabel.text = self.languageSwitch.localizedString("Premium Course")
        } else if section == 1 {
            titleLabel.text = self.languageSwitch.localizedString("Top Activities")
        } else if section == 2 {
            titleLabel.text = self.languageSwitch.localizedString("Related Info")
        }
        return headerView
    }
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = THHomeCourse1TableViewCell(style: .default, reuseIdentifier: "HomeCourse1")
            cell.tableViewCellDelegate = self
            return cell
        } else if indexPath.section == 1 {
            let cell = THHomeCourse2TableViewCell(style: .default, reuseIdentifier: "HomeCourse2")
            
            return cell
        } else if indexPath.section == 2 {
            let cell = THHomeCourse3TableViewCell(style: .default, reuseIdentifier: "HomeCourse3")
            
            return cell
        }
        return UITableViewCell()
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            
        } else if indexPath.section == 1 {
            return 255
        } else if indexPath.section == 2 {
            
        }
        return 180
    }
    
}



extension THHomeCourseViewController: UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
}


extension THHomeCourseViewController: THHomeCourse1TableViewCellDelegate {
    
    func homeCourse1TableViewCell(_ cell: THHomeCourse1TableViewCell, didOpenClassWith index: Int) {
        let vc = THClassDetailViewController()
        vc.classIndex = index
        vc.classCoverUrl = cell.imgViewAvatarUrls[index]
        vc.classCourseTitle = cell.courseTitles[index]
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
