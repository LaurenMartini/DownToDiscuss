//
//  OwnerPointsViewController.swift
//  Down To Discuss
//
//  Created by Lauren Martini on 11/7/17.
//  Copyright © 2017 cs160_team. All rights reserved.
//

import UIKit

class OwnerPointsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func acceptedPoints(_ sender: Any) {
        ownerEndedEvent = 0
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
