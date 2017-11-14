//
//  Events.swift
//  Down To Discuss
//
//  Created by Lauren Martini on 11/6/17.
//  Copyright © 2017 cs160_team. All rights reserved.
//

import Foundation
import UIKit
import MapKit
import CoreLocation

class Events {
    /* EVENTS
     - add all the events here to populate the map (pre made events)
     - all will have timer to generate points in the prototype
     
     ALL EVENTS NEED THE FOLLOWING
     -userName
     -discussionTitle
     -funTopic
     -intTopic (intense topic)
     -userPic
     -location
     */
    var user:Profile
    var discussionTitle:String
    var location:CLLocationCoordinate2D
    var funTopic:String
    var intenseTopic:String
    var description:String
    
    init(user: Profile, discussionTitle: String, location: CLLocationCoordinate2D, funTopic: String, intenseTopic: String, description:String) {
        self.user = user
        self.discussionTitle = discussionTitle
        self.location = location
        self.funTopic = funTopic
        self.intenseTopic = intenseTopic
        self.description = description
    }
}
