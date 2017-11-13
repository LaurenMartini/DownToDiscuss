//
//  Home.swift
//  Down To Discuss
//
//  Created by Lauren Martini on 11/2/17.
//  Copyright © 2017 cs160_team. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

var curLat = 0.0
var curLong = 0.0
var disNum = 0
var exLocation = CLLocationCoordinate2DMake(37.876032, -122.258806)
var moveLat = 0.0
var moveLong = 0.0
var userWalked = 0
// userPos = UIImage(named: "blueCircle.png")

class Home: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet var Map: MKMapView!
    
    //required for current location
    let manager = CLLocationManager()
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[0]
        
        let span: MKCoordinateSpan = MKCoordinateSpanMake(0.008, 0.008)
        
        let myLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
        
        //let exLocation = CLLocationCoordinate2DMake(37.876032, -122.258806)
        
        let region: MKCoordinateRegion = MKCoordinateRegionMake(exLocation, span)
        
        Map.setRegion(region, animated: false)
        
        self.Map.showsUserLocation = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //current location code section
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest//kCLLocationAccuracyKilometer
        //manager.requestWhenInUseAuthorization()
        //temporarily adding this authorization to see if it fixes anything...
        manager.requestAlwaysAuthorization()
        manager.startUpdatingLocation()
        
        if (CLLocationManager.locationServicesEnabled()) {
            switch (CLLocationManager.authorizationStatus()) {
            case .authorizedWhenInUse:
                print("authorized")
                break
            case .notDetermined:
                print("not determined")
                break
            case .restricted:
                print("restricted")
                break
            case .denied:
                print("denied")
                break
            default:
                print("nonsense")
            }
        }
        //OLD CODE - CAN DELETE
//        let event1 = MapAnnotations(coordinate: CLLocationCoordinate2D(latitude: 37.3358656, longitude: -122.030848), title: "Event 1", subtitle: "food")
//        
//        Map.addAnnotation(event1)
        
        //BROKEN CODE RIGHT NOW :( NEED TO FIGURE OUT HOW TO FIX AUTHORIZATION ISSUE
