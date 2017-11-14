//
//  PopUpViewController.swift
//  Down To Discuss
//
//  Created by Lauren Martini on 11/2/17.
//  Copyright © 2017 cs160_team. All rights reserved.
//

import UIKit

class PopUpViewController: UIViewController {

    @IBOutlet var disTitle: UILabel!
    
    @IBOutlet var funTop: UILabel!
    
    @IBOutlet var intenseTop: UILabel!
    
    @IBOutlet var sRating: UIImageView!
    
    @IBOutlet var pPic: UIImageView!
    
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
        
        disTitle.text = eventList[num].discussionTitle
        sRating.image = eventList[num].user.userRating
        funTop.text = eventList[num].funTopic
        intenseTop.text = eventList[num].intenseTopic
        pPic.image = eventList[num].user.userPic
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func closePopUp(_ sender: Any) {
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
