//
//  tableViewController.swift
//  Down To Discuss
//
//  Created by Lauren Martini on 11/5/17.
//  Copyright © 2017 cs160_team. All rights reserved.
//

import UIKit

var intenseTopics = ["Abortion", "Gun Control", "Immigration", "Global Warming", "Free Speech", "Drug Policy"]

class tableViewController: UITableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //#warning Incomplete implementation, return the number of rows
        return intenseTopics.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = intenseTopics[indexPath.row]
        
        return cell
    }
}
