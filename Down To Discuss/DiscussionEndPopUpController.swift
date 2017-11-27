//
//  DiscussionEndPopUpController.swift
//  Down To Discuss
//
//  Created by Lauren Martini on 11/7/17.
//  Copyright © 2017 cs160_team. All rights reserved.
//

import UIKit

var ratingChosen = 0

class DiscussionEndPopUpController: UIViewController, UITextFieldDelegate{
    
    @IBOutlet var firstStar: UIButton!
    
    @IBOutlet var secondStar: UIButton!
    
    @IBOutlet var thirdStar: UIButton!
    
    @IBOutlet var fourthStar: UIButton!
    
    @IBOutlet var fifthStar: UIButton!
    
    @IBOutlet var commentSection: UITextField!
    
    @IBOutlet var pointAmt: UILabel!
    
    
    @IBAction func starOne(_ sender: Any) {
        if (ratingChosen == 0) {
            (sender as AnyObject).setImage(UIImage(named: "starFill_button.png"), for: UIControlState.normal)
            ratingChosen = 1
        } else {
            (sender as AnyObject).setImage(UIImage(named: "starEmpty.png"), for: UIControlState.normal)
            ratingChosen = 0
        }
    }
    
    @IBAction func starTwo(_ sender: Any) {
        if (ratingChosen == 0) {
            (sender as AnyObject).setImage(UIImage(named: "starFill_button.png"), for: UIControlState.normal)
            firstStar.setImage(UIImage(named: "starFill_button.png"), for: UIControlState.normal)
            ratingChosen = 1
        } else {
            (sender as AnyObject).setImage(UIImage(named: "starEmpty.png"), for: UIControlState.normal)
            firstStar.setImage(UIImage(named: "starEmpty.png"), for: UIControlState.normal)
            ratingChosen = 0
        }
    }
    
    @IBAction func starThree(_ sender: Any) {
        if (ratingChosen == 0) {
            (sender as AnyObject).setImage(UIImage(named: "starFill_button.png"), for: UIControlState.normal)
            firstStar.setImage(UIImage(named: "starFill_button.png"), for: UIControlState.normal)
            secondStar.setImage(UIImage(named: "starFill_button.png"), for: UIControlState.normal)
            ratingChosen = 1
        } else {
            (sender as AnyObject).setImage(UIImage(named: "starEmpty.png"), for: UIControlState.normal)
            firstStar.setImage(UIImage(named: "starEmpty.png"), for: UIControlState.normal)
            secondStar.setImage(UIImage(named: "starEmpty.png"), for: UIControlState.normal)
            ratingChosen = 0
        }
    }
    
    @IBAction func starFour(_ sender: Any) {
        if (ratingChosen == 0) {
            (sender as AnyObject).setImage(UIImage(named: "starFill_button.png"), for: UIControlState.normal)
            firstStar.setImage(UIImage(named: "starFill_button.png"), for: UIControlState.normal)
            secondStar.setImage(UIImage(named: "starFill_button.png"), for: UIControlState.normal)
            thirdStar.setImage(UIImage(named: "starFill_button.png"), for: UIControlState.normal)
            ratingChosen = 1
        } else {
            (sender as AnyObject).setImage(UIImage(named: "starEmpty.png"), for: UIControlState.normal)
            firstStar.setImage(UIImage(named: "starEmpty.png"), for: UIControlState.normal)
            secondStar.setImage(UIImage(named: "starEmpty.png"), for: UIControlState.normal)
            thirdStar.setImage(UIImage(named: "starEmpty.png"), for: UIControlState.normal)
            ratingChosen = 0
        }
    }
    
    @IBAction func starFive(_ sender: Any) {
        if (ratingChosen == 0) {
            (sender as AnyObject).setImage(UIImage(named: "starFill_button.png"), for: UIControlState.normal)
            firstStar.setImage(UIImage(named: "starFill_button.png"), for: UIControlState.normal)
            secondStar.setImage(UIImage(named: "starFill_button.png"), for: UIControlState.normal)
            thirdStar.setImage(UIImage(named: "starFill_button.png"), for: UIControlState.normal)
            fourthStar.setImage(UIImage(named: "starFill_button.png"), for: UIControlState.normal)
            ratingChosen = 1
        } else {
            (sender as AnyObject).setImage(UIImage(named: "starEmpty.png"), for: UIControlState.normal)
            firstStar.setImage(UIImage(named: "starEmpty.png"), for: UIControlState.normal)
            secondStar.setImage(UIImage(named: "starEmpty.png"), for: UIControlState.normal)
            thirdStar.setImage(UIImage(named: "starEmpty.png"), for: UIControlState.normal)
            fourthStar.setImage(UIImage(named: "starEmpty.png"), for: UIControlState.normal)
            ratingChosen = 0
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.commentSection.delegate = self
        // Do any additional setup after loading the view.
        pointAmt.text = (String)(eventList[currentDis].points) + " pts"
        //currentUser.totalPoints += eventList[currentDis].points
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func openMindPressed(_ sender: UIButton) {
        //(sender as AnyObject).setImage(UIImage(named: "create.png"), for: UIControlState.normal)
    }
    
    @IBAction func goodConvoPressed(_ sender: UIButton) {
        //(sender as AnyObject).setImage(UIImage(named: "create.png"), for: UIControlState.normal)
    }
    
    @IBAction func domineeringPressed(_ sender: UIButton) {
        //(sender as AnyObject).setImage(UIImage(named: "create.png"), for: UIControlState.normal)
    }
    
    @IBAction func closeMindPressed(_ sender: UIButton) {
        //(sender as AnyObject).setImage(UIImage(named: "create.png"), for: UIControlState.normal)
    }
    
    
    @IBAction func discussionEndedPressed(_ sender: UIButton) {
        ref?.child("status").setValue("")
        self.view.removeFromSuperview()
    }
    
    @IBAction func endDisc(_ sender: Any) {
        ref?.child("status").setValue("")
        self.view.removeFromSuperview()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        commentSection.resignFirstResponder()
        return true
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
