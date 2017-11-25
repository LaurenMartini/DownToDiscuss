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
    
    @IBOutlet var textFields: [UITextField]!
    
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupView()
        self.loginField.delegate = self
        self.passwordField.delegate = self
        
        //register view controller as observer
        NotificationCenter.default.addObserver(self, selector: #selector(textDidChange(_:)), name: Notification.Name.UITextFieldTextDidChange, object: nil)
    }
    
    func validate(_ textField: UITextField) -> (Bool, String?) {
        guard let text = textField.text else {
            return (false, nil)
        }
        
        return (text.characters.count > 0, "This field cannot be empty.")
    }
        
    @objc private func textDidChange(_ notification: Notification) {
        var formIsValid = true
        
        textFields = [loginField, passwordField]
        
        for textField in textFields {
            let (valid, _) = validate(textField)

            guard valid else {
                formIsValid = false
                break
            }
        }
        loginButton.isEnabled = formIsValid
        currUser = loginField.text!
        if (loginField.text == "LM") {
            currHost = 1
        }
    }
    
    func setupView() {
        loginButton.isEnabled = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //hide keyboard when return is pressed
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case loginField:
            passwordField.becomeFirstResponder()
        default:
            passwordField.resignFirstResponder()
        }
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
