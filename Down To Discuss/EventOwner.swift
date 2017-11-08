//
//  EventOwner.swift
//  Down To Discuss
//
//  Created by Lauren Martini on 11/7/17.
//  Copyright © 2017 cs160_team. All rights reserved.
//

import UIKit

var ownerEndedEvent = 0

class EventOwner: UIViewController {

    @IBOutlet var disNameOwner: UILabel!
    
    @IBOutlet var funTopicOwner: UILabel!
    
    @IBOutlet var intenseTopicOwner: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        disNameOwner.text = eventName
        funTopicOwner.text = fT
        intenseTopicOwner.text = iT
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func closeEventDesc(_ sender: Any) {
        ownerEndedEvent = 1
        self.view.removeFromSuperview()
    }
    
//    @IBAction func eventEnded(_ sender: Any) {
//        ownerEndedEvent = 1
//        self.view.removeFromSuperview()
//    }
//    @IBAction func showPointView(_ sender: Any) {
//        let popUpVC = UIStoryboard(name:"Main", bundle: nil).instantiateViewController(withIdentifier: "ownerPtBoard") as! OwnerPointsViewController
//        self.addChildViewController(popUpVC)
//        
//        popUpVC.view.frame = self.view.frame
//        self.view.addSubview(popUpVC.view)
//        popUpVC.didMove(toParentViewController: self)
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
