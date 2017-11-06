//
//  FunTopics.swift
//  Down To Discuss
//
//  Created by Lauren Martini on 11/5/17.
//  Copyright © 2017 cs160_team. All rights reserved.
//

import UIKit

var fTopics = ["Food", "Movies", "Kardashians", "Music", "Dogs"]
var currIndexFun = 0
var fAccessed = 0

class FunTopics: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fTopics.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let funCell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "funCell")
        funCell.textLabel?.text = fTopics[indexPath.row]
        
        return funCell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        currIndexFun = indexPath.row
        
        fAccessed = 1
        
        performSegue(withIdentifier: "segueFun", sender: self)
    }


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
