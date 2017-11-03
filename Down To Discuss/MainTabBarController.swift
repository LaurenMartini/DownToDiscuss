//
//  MainTabBarController.swift
//  Down To Discuss
//  
//  CREDIT: Aviel Gross, StackOverflow on Jan 10, 2016
//  https://stackoverflow.com/questions/13136699/setting-the-default-tab-when-using-storyboards
//
//  Created by Lauren Martini on 11/2/17.
//  Copyright © 2017 cs160_team. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    @IBInspectable var defaultIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selectedIndex = defaultIndex
    }
}
