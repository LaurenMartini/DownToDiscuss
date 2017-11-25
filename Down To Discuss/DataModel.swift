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
import FirebaseDatabase

// reference to our database
var ref: DatabaseReference?

var startWalk = 0
//user default reviews are blank to start until discussions are created and completed by the user
var tempReview: [Review] = [Review(goodConvoButton: "", openMindButton: "", dominatingButton: "", closeMindButton:"", commentMessage: "")]

//user1 reviews
var u1r1 = Review(goodConvoButton: "Good Conversation", openMindButton: "", dominatingButton: "", closeMindButton: "", commentMessage: "")
var u1r2 = Review(goodConvoButton: "Good Conversation", openMindButton: "Open-Minded", dominatingButton: "", closeMindButton: "", commentMessage: "Really friendly and good at listening!")
var u1r3 = Review(goodConvoButton: "", openMindButton: "Open-Minded", dominatingButton: "", closeMindButton: "", commentMessage: "Lack of familiarity in topic but willing to learn more.")
var u1reviewList:[Review] = [u1r1, u1r2, u1r3]

//user2 reviews
var u2r1 = Review(goodConvoButton: "Good Conversation", openMindButton: "Open-Minded", dominatingButton: "", closeMindButton: "", commentMessage: "")
var u2r2 = Review(goodConvoButton: "", openMindButton: "Open-Minded", dominatingButton: "", closeMindButton: "", commentMessage: "")
var u2r3 = Review(goodConvoButton: "Good Conversation", openMindButton: "", dominatingButton: "", closeMindButton: "", commentMessage: "")
var u2reviewList:[Review] = [u2r1, u2r2, u2r3]

//user3 reviews
var u3r1 = Review(goodConvoButton: "Good Conversation", openMindButton: "Open-Minded", dominatingButton: "", closeMindButton: "", commentMessage: "Charlie is a fantastic host!")
var u3r2 = Review(goodConvoButton: "Good Conversation", openMindButton: "Open-Minded", dominatingButton: "", closeMindButton: "", commentMessage: "Absolutely wonderful! Would recommend!")
var u3r3 = Review(goodConvoButton: "Good Conversation", openMindButton: "Open-Minded", dominatingButton: "", closeMindButton: "", commentMessage: "Gread discussion! Really enjoyed talking with Charlie.")
var u3reviewList:[Review] = [u3r1, u3r2, u3r3]

//user4 reviews
var u4r1 = Review(goodConvoButton: "", openMindButton: "", dominatingButton: "", closeMindButton: "Close-Minded", commentMessage: "Felt like David was uninterested in seeing a different side.")
var u4r2 = Review(goodConvoButton: "Good Conversation", openMindButton: "", dominatingButton: "", closeMindButton: "", commentMessage: "Even though it was difficult to start talking we eventually had a great discussion!")
var u4r3 = Review(goodConvoButton: "", openMindButton: "", dominatingButton: "", closeMindButton: "Close-Minded", commentMessage: "Agree with others on here, David is not open to opposing views.")
var u4reviewList:[Review] = [u4r1, u4r2, u4r3]

//user5 reviews
var u5r1 = Review(goodConvoButton: "", openMindButton: "", dominatingButton: "", closeMindButton: "", commentMessage: "Decent conversation - not good but not bad.")
var u5r2 = Review(goodConvoButton: "", openMindButton: "", dominatingButton: "Domineering", closeMindButton: "", commentMessage: "Ellie talked over me at times but I could tell she is passionate about her beliefs.")
var u5r3 = Review(goodConvoButton: "", openMindButton: "", dominatingButton: "", closeMindButton: "Close-Minded", commentMessage: "")
var u5reviewList:[Review] = [u5r1, u5r2, u5r3]

var currentUser = Profile(name: currUser, userPic: UIImage(named: "6.jpg")!, userRating: UIImage(named: "fourStars.png")!, hostStatus: 0, totalPoints: 0, reviewList:tempReview)

//default user database
var user1 = Profile(name:"Alice", userPic: UIImage(named: "1.jpg")!, userRating: UIImage(named: "fourStars.png")!, hostStatus: 1, totalPoints: 100, reviewList: u1reviewList)
var user2 = Profile(name:"Bob", userPic: UIImage(named: "2.jpg")!, userRating: UIImage(named: "threeStars.png")!, hostStatus: 1, totalPoints: 50, reviewList: u2reviewList)
var user3 = Profile(name:"Charlie", userPic: UIImage(named: "4.jpg")!, userRating: UIImage(named: "fiveStars.png")!, hostStatus: 1, totalPoints: 200, reviewList: u3reviewList)
var user4 = Profile(name:"David", userPic: UIImage(named: "3.jpg")!, userRating: UIImage(named: "twoStars.png")!, hostStatus: 1, totalPoints: 10, reviewList: u4reviewList)
var user5 = Profile(name:"Ellie", userPic: UIImage(named: "5.jpg")!, userRating: UIImage(named: "threeStars.png")!, hostStatus: 1, totalPoints: 25, reviewList: u5reviewList)

//default events
var eventList:[Events] = [
    Events(user: user1, discussionTitle: "Food&Stuff", location:CLLocationCoordinate2DMake(37.875032, -122.257806), funTopic: "Food", intenseTopic:"Global Warming", description:"Come chat with me about food and global warming!!", points: 5, usersInterested: 1, usersThere: 0),
    Events(user: user2, discussionTitle: "Dogs", location:CLLocationCoordinate2DMake(37.878032, -122.256806), funTopic: "Dogs", intenseTopic:"Immigration", description: "Love to talk about dogs and the current issues around immigration", points: 1, usersInterested: 0, usersThere: 2),
    Events(user: user3, discussionTitle: "Free Movie!!", location:CLLocationCoordinate2DMake(37.873032, -122.261806), funTopic: "Movies", intenseTopic:"Free Speech", description: "Watch a movie and then chat about free speech after!", points: 5, usersInterested: 3, usersThere: 1),
    Events(user: user4, discussionTitle: "Substances and Songs", location:CLLocationCoordinate2DMake(37.880032, -122.254806), funTopic: "Music", intenseTopic:"Drug Policy", description: "Hoping to have a good discussion with someone who disagrees about current drug policy. Or the latest hit music!", points: 1, usersInterested: 1, usersThere: 0),
    Events(user: user5, discussionTitle: "Coffee Chat", location:CLLocationCoordinate2DMake(37.872313, -122.260958), funTopic: "Dogs", intenseTopic:"Free Speech", description: "Do you like dogs and have opinions about free speech?  Let's chat about it over some coffee!", points: 1, usersInterested: 1, usersThere: 3)]
