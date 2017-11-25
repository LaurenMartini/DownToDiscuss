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
    var totalPoints: Int
    var reviewList = [Review]()
    
    init(name: String, userPic:UIImage, userRating:UIImage, hostStatus:Int, totalPoints: Int, reviewList: [Review]) {
        self.name = name
        self.userPic = userPic
        self.userRating = userRating
        self.hostStatus = hostStatus
        self.totalPoints = totalPoints
        self.reviewList = reviewList
    }
}
