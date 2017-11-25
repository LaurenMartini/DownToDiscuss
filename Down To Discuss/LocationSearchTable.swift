//
//  LocationSearchTable.swift
//  Down To Discuss
//
//  Created by Lauren Martini on 11/25/17.
//  Copyright © 2017 cs160_team. All rights reserved.
//

import UIKit
import MapKit

class LocationSearchTable: UITableViewController {
    
    //properties
//    @IBOutlet var tableView: UITableView!
//    @IBOutlet var searchFooter:SearchFooter!

    //stash search results for easy access
    //var matchingItems:[MKMapItem] = [] //ORIGINAL CODE FOR MAP
    var matchingItems = [Events]()
    var allItems = [Events]()
    
    //create an instance of search controller
    var sController:UISearchController? = nil
    
    //search queries rly on map region to prioritize local results
    var mapView:MKMapView? = nil

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        //add all of the events here that the user can search by
        //ref?.child("status").setValue("searching")
        allItems = eventList
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering() {
            return matchingItems.count
        }
        // #warning Incomplete implementation, return the number of rows
        return allItems.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let event: Events
        if isFiltering() {
            event = matchingItems[indexPath.row]
        } else {
            event = allItems[indexPath.row]
        }
        cell.textLabel!.text = event.discussionTitle
        cell.detailTextLabel!.text = "Fun Topic: " + event.funTopic + ", Intense Topic: " + event.intenseTopic
        return cell
    }

    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        matchingItems = allItems.filter({(event: Events) -> Bool in
            return event.discussionTitle.lowercased().contains(searchText.lowercased())
        })
        tableView.reloadData()
    }
    
    func getControllerCreatedInHome(sController: UISearchController) {
        self.sController = sController
    }
    
    //SEARCH BAR CODE
    func searchBarIsEmpty() -> Bool {
        return sController?.searchBar.text?.isEmpty ?? true
    }
    
    func isFiltering() -> Bool {
        //        ref?.child("status").setValue("filterResults")
        return (sController?.isActive)! && !searchBarIsEmpty()
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

//extension LocationSearchTable {
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) ->Int {
//        return matchingItems.count
//    }
//
//    override func tableView(_ tableView: UITableView,  cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
//        let selectedItem = matchingItems[indexPath.row].placemark
//        cell.textLabel?.text = selectedItem.name
//        cell.detailTextLabel?.text = ""
//        return cell
//    }
//}
//
extension LocationSearchTable: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
//        guard let mapView = mapView, let searchBarText = searchController.searchBar.text else {return}
//        let request = MKLocalSearchRequest()
//        request.naturalLanguageQuery = searchBarText
//        request.region = mapView.region
//        let search = MKLocalSearch(request: request)
//        search.start{ response, _ in
//            guard let response = response else {
//                return
//            }
//            self.matchingItems = response.mapItems
//            self.tableView.reloadData()
//        }
    }
}

