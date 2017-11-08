//
//  DiscussionEndPopUpController.swift
//  Down To Discuss
//
//  Created by Lauren Martini on 11/7/17.
//  Copyright © 2017 cs160_team. All rights reserved.
//

import UIKit

class DiscussionEndPopUpController: UIViewController {
    
    @IBAction func starOne(_ sender: Any) {
        (sender as AnyObject).setImage(UIImage(named: "star-128.png"), for: UIControlState.normal)
    }
    
    @IBAction func starTwo(_ sender: Any) {
        (sender as AnyObject).setImage(UIImage(named: "star-128.png"), for: UIControlState.normal)
    }
    
    @IBAction func starThree(_ sender: Any) {
        (sender as AnyObject).setImage(UIImage(named: "star-128.png"), for: UIControlState.normal)
    }
    
    @IBAction func starFour(_ sender: Any) {
        (sender as AnyObject).setImage(UIImage(named: "star-128.png"), for: UIControlState.normal)
    }
    
    @IBAction func starFive(_ sender: Any) {
        (sender as AnyObject).setImage(UIImage(named: "star-128.png"), for: UIControlState.normal)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func endDisc(_ sender: Any) {
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
