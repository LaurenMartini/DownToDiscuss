//
//  ReviewViewController.swift
//  Down To Discuss
//
//  Created by Lauren Martini on 11/24/17.
//  Copyright © 2017 cs160_team. All rights reserved.
//

import UIKit

class ReviewViewController: UIViewController {
    
    @IBOutlet var reviewOne: UIImageView!

    @IBOutlet var textOne: UILabel!

    @IBOutlet var reviewTwo: UIImageView!

    @IBOutlet var textTwo: UILabel!

    @IBOutlet var reviewThree: UIImageView!

    @IBOutlet var textThree: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //switch based on currentDiscussion
        switch currentDis {
        case 0:
            reviewOne.image = UIImage(named: "fourStars.png")
            var temp = eventList[0].user.reviewList[0]
            textOne.text = temp.goodConvoButton
            
            temp = eventList[0].user.reviewList[1]
            reviewTwo.image = UIImage(named: "fiveStars.png")
            textTwo.text = temp.goodConvoButton + ", " + temp.openMindButton + ", and " + temp.commentMessage

            temp = eventList[0].user.reviewList[2]
            reviewThree.image = UIImage(named: "threeStars.png")
            textThree.text = temp.openMindButton + ", " + temp.commentMessage
            break
        case 1:
            reviewOne.image = UIImage(named: "fourStars.png")
            var temp = eventList[1].user.reviewList[0]
            textOne.text = temp.goodConvoButton + ", " + temp.openMindButton
            
            temp = eventList[1].user.reviewList[1]
            reviewTwo.image = UIImage(named: "threeStars.png")
            textTwo.text = temp.openMindButton

            temp = eventList[1].user.reviewList[2]
            reviewThree.image = UIImage(named: "threeStars.png")
            textThree.text = temp.goodConvoButton
            break
        case 2:
            reviewOne.image = UIImage(named: "fiveStars.png")
            var temp = eventList[2].user.reviewList[0]
            textOne.text = temp.goodConvoButton + ", " + temp.openMindButton + ", and " + temp.commentMessage

            temp = eventList[2].user.reviewList[1]
            reviewTwo.image = UIImage(named: "fiveStars.png")
            textTwo.text = temp.goodConvoButton + ", " + temp.openMindButton + ", and " + temp.commentMessage

            temp = eventList[2].user.reviewList[2]
            reviewThree.image = UIImage(named: "fiveStars.png")
            textThree.text = temp.goodConvoButton + ", " + temp.openMindButton + ", and " + temp.commentMessage
            break
        case 3:
            reviewOne.image = UIImage(named: "twoStars.png")
            var temp = eventList[3].user.reviewList[0]
            textOne.text = temp.closeMindButton + " and " + temp.commentMessage

            temp = eventList[3].user.reviewList[1]
            reviewTwo.image = UIImage(named: "threeStars.png")
            textTwo.text = temp.goodConvoButton + " and " + temp.commentMessage

            temp = eventList[3].user.reviewList[2]
            reviewThree.image = UIImage(named: "twoStars.png")
            textThree.text = temp.closeMindButton + " and " + temp.commentMessage
            break
        case 4:
            reviewOne.image = UIImage(named: "threeStars.png")
            var temp = eventList[4].user.reviewList[0]
            textOne.text = temp.commentMessage

            temp = eventList[4].user.reviewList[1]
            reviewTwo.image = UIImage(named: "twoStars.png")
            textTwo.text = temp.dominatingButton + " and " + temp.commentMessage

            temp = eventList[4].user.reviewList[2]
            reviewThree.image = UIImage(named: "threeStars.png")
            textThree.text = temp.closeMindButton
            break
        default:
            print("invalid current discussion")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func goBack(_ sender: Any) {
        ref?.child("status").setValue("profileClicked")
        self.view.removeFromSuperview()
    }
    
//    @IBAction func goBack(_ sender: Any) {
//        ref?.child("status").setValue("profileClicked")
//        self.view.removeFromSuperview()
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
