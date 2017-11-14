//
//  CreateDiscussion.swift
//  Down To Discuss
//
//  Created by Lauren Martini on 11/5/17.
//  Copyright © 2017 cs160_team. All rights reserved.
//

import UIKit

//flag - ASK HOW TO TIE THIS INTO THE DATABASE
//ALSO SHOW WEIRD PROBLEM WHERE USER TRIES TO CREATE ANOTHER EVENT AFTER ONE ALREADY MADE
//THAT THERE ENDS UP BEING A BACK ARROW ALL THE TIME ON THE MAP
var eventCreated = 0
var eventName = ""
var fT = ""
var iT = ""

class CreateDiscussion: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var createButton: UIButton!
    
    @IBOutlet var disName: UITextField! = nil
    
    @IBOutlet var intenseTopic: UILabel!
    
    @IBOutlet var funTopic: UILabel!

    @IBOutlet var desField: UITextField! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.disName.delegate = self
        self.desField.delegate = self
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

        createButton.isEnabled = createShouldBeEnabled()

    }
    
    //hide keyboard when user clicks outside of textField - Doesn't really work... but return does!
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    //hide keyboard when return is pressed
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        disName.resignFirstResponder()
        desField.resignFirstResponder()
        return true
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
    
    /* OLD CODE TO TRY TO CHANGE THE BUTTON COLOR UNTIL CLICKED*/
    
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
    

}
