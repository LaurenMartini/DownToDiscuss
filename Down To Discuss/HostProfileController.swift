//
//  HostProfileController.swift
//  Down To Discuss
//
//  Created by Lauren Martini on 11/24/17.
//  Copyright © 2017 cs160_team. All rights reserved.
//

import UIKit

class HostProfileController: UIViewController {
    
    @IBOutlet var hostImage: UIImageView!
    
    @IBOutlet var hostName: UILabel!
    
    @IBOutlet var hostPoints: UILabel!
    
    @IBOutlet var hRating: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        //display the current host's info based on currentDis num
        hostImage.image = eventList[currentDis].user.userPic
        hostName.text = eventList[currentDis].user.name
        hostPoints.text = "Points: " + (String)(eventList[currentDis].user.totalPoints)
        hRating.image = eventList[currentDis].user.userRating
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func checkReviews(_ sender: Any) {
        ref?.child("status").setValue("checkReviews")
            self.view.removeFromSuperview()
    }
    
    
    @IBAction func backToHome(_ sender: Any) {
        ref?.child("status").setValue("")
        self.view.removeFromSuperview()
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
