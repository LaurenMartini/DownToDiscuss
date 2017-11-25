//
//  HostInfoController.swift
//  Down To Discuss
//
//  Created by Lauren Martini on 11/24/17.
//  Copyright © 2017 cs160_team. All rights reserved.
//

import UIKit

class HostInfoController: UIViewController {
    
    @IBOutlet var hostP: UIImageView!
    
    @IBOutlet var hostR: UIImageView!
    
    @IBOutlet var hostN: UILabel!
    
    @IBOutlet var hostPoints: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if currentDis > -1 {
            hostN.text = eventList[currentDis].user.name
            hostPoints.text = "Points: " + (String)(eventList[currentDis].user.totalPoints)
            hostP.image = eventList[currentDis].user.userPic
            hostR.image = eventList[currentDis].user.userRating
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func returnToInfoScreen(_ sender: UIButton) {
        ref?.child("status").setValue("returnToInfo")
        self.view.removeFromSuperview()
    }
    
    @IBAction func goToReviews(_ sender: UIButton) {
        ref?.child("status").setValue("checkReviews")
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
