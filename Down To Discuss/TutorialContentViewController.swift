//
//  TutorialContentViewController.swift
//  Down To Discuss
//
//  Created by Lauren Martini on 11/21/17.
//  Copyright © 2017 cs160_team. All rights reserved.
//

import UIKit

class TutorialContentViewController: UIViewController {
    
        @IBOutlet weak var backgroundImageView: UIImageView!
    
    var pageIndex: Int?
    var imageName: String!

    override func viewDidLoad() {
        super.viewDidLoad()

        /*
         add different images to the background (the different tutorial pages)
         - find discussions
         - search for discussions/filter them
         - go to discussions!
         - check in and earn points!
         - gain a space on the leaderboard!
         */
        
        //REPLACE IMAGES BELOW WITH ACTUAL TUTORIAL PICS!
        self.backgroundImageView.image = UIImage(named: "1.jpg")
        //UIView.animate(withDuration: 1.0, animations: () -> Void)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func endTutorial(_ sender: UIButton) {
        //show next page
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