//        Map.setCenter(exLocation, animated: true)
//
//        addOtherDiscussions(manager, didUpdateLocations: [manager.location!])
//
//        discussionReached(manager, didUpdateLocations: [manager.location!])
//
//        //fix to add user's created event to the map
//        if (eventCreated == 1) {
//            addNewDiscussionMarker(manager, didUpdateLocations: [manager.location!])
//        }
//        if (ownerEndedEvent == 1) {
//            showOwnerPoints(sender: self)
//        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addOtherDiscussions(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = exLocation //was locations.first for current Location
//        if (location != nil) {
//            var y = 0
//            while y < 5 {
//                var mulAmt = 1.0
//                var otherAmt = 1.0
//                if (y % 2 == 0) {
//                    mulAmt = -1.0
//                }
//                if (y % 2 != 0) {
//                    otherAmt = -1.0
//                }
//                var amt = Double(y)
//                if (y == 0) {
//                    amt = 6.0
//                }
//                //latitude
//                let lat = (location.latitude) + ((0.001 * amt) * otherAmt)
//                userLat[y] = lat
//                //longitude
//                let long = (location.longitude) + ((0.001 * amt) * mulAmt)
//                userLong[y] = long
//                //location
//                let disLocation = CLLocationCoordinate2D(latitude: lat, longitude: long)
//                //pin
//                let pin = MapAnnotations(coordinate: disLocation, title: discussionTitle[y], subtitle: funT[y] + ", " + intenseT[y])
//                //place pin
////                pin.coordinate = disLocation
////                //add info to that marker
////                pin.title = discussionTitle[y]
////                pin.subtitle = funT[y] + ", " + intenseT[y]
//                Map.addAnnotation(pin)
//                y += 1
//            }
//        }
        var y = 0
        while y < 5 {
            var mulAmt = 1.0
            var otherAmt = 1.0
            if (y % 2 == 0) {
                mulAmt = -1.0
            }
            if (y % 2 != 0) {
                otherAmt = -1.0
            }
            var amt = Double(y)
            if (y == 0) {
                amt = 6.0
            }
            //latitude
            let lat = (location.latitude) + ((0.001 * amt) * otherAmt)
            //userLat[y] = lat
            //longitude
            let long = (location.longitude) + ((0.001 * amt) * mulAmt)
            //userLong[y] = long
            
            //store 2nd event as a temp for first prototype iteration
            if (y == 2) {
                moveLat = lat
                moveLong = long
            }
            
            //location
            let disLocation = CLLocationCoordinate2D(latitude: lat, longitude: long)
            //pin
            let pin = MapAnnotations(coordinate: disLocation, title: eventList[y].discussionTitle, subtitle: "Fun Topic: " + eventList[y].funTopic + "\n Intense Topic: " + eventList[y].intenseTopic)
            //place pin
            //                pin.coordinate = disLocation
            //                //add info to that marker
            //                pin.title = discussionTitle[y]
            //                pin.subtitle = funT[y] + ", " + intenseT[y]
            Map.addAnnotation(pin)
            y += 1
        }
    }
    
    func addNewDiscussionMarker(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //to add a waypoint to the user's location if they created a discussion
        let location = exLocation
        //let type = MapMarkerType(rawValue: 0) ?? .onePt USED FOR CURRENT LOCATION
//        if (location != nil) {
//            let annotation = MapAnnotations(coordinate: location, title: eventName, subtitle: "User's subtitle")
//            Map.addAnnotation(annotation)
//            userName.append("Amber")
//            discussionTitle.append(eventName)
//            funT.append(fT)
//            intenseT.append(iT)
//            starRating.append("fourStars.png")
//            userLat.append(location.latitude)
//            userLong.append(location.longitude)
//        }
        let annotation = MapAnnotations(coordinate: location, title: eventName, subtitle: "User's subtitle")
        Map.addAnnotation(annotation)
        var newEvent = Events(userName: currentUser, discussionTitle: eventName, location:  CLLocationCoordinate2DMake(location.latitude, location.longitude), funTopic: "", intenseTopic: "", userPic: currUserPic!, description: "")
        eventList.append(newEvent)
    }
    
    func discussionReached(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //show alert when within range of location
        let location = exLocation
        
//        if (location != nil) {
//            var num = 0
//            
//            while (num < 5) {
//                if (userLat[num] == location.latitude && userLong[num] == location.longitude) {
//                    let ac = UIAlertController(title: "You have arrived!", message: "Ready to discuss?", preferredStyle: .alert)
//                    ac.addAction(UIAlertAction(title: "Discuss", style: .default, handler: {(action) in ac.dismiss(animated: true, completion: nil)
//                        //do something here
//                    }))
//                    ac.addAction(UIAlertAction(title: "Cancel", style: .default, handler: {(action) in ac.dismiss(animated: true, completion: nil)
//                        //do something here
//                    }))
//                    disNum = num
//                    break
//                }
//                num += 1
//            }
//        }
        var num = 0
        
        while (num < 5) {
            if (eventList[num].location.latitude == location.latitude && eventList[num].location.longitude == location.longitude) {
                let ac = UIAlertController(title: "You have arrived!", message: "Ready to discuss?", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "Discuss", style: .default, handler: {(action) in ac.dismiss(animated: true, completion: nil)
                    //do something here
                }))
                ac.addAction(UIAlertAction(title: "Cancel", style: .default, handler: {(action) in ac.dismiss(animated: true, completion: nil)
                    //do something here
                }))
                disNum = num
                break
            }
            num += 1
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView?{
        let identifier = "MapAnnotations"
        
        if annotation is MapAnnotations {
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
            if annotationView == nil {
                annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                annotationView!.canShowCallout = true
                
                let btn = UIButton(type: .detailDisclosure)
                annotationView!.rightCalloutAccessoryView = btn
            } else {
                annotationView!.annotation = annotation
            }
            
            return annotationView
        }
        
        return nil
    }
    
    var selectedAnnotation: MKPointAnnotation!
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == view.rightCalloutAccessoryView {
            //selectedAnnotation = view.annotation as? MKPointAnnotation
            let mpAn = view.annotation as? MapAnnotations
            curLat = (mpAn?.coordinate.latitude)!
            curLong = (mpAn?.coordinate.longitude)!
            
            var num = 0
            while (num < eventList.count) {
                if (eventList[num].location.latitude == curLat && eventList[num].location.longitude == curLong) {
                    break
                }
                num += 1
            }
            if (eventList[num].userName.name == "Amber") {
                showOwnerView(sender: self)
            } else {
                showPopup(sender: self)
            }
            //performSegue(withIdentifier: "popUp", sender: self)
        }
    }
    
