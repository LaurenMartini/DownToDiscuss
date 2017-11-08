//
//  CreateDiscussion.swift
//  Down To Discuss
//
//  Created by Lauren Martini on 11/5/17.
//  Copyright © 2017 cs160_team. All rights reserved.
//

import UIKit

//flag - ASK PAIGE IF THERE IS A BETTER WAY TO IMPLEMENT THIS
var eventCreated = 0
var eventName = ""
var fT = ""
var iT = ""

class CreateDiscussion: UIViewController {
    
    @IBOutlet var createButton: UIButton!
    
    @IBOutlet var disName: UITextField!
    
    @IBOutlet var intenseTopic: UILabel!
    
    @IBOutlet var funTopic: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()


    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        // Do any additional setup after loading the view.
        if (iAccessed == 1) {
            intenseTopic.text = iTopics[currIndex]
            intenseTopic.textColor = UIColor.black
        } else {
            intenseTopic.text = "Choose Topic >"
        }
        
        if (fAccessed == 1) {
            funTopic.text = fTopics[currIndexFun]
            funTopic.textColor = UIColor.black
        } else {
            funTopic.text = "Choose Topic >"
        }
        
        //        if (disName.text == "") {
        //            disName.text = "Enter Discussion Title"
        //            disName.textColor = UIColor.gray
        //        }
        
        //        if (iAccessed == 1 && fAccessed == 1 && disName.text != "") {
        //            createButton.backgroundColor = UIColor.green
        //        }
//        if (iAccessed == 1 && fAccessed == 1) {
//            createButton.backgroundColor = UIColor.green
//            eventCreated = 1
//        }
        
        createButton.isEnabled = createShouldBeEnabled()

    }
    
    
    
    
    func createShouldBeEnabled() -> Bool {
        if (iAccessed == 1 && fAccessed == 1 && disName.text != "") {
            eventCreated = 1
            eventName = disName.text!
            fT = funTopic.text!
            iT = intenseTopic.text!
            return true
        }
        return false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
