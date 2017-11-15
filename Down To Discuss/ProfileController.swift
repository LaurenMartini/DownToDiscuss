//
//  ProfileController.swift
//  Down To Discuss
//
//  Created by Lauren Martini on 11/15/17.
//  Copyright © 2017 cs160_team. All rights reserved.
//

import UIKit

class ProfileController: UIViewController {
    
    @IBOutlet var currUserLabel: UILabel!
    
    @IBOutlet var profilePic: UIImageView!
    
    @IBOutlet var ratingPic: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if (currHost == 1) {
            currUserLabel.text = eventList[2].user.name
            profilePic.image = eventList[2].user.userPic
            ratingPic.image = eventList[2].user.userRating
        } else {
            currUserLabel.text = currUser
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
