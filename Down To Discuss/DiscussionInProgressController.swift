//
//  DiscussionInProgressController.swift
//  Down To Discuss
//
//  Created by Lauren Martini on 11/15/17.
//  Copyright © 2017 cs160_team. All rights reserved.
//

import UIKit

class DiscussionInProgressController: UIViewController {
    @IBOutlet weak var leaveEndButton: UIButton!
    
    @IBOutlet weak var timerLabel: UILabel!
    
    var time = 0
    
    var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        if (currHost == 1) {
            leaveEndButton.setTitle("END", for: UIControlState.normal)
        }
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(DiscussionInProgressController.action), userInfo: nil, repeats: true)
    }
    
    func action() {
        time += 1
        timerLabel.text = timeString(time: TimeInterval(time))
    }
    
    //this is the format for full timer via: https://medium.com/ios-os-x-development/build-an-stopwatch-with-swift-3-0-c7040818a10f
    func timeString(time:TimeInterval) -> String {
        let hours = Int(time)/3600
        let minutes = Int(time)/60 % 60
        let seconds = Int(time) % 60
        
        return String(format:"%02i:%02i:%02i", hours, minutes, seconds)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func leaveEndPressed(_ sender: UIButton) {
        if (currHost == 1) {
            timer.invalidate()
            time = 0
            timerLabel.text = "00:00:00"
            ref?.child("status").setValue("discussionEnded")
        }
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
