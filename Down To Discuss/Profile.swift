//
//  Profile.swift
//  Down To Discuss
//
//  Created by Lauren Martini on 11/2/17.
//  Copyright © 2017 cs160_team. All rights reserved.
//

import Foundation
import UIKit

//paige's example for profile set up
//see DataModel file for data
class Profile {
    var name = ""
    var userPic:UIImage
    var userRating:UIImage
    var hostStatus:Int
    
    init(name: String, userPic:UIImage, userRating:UIImage, hostStatus:Int) {
        self.name = name
        self.userPic = userPic
        self.userRating = userRating
        self.hostStatus = hostStatus
    }
}
