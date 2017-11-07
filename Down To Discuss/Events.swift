//
//  Events.swift
//  Down To Discuss
//
//  Created by Lauren Martini on 11/6/17.
//  Copyright © 2017 cs160_team. All rights reserved.
//

import Foundation
var userName = ["Alice", "Bob", "Charlie", "David", "Ellie"]
var discussionTitle = ["Event1", "Event2", "Event3", "Event4", "Event5"]
var funT = ["Food", "Dogs", "Movies", "Music", "Dogs"]
var intenseT = ["Global Warming", "Immigration", "Free Speech", "Drug Policy", "Free Speech"]

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
     */
    var userName:[String]
    init(userName:[String]) {
        self.userName = ["Alice", "Bob", "Charlie", "David", "Ellie"]
    }
    var discussionTitle = ["Event1", "Event2", "Event3", "Event4", "Event5"]
    var funT = ["Food", "Dogs", "Movies", "Music", "Dogs"]
    var intenseT = ["Global Warming", "Immigration", "Free Speech", "Drug Policy", "Free Speech"]
    
    func getUserName(index: Int) -> String {
        return userName[index]
    }
}
