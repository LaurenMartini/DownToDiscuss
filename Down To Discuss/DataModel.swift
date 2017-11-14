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
var currentUser = Profile(name: "Amber", userPic: UIImage(named: "6.jpg")!, userRating: UIImage(named: "fourStars.png")!)

//default user database
var user1 = Profile(name:"Alice", userPic: UIImage(named: "1.jpg")!, userRating: UIImage(named: "fourStars.png")!)
var user2 = Profile(name:"Bob", userPic: UIImage(named: "2.jpg")!, userRating: UIImage(named: "threeStars.png")!)
var user3 = Profile(name:"Charlie", userPic: UIImage(named: "4.jpg")!, userRating: UIImage(named: "fiveStars.png")!)
var user4 = Profile(name:"David", userPic: UIImage(named: "3.jpg")!, userRating: UIImage(named: "twoStars.png")!)
var user5 = Profile(name:"Ellie", userPic: UIImage(named: "5.jpg")!, userRating: UIImage(named: "threeStars.png")!)

//default events
var eventList:[Events] = [
    Events(user: user1, discussionTitle: "Food&Stuff", location:CLLocationCoordinate2DMake(37.875032, -122.257806), funTopic: "Food", intenseTopic:"Global Warming", description:"Come chat with me about food and global warming!!"),
    Events(user: user2, discussionTitle: "Dogs", location:CLLocationCoordinate2DMake(37.878032, -122.256806), funTopic: "Dogs", intenseTopic:"Immigration", description: "Love to talk about dogs and the current issues around immigration"),
    Events(user: user3, discussionTitle: "Free Movie!!", location:CLLocationCoordinate2DMake(37.873032, -122.261806), funTopic: "Movies", intenseTopic:"Free Speech", description: "Watch a movie and then chat about free speech after!"),
    Events(user: user4, discussionTitle: "Substances and Songs", location:CLLocationCoordinate2DMake(37.880032, -122.254806), funTopic: "Music", intenseTopic:"Drug Policy", description: "Hoping to have a good discussion with someone who disagrees about current drug policy. Or the latest hit music!"),
    Events(user: user5, discussionTitle: "Coffee Chat", location:CLLocationCoordinate2DMake(37.871032, -122.263806), funTopic: "Dogs", intenseTopic:"Free Speech", description: "Do you like dogs and have opinions about free speech?  Let's chat about it over some coffee!")]
