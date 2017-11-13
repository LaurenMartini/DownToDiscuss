//
//  DataModel.swift
//  Down To Discuss
//
//  Created by Lauren Martini on 11/3/17.
//  Copyright © 2017 cs160_team. All rights reserved.
//

import Foundation
import CoreLocation
import UIKit

//var exLocation = CLLocationCoordinate2DMake(37.876032, -122.258806)

//default main user
var currentUser = Profile(name: "Amber")
var currUserPic = UIImage(named: "6.jpg")

//default user database
var user1 = Profile(name:"Alice")
var user2 = Profile(name:"Bob")
var user3 = Profile(name:"Charlie")
var user4 = Profile(name:"David")
var user5 = Profile(name:"Ellie")

//default events
var eventList:[Events] = [
    Events(userName: user1, discussionTitle: "Food&Stuff", location:CLLocationCoordinate2DMake(37.876030, -122.258806), funTopic: "Food", intenseTopic:"Global Warming", userPic: UIImage(named: "1.jpg")!, description:"Come chat with me about food and global warming!!"),
    Events(userName: user1, discussionTitle: "Dogs", location:CLLocationCoordinate2DMake(37.876029, -122.258806), funTopic: "Dogs", intenseTopic:"Immigration", userPic: UIImage(named: "2.jpg")!, description: "Love to talk about dogs and the current issues around immigration"),
    Events(userName: user1, discussionTitle: "Free Movie!!", location:CLLocationCoordinate2DMake(37.876030, -122.258800), funTopic: "Movies", intenseTopic:"Free Speech", userPic: UIImage(named: "4.jpg")!, description: "Watch a movie and then chat about free speech after!"),
    Events(userName: user1, discussionTitle: "Substances and Songs", location:CLLocationCoordinate2DMake(37.876030, -122.258805), funTopic: "Music", intenseTopic:"Drug Policy", userPic: UIImage(named: "3.jpg")!, description: "Hoping to have a good discussion with someone who disagrees about current drug policy. Or the latest hit music!"),
    Events(userName: user1, discussionTitle: "Coffee Chat", location:CLLocationCoordinate2DMake(37.876039, -122.258805), funTopic: "Dogs", intenseTopic:"Free Speech", userPic: UIImage(named: "5.jpg")!, description: "Do you like dogs and have opinions about free speech?  Let's chat about it over some coffee!")]
