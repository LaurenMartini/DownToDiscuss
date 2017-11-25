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
            textOne.text = ""
            
            reviewTwo.image = UIImage(named: "fiveStars.png")
            textTwo.text = ""
            
            reviewThree.image = UIImage(named: "threeStars.png")
            textThree.text = ""
            break
        case 1:
            reviewOne.image = UIImage(named: "fourStars.png")
            textOne.text = ""
            
            reviewTwo.image = UIImage(named: "threeStars.png")
            textTwo.text = ""
            
            reviewThree.image = UIImage(named: "threeStars.png")
            textThree.text = ""
            break
        case 2:
            reviewOne.image = UIImage(named: "fiveStars.png")
            textOne.text = ""
            
            reviewTwo.image = UIImage(named: "fiveStars.png")
            textTwo.text = ""
            
            reviewThree.image = UIImage(named: "fiveStars.png")
            textThree.text = ""
            break
        case 3:
            reviewOne.image = UIImage(named: "twoStars.png")
            textOne.text = ""
            
            reviewTwo.image = UIImage(named: "threeStars.png")
            textTwo.text = ""
            
            reviewThree.image = UIImage(named: "twoStars.png")
            textThree.text = ""
            break
        case 4:
            reviewOne.image = UIImage(named: "threeStars.png")
            textOne.text = ""
            
            reviewTwo.image = UIImage(named: "twoStars.png")
            textTwo.text = ""
            
            reviewThree.image = UIImage(named: "threeStars.png")
            textThree.text = ""
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
