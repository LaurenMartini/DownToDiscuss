//
//  LoginController.swift
//  Down To Discuss
//
//  Created by Lauren Martini on 11/14/17.
//  Copyright © 2017 cs160_team. All rights reserved.
//

import UIKit

var currUser = ""

var currHost = 0

class LoginController: UIViewController, UITextFieldDelegate {

    @IBOutlet var loginField: UITextField!
    
    @IBOutlet var loginButton: UIButton!
    
    //textfield function
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let text = (loginField.text! as NSString).replacingCharacters(in: range, with: string)
        if !text.isEmpty {
            currUser = text
            loginButton.isUserInteractionEnabled = true
        } else {
            loginButton.isUserInteractionEnabled = false
        }
        
        return true
    }
    @IBAction func hostButtonPressed(_ sender: UIButton) {
        currHost = 1
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.loginField.delegate = self
        
        //if text field isn't null
        if (loginField.text?.isEmpty)! {
            loginButton.isUserInteractionEnabled = false
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    func loginComplete() -> Bool {
//        if (loginField.text != "") {
//            currUser = loginField.text!
//            return true
//        }
//        return false
//    }
    
    //hide keyboard when return is pressed
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        loginField.resignFirstResponder()
        return true
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
