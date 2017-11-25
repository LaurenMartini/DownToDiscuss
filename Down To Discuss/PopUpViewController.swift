//
//  PopUpViewController.swift
//  Down To Discuss
//
//  Created by Lauren Martini on 11/2/17.
//  Copyright © 2017 cs160_team. All rights reserved.
//

import UIKit

var profileCalled = 0
var currentDis = -1

class PopUpViewController: UIViewController {

    @IBOutlet var disTitle: UILabel!
    
    @IBOutlet var funTop: UILabel!
    
    @IBOutlet var intenseTop: UILabel!
    
    @IBOutlet var sRating: UIImageView!
    
    //@IBOutlet var pPic: UIImageView!
    
    @IBOutlet var pointAmt: UILabel!
    
    @IBOutlet var desInfo: UILabel!
    
    @IBOutlet var goEndButton: UIButton!
    
    @IBOutlet var chatEditButton: UIButton!
    
    @IBOutlet var hostName: UILabel!
    
    @IBOutlet var usrInterest: UILabel!
    
    @IBOutlet var usrThere: UILabel!
    
    @IBOutlet var hostPic: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //compare lat and longitute to user lat and longitude
        var num = 0
        while (num < eventList.count) {
            if (eventList[num].location.latitude == curLat && eventList[num].location.longitude == curLong) {
                break
            }
            num += 1
        }
        
        currentDis = num
        
        hostName.text = eventList[num].user.name
        disTitle.text = eventList[num].discussionTitle
        sRating.image = eventList[num].user.userRating
        funTop.text = "Fun Topic: " + eventList[num].funTopic
        intenseTop.text = "Intense Topic: " + eventList[num].intenseTopic
        hostPic.setImage(eventList[num].user.userPic, for: UIControlState.normal)
        desInfo.text = eventList[num].description
        usrInterest.text = "Interested: " + (String)(eventList[num].usersInterested)
        usrThere.text = "Currently Discussing: " + (String)(eventList[num].usersThere)
        
        if (currHost == 1){
            //make sure that the edit/end event popup is displayed
            goEndButton.setTitle("End", for: UIControlState.normal)
            chatEditButton.setTitle("Edit", for: UIControlState.normal)
            //disable profile pic
            hostPic.isEnabled = false
            //also don't show points
            pointAmt.text = ""
        } else {
            pointAmt.text = "Gain " + String(eventList[num].points) + " pts"
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func goEndPressed(_ sender: UIButton) {
        if (currHost == 1) {
            ref?.child("status").setValue("discussionEnded")
            self.view.removeFromSuperview()
        } else {
            startWalk = 1
            ref?.child("status").setValue("userInform")
            self.view.removeFromSuperview()
        }
    }
    
    //ENABLE THIS FOR FINAL PROJECT
//    @IBAction func chatEditPressed(_ sender: UIButton) {
//
//    }
    
    @IBAction func closePopUp(_ sender: UIButton) {
        ref?.child("status").setValue("")
        self.view.removeFromSuperview()
    }
    @IBAction func clickedOnProfile(_ sender: UIButton) {
        ref?.child("status").setValue("profileClicked")
        self.view.removeFromSuperview()
    }
    
    
//    /* CREDIT FOR BOTH ANIMATE FUNCTIONS: Seemu Apps: YouTube Video - Swift - Pop Up View
//     Tutorial */
//    func showAnimate(){
//        self.view.transform = CGAffineTransformMake(1.3, 1.3)
//        self.view.alpha = 0.0
//        UIView.animate(withDuration: 0.25, animations:{
//            self.view.alpha = 1.0
//            //self.view.transform = CGAffineTransformMake(a: 1.0, b: 1.0)
//        })
//    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
