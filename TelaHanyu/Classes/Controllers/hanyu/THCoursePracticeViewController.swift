//
//  THCoursePracticeViewController.swift
//  TelaHanyu
//
//  Created by victor on 1/23/20.
//  Copyright © 2020 Telabytes. All rights reserved.
//
//  课程练习
//

import UIKit

@objc
public class THCoursePracticeViewController: UIViewController {

    
    private var languageSwitch = THLanguageSwitch.shared()
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        self.title = self.languageSwitch.localizedString("Course Practice")
        self.view.backgroundColor = UIColor.white

    }

}
