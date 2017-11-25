//
//  Review.swift
//  Down To Discuss
//
//  Created by Lauren Martini on 11/25/17.
//  Copyright © 2017 cs160_team. All rights reserved.
//

import Foundation

class Review {
    /*
     THIS CLASS CONTAINS:
     - array of comments from a user
     */
    var goodConvoButton: String
    var openMindButton: String
    var dominatingButton: String
    var closeMindButton: String
    var commentMessage: String
    
    init(goodConvoButton: String, openMindButton: String, dominatingButton: String, closeMindButton: String, commentMessage: String) {
        self.goodConvoButton = goodConvoButton
        self.openMindButton = openMindButton
        self.dominatingButton = dominatingButton
        self.closeMindButton = closeMindButton
        self.commentMessage = commentMessage
    }
}