//    func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        if let destination = segue.destination as? PopUpViewController {
//            destination.annotation = selectedAnnotation
//        }
//    }


    //POP UP CODE
    @IBAction func showPopup(_ sender: Any) {
        let popUpVC = UIStoryboard(name:"Main", bundle: nil).instantiateViewController(withIdentifier: "disPopUpId") as! PopUpViewController
        self.addChildViewController(popUpVC)
        
        popUpVC.view.frame = self.view.frame
        self.view.addSubview(popUpVC.view)
        popUpVC.didMove(toParentViewController: self)
    }
    
    @IBAction func showDisEnd(_ sender: Any) {
        let popUpVC = UIStoryboard(name:"Main", bundle: nil).instantiateViewController(withIdentifier: "endDiscussion") as! DiscussionEndPopUpController
        self.addChildViewController(popUpVC)
        
        popUpVC.view.frame = self.view.frame
        self.view.addSubview(popUpVC.view)
        popUpVC.didMove(toParentViewController: self)
    }
    
    @IBAction func showOwnerView(_ sender: Any) {
        let popUpVC = UIStoryboard(name:"Main", bundle: nil).instantiateViewController(withIdentifier: "eventOwn") as! EventOwner
        self.addChildViewController(popUpVC)
        
        popUpVC.view.frame = self.view.frame
        self.view.addSubview(popUpVC.view)
        popUpVC.didMove(toParentViewController: self)
    }
    
    @IBAction func showArriveView(_ sender: Any) {
        let popUpVC = UIStoryboard(name:"Main", bundle: nil).instantiateViewController(withIdentifier: "arrivedBoard") as! ArrivedViewController
        self.addChildViewController(popUpVC)
        
        popUpVC.view.frame = self.view.frame
        self.view.addSubview(popUpVC.view)
        popUpVC.didMove(toParentViewController: self)
    }
    
    @IBAction func showOwnerPoints(_ sender: Any) {
        let popUpVC = UIStoryboard(name:"Main", bundle: nil).instantiateViewController(withIdentifier: "ownerPtBoard") as! OwnerPointsViewController
        self.addChildViewController(popUpVC)
        
        popUpVC.view.frame = self.view.frame
        self.view.addSubview(popUpVC.view)
        popUpVC.didMove(toParentViewController: self)
    }
    
    @IBAction func userWalk(_ sender: Any) {
        //move center of map until location = one of the events
        exLocation = CLLocationCoordinate2DMake(moveLat, moveLong)
//        var tempLoc = CLLocationCoordinate2DMake(moveLat, moveLong)
//        Map.setCenter(tempLoc, animated: true)
        showArriveView(sender: self)
    }
}

//circle view
//set center 
//IBAction (can make it hidden)
//region (geofencing) - check if cg point in map region

//        //location annotation/load in specific location code
//        let location = CLLocationCoordinate2DMake(37.876032, -122.258806)
//
//        let span = MKCoordinateSpanMake(0.005, 0.005)
//
//        let region = MKCoordinateRegion(center: location, span: span)
//
//        Map.setRegion(region, animated: true)
//
//        let annotation = MKPointAnnotation()
//        annotation.coordinate = location
//
//        Map.addAnnotation(annotation)
