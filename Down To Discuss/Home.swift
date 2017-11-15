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
import Firebase
import FirebaseDatabase

//global variables originally in Home

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
    
    //QUESTION: idk what is wrong here but it keeps saying expected declaration on second line...
    
    //required for current location
    let manager = CLLocationManager()
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
       // let location = locations[0]
        
        self.Map.showsUserLocation = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        ref = Database.database().reference()
        //current location code section
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest//kCLLocationAccuracyKilometer
        //manager.requestWhenInUseAuthorization()
        //temporarily adding this authorization to see if it fixes anything...
        manager.requestAlwaysAuthorization() //STILL BROKEN!!
        manager.startUpdatingLocation()
        
        let span: MKCoordinateSpan = MKCoordinateSpanMake(0.008, 0.008)
        
        //        let myLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
        
        //let exLocation = CLLocationCoordinate2DMake(37.876032, -122.258806)
        
        if (currHost == 1) {
            exLocation = eventList[2].location
        }
        
        let region: MKCoordinateRegion = MKCoordinateRegionMake(exLocation, span)
        
        Map.setRegion(region, animated: false)
        addOtherDiscussions()
        
        //fix to add user's created event to the map
        if (eventCreated == 1) {
            addNewDiscussionMarker()
        }
        
        let statusRef = ref?.child("status")
        
        statusRef?.observe(DataEventType.value, with: { (snapshot) in
            
            // do config based off status
            let status = snapshot.value as? String ?? ""
            
            //switch statement based on the status
            switch status {
            case "userInform":
                //if user is host get notified that a guest is on their way
                if (currHost == 1) {
                    //display guest on their way window
                }
                if (currHost == 0) {
                    self.userWalk(sender:self)
                    self.showArriveView(sender: self)
                }
                break
            case "userReqJoin":
                //if user is host get notified that guest is here and wants to join
                if (currHost == 1) {
                    //notification that guest is here
                }
                break
            case "guestConfirmed":
                //if user is guest -> show accepted window and start timer on both windows
                if (currHost == 0) {
                    //show accepted window
                }
                //start timer? Is this even needed?
                break
            case "guestRejected":
                //if user is guest and host rejected them
                if (currHost == 0) {
                    //show rejected window
                }
                break
            case "discussionEnded":
                //both users are notified that event has ended
                //guest gets rating screen and points
                //host gets points
                if (currHost == 1) {
                    self.showOwnerPoints(sender: self)
                } else {
                    self.showDisEnd(sender: self)
                }
                break
            case "":
                break
            default:
                print("no valid status!")
            }
        })
        
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//
//    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addOtherDiscussions() {
        let location = exLocation //was locations.first for current Location
        var y = 0
        while y < 5 {
            //location
            let disLocation = eventList[y].location
            //pin
            let pin = MapAnnotations(coordinate: disLocation, title: eventList[y].discussionTitle, subtitle: "Fun Topic: " + eventList[y].funTopic + "\n Intense Topic: " + eventList[y].intenseTopic)
            
            //store 2nd event as a temp for first prototype iteration
            if (y == 2) {
                moveLat = eventList[y].location.latitude
                moveLong = eventList[y].location.longitude
            }
            Map.addAnnotation(pin)
            y += 1
        }
    }
    
    func addNewDiscussionMarker() {
        //to add a waypoint to the user's location if they created a discussion
        let location = exLocation
        
        let newEvent = Events(user: currentUser, discussionTitle: eventName, location:  CLLocationCoordinate2DMake(location.latitude, location.longitude), funTopic: "", intenseTopic: "", description: "", points: 0)
        
        let annotation = MapAnnotations(coordinate: location, title: eventName, subtitle: "")
        Map.addAnnotation(annotation)
        
        eventList.append(newEvent)
    }
    
    /* ADD THIS FUNCTION CALL??
     discussionReached()*/
    func discussionReached() {
        //show alert when within range of location
        let location = exLocation
        
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
            showPopup(sender:self)
        }
    }

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
        let tempLoc = CLLocationCoordinate2DMake(moveLat, moveLong)
        Map.setCenter(tempLoc, animated: true)
    }
}

/* CODE DUMP - OLD PARTS AND PIECES */

//OLD CODE - CAN DELETE
//        let event1 = MapAnnotations(coordinate: CLLocationCoordinate2D(latitude: 37.3358656, longitude: -122.030848), title: "Event 1", subtitle: "food")
//
//        Map.addAnnotation(event1)

//        if (CLLocationManager.locationServicesEnabled()) {
//            switch (CLLocationManager.authorizationStatus()) {
//            case .authorizedWhenInUse:
//                print("authorized")
//                break
//            case .notDetermined:
//                print("not determined")
//                break
//            case .restricted:
//                print("restricted")
//                break
//            case .denied:
//                print("denied")
//                break
//            default:
//                print("nonsense")
//            }
//        }

//THIS WAS USED FOR WHEN CURRENT LOCATION WAS ACTUALLY USED!
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

//old coordinates
//            var mulAmt = 1.0
//            var otherAmt = 1.0
//            if (y % 2 == 0) {
//                mulAmt = -1.0
//            }
//            if (y % 2 != 0) {
//                otherAmt = -1.0
//            }
//            var amt = Double(y)
//            if (y == 0) {
//                amt = 6.0
//            }
//            //latitude
//            let lat = (location.latitude) + ((0.001 * amt) * otherAmt)
//            //userLat[y] = lat
//            //longitude
//            let long = (location.longitude) + ((0.001 * amt) * mulAmt)
//            //userLong[y] = long
//
//place pin
//                pin.coordinate = disLocation
//                //add info to that marker
//                pin.title = discussionTitle[y]
//                pin.subtitle = funT[y] + ", " + intenseT[y]

//IN ADD DISCUSSION
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

//IN DISCUSSION REACHED
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

//SEGUE PERFORM FUNCTION
//    func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        if let destination = segue.destination as? PopUpViewController {
//            destination.annotation = selectedAnnotation
//        }
//    }

//SEGUE PERFORM CALL INSIDE MAP VIEW
//performSegue(withIdentifier: "popUp", sender: self)

//WORKS NOW BUT OLD VERSION WHEN I HAD A CURRENT LOCATION
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


//MISC
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
