//
//  THMeViewController.swift
//  TelaHanyu
//
//  Created by victor on 1/23/20.
//  Copyright © 2020 Telabytes. All rights reserved.
//

import UIKit

@objc
public class THMeViewController: UIViewController {

    private var languageSwitch = THLanguageSwitch.shared()
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        self.title = self.languageSwitch.localizedString("My Profile")
        self.view.backgroundColor = UIColor.white
        
    }
}
