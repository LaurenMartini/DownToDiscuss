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

protocol HandleMapSearch {
    func dropPinZoomIn(event: Events)
}

//global variables originally in Home

var curLat = 0.0
var curLong = 0.0
var disNum = 0
var exLocation = CLLocationCoordinate2DMake(37.876032, -122.258806)
var moveLat = 0.0
var moveLong = 0.0
var userWalked = 0
var startTime = 0
var filtered = 0

// userPos = UIImage(named: "blueCircle.png")

class Home: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet var Map: MKMapView!
    
    //required for current location
    let manager = CLLocationManager()
    
    //create property for the UISearchController
    var resultSearchController:UISearchController? = nil
    
    //for protocal for map search
    var selectedPin:MKPlacemark? = nil
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
       // let location = locations[0]
        
        //self.Map.showsUserLocation = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        ref = Database.database().reference()
        //current location code section
        manager.delegate = self
        //manager.desiredAccuracy = kCLLocationAccuracyBest//kCLLocationAccuracyKilometer
        //manager.requestWhenInUseAuthorization()
        //temporarily adding this authorization to see if it fixes anything...
        //manager.requestAlwaysAuthorization() //STILL BROKEN!!
        //manager.startUpdatingLocation()
        
        let span: MKCoordinateSpan = MKCoordinateSpanMake(0.008, 0.008)
        
        //        let myLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
        
        //let exLocation = CLLocationCoordinate2DMake(37.876032, -122.258806)
        
        if (currHost == 1) {
            exLocation = eventList[2].location
        }
        
        let region: MKCoordinateRegion = MKCoordinateRegionMake(exLocation, span)
        
        Map.setRegion(region, animated: false)
//        if #available(iOS 11.0, *) {
//            Map.register(MapAnnotationView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
//        }
        addOtherDiscussions()
        
//        //set up search results table
        let locationSearchTable = storyboard!.instantiateViewController(withIdentifier: "LocationSearchTable") as! LocationSearchTable
        resultSearchController = UISearchController(searchResultsController: locationSearchTable)
        resultSearchController?.searchResultsUpdater = locationSearchTable as UISearchResultsUpdating
        
        //set up search bar
        let searchBar = resultSearchController!.searchBar
        searchBar.sizeToFit()
        searchBar.placeholder = "Search for topic"
        navigationItem.titleView = resultSearchController?.searchBar
        
        //configure the UISearchController appearance
        resultSearchController?.hidesNavigationBarDuringPresentation = false
        resultSearchController?.dimsBackgroundDuringPresentation = true
        definesPresentationContext = true
        
        //passes a handle of mapView from the main View Controller onto the locationSearchTable
        locationSearchTable.mapView = Map
        
        //pass controller to locationSearchTable
        locationSearchTable.getControllerCreatedInHome(sController: resultSearchController!)
        
        //handleMapDelegate
        locationSearchTable.handleMapSearchDelegate = self
        
        //fix to add user's created event to the map
        if (eventCreated == 1) {
            addNewDiscussionMarker()
        }
        
        let statusRef = ref?.child("status")
        
        if (startWalk == 0) {
            ref?.child("status").setValue("")
        }
        
        statusRef?.observe(DataEventType.value, with: { (snapshot) in
            
            // do config based off status
            let status = snapshot.value as? String ?? ""
            
            //switch statement based on the status
            switch status {
            case "profileClicked":
                //guest gets to view host profile
                if (currHost == 0) {
                    //self.showHostProfile(sender: self)
                    self.navigationController?.setNavigationBarHidden(true, animated: true)
                    self.navigationItem.titleView = nil
                    self.showHostInfo(sender: self)
                }
                break
            case "lookAtInfo":
                self.navigationController?.setNavigationBarHidden(true, animated: true)
                self.navigationItem.titleView = nil
                break
            case "returnToInfo":
                if (currHost == 0) {
                    self.showPopup(sender: self)
                }
                break
            case "checkReviews":
                if (currHost == 0) {
                    self.showReviewPage(sender: self)
                }
                break
            case "resetPins":
                self.navigationController?.setNavigationBarHidden(false, animated: true)
                self.navigationItem.titleView = self.resultSearchController?.searchBar
                self.addOtherDiscussions()
                break
            case "userInform":
                //if user is host get notified that a guest is on their way
                if (currHost == 1) {
                    self.showHostNotify(sender: self)
                    if (currentDis > -1) {
                        eventList[currentDis].usersInterested += 1
                    }
                }
                if (currHost == 0) {
                    //self.discussionReached()
                    self.goToLocation(num: currentDis)
                }
//                if (currHost == 0) {
//                    self.userWalk(sender:self)
//                    self.showArriveView(sender: self)
//                }
                break
            case "userReqJoin":
                //if user is host get notified that guest is here and wants to join
                if (currHost == 1) {
                    //notification that guest is here
                    self.showHostConfirm(sender: self)
                }
                break
            case "guestConfirmed":
                //if user is guest -> show accepted window and start timer on both windows
                self.showDiscussionRunning(sender: self)
                break
            case "guestRejected":
                //if user is guest and host rejected them
                if (currHost == 0) {
                    self.showUserRejected(sender: self)
                }
                break
            case "discussionEnded":
                //both users are notified that event has ended
                //guest gets rating screen and points
                //host gets points
                if (currHost == 1) {
                    self.showOwnerPoints(sender: self)
                } else {
                    currentUser.totalPoints += eventList[currentDis].points
                    print("currentDis: " + (String)(currentDis))
                    self.showDisEnd(sender: self)
                }
                break
            case "":
                self.navigationController?.setNavigationBarHidden(false, animated: true)
                self.navigationItem.titleView = self.resultSearchController?.searchBar
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
        _ = exLocation //was locations.first for current Location
        var y = 0
        while y < 5 {
            //location
            let disLocation = eventList[y].location
            //pin
            let pin = MapAnnotations(coordinate: disLocation, title: eventList[y].discussionTitle, subtitle: "Fun Topic: " + eventList[y].funTopic + "\n Intense Topic: " + eventList[y].intenseTopic, type: MapMarkerType(rawValue: eventList[y].points)!)
            
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
        
        let newEvent = Events(user: currentUser, discussionTitle: eventName, location:  CLLocationCoordinate2DMake(location.latitude, location.longitude), funTopic: "", intenseTopic: "", description: "", points: 0, usersInterested: 0, usersThere: 0)
        
        let annotation = MapAnnotations(coordinate: location, title: eventName, subtitle: "", type: MapMarkerType(rawValue: 1)!)
        Map.addAnnotation(annotation)
        
        eventList.append(newEvent)
    }
    
    func goToLocation(num: Int) {
        let startLoc = CLLocationCoordinate2DMake(exLocation.latitude, exLocation.longitude)
        //switch on int and change route depending on exLocation start
        if (startLoc.latitude == 37.876032 && startLoc.longitude == -122.258806) {
            switch num {
            case 0:
                //route to Food & Stuff from start
                //first point on route
                exLocation = CLLocationCoordinate2DMake(37.875362, -122.258330)
                let span: MKCoordinateSpan = MKCoordinateSpanMake(0.008, 0.008)
                var region: MKCoordinateRegion = MKCoordinateRegionMake(exLocation, span)
                Map.setRegion(region, animated: false)
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    //next point on route
                    exLocation.latitude = eventList[num].location.latitude
                    exLocation.longitude = eventList[num].location.longitude
                    region = MKCoordinateRegionMake(exLocation, span)
                    self.Map.setRegion(region, animated: false)
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
                    //next point on route
                    self.showArriveView(sender: self)
                }
                break
            case 1:
                //route to Dogs from start
                exLocation = CLLocationCoordinate2DMake(37.876323, -122.258512)
                let span: MKCoordinateSpan = MKCoordinateSpanMake(0.008, 0.008)
                var region: MKCoordinateRegion = MKCoordinateRegionMake(exLocation, span)
                Map.setRegion(region, animated: false)
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    exLocation.latitude = 37.877212
                    exLocation.longitude = -122.258716
                    region = MKCoordinateRegionMake(exLocation, span)
                    self.Map.setRegion(region, animated: false)
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
                    exLocation.latitude = 37.877373
                    exLocation.longitude = -122.257182
                    region = MKCoordinateRegionMake(exLocation, span)
                    self.Map.setRegion(region, animated: false)
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 6.0) {
                    exLocation.latitude = 37.877424
                    exLocation.longitude = -122.256903
                    region = MKCoordinateRegionMake(exLocation, span)
                    self.Map.setRegion(region, animated: false)
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 8.0) {
                    exLocation.latitude = 37.878025
                    exLocation.longitude = -122.257042
                    region = MKCoordinateRegionMake(exLocation, span)
                    self.Map.setRegion(region, animated: false)
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 10.0) {
                    //last point on route
                    exLocation.latitude = eventList[num].location.latitude
                    exLocation.longitude = eventList[num].location.longitude
                    region = MKCoordinateRegionMake(exLocation, span)
                    self.Map.setRegion(region, animated: false)
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 12.0) {
                    //next point on route
                    self.showArriveView(sender: self)
                }
                break
            case 2:
                //route to Free Movie!! from start
                //first point on route
                exLocation = CLLocationCoordinate2DMake(37.875362, -122.258330)
                let span: MKCoordinateSpan = MKCoordinateSpanMake(0.008, 0.008)
                var region: MKCoordinateRegion = MKCoordinateRegionMake(exLocation, span)
                Map.setRegion(region, animated: false)
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    exLocation.latitude = 37.874985
                    exLocation.longitude = -122.260121
                    region = MKCoordinateRegionMake(exLocation, span)
                    self.Map.setRegion(region, animated: false)
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
                    exLocation.latitude = 37.874375
                    exLocation.longitude = -122.261001
                    region = MKCoordinateRegionMake(exLocation, span)
                    self.Map.setRegion(region, animated: false)
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 6.0) {
                    exLocation.latitude = 37.873426
                    exLocation.longitude = -122.261312
                    region = MKCoordinateRegionMake(exLocation, span)
                    self.Map.setRegion(region, animated: false)
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 8.0) {
                    //last point on route
                    exLocation.latitude = eventList[num].location.latitude
                    exLocation.longitude = eventList[num].location.longitude
                    region = MKCoordinateRegionMake(exLocation, span)
                    self.Map.setRegion(region, animated: false)
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 10.0) {
                    //next point on route
                    self.showArriveView(sender: self)
                }
                break
            case 3:
                //route to Substances and Songs from start
                //just do start and end
                exLocation = CLLocationCoordinate2DMake(eventList[num].location.latitude, eventList[num].location.longitude)
                let span: MKCoordinateSpan = MKCoordinateSpanMake(0.008, 0.008)
                let region: MKCoordinateRegion = MKCoordinateRegionMake(exLocation, span)
                Map.setRegion(region, animated: false)
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
                    //next point on route
                    self.showArriveView(sender: self)
                }
                break
            case 4:
                //route to Coffee Chat from start
                exLocation = CLLocationCoordinate2DMake(37.875362, -122.258330)
                let span: MKCoordinateSpan = MKCoordinateSpanMake(0.008, 0.008)
                var region: MKCoordinateRegion = MKCoordinateRegionMake(exLocation, span)
                Map.setRegion(region, animated: false)
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    exLocation.latitude = 37.874985
                    exLocation.longitude = -122.260121
                    region = MKCoordinateRegionMake(exLocation, span)
                    self.Map.setRegion(region, animated: false)
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
                    exLocation.latitude = 37.874375
                    exLocation.longitude = -122.261001
                    region = MKCoordinateRegionMake(exLocation, span)
                    self.Map.setRegion(region, animated: false)
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 6.0) {
                    exLocation.latitude = 37.873426
                    exLocation.longitude = -122.261312
                    region = MKCoordinateRegionMake(exLocation, span)
                    self.Map.setRegion(region, animated: false)
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 8.0) {
                    exLocation.latitude = 37.872745
                    exLocation.longitude = -122.261473
                    region = MKCoordinateRegionMake(exLocation, span)
                    self.Map.setRegion(region, animated: false)
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 10.0) {
                    exLocation.latitude = 37.872203
                    exLocation.longitude = -122.261570
                    region = MKCoordinateRegionMake(exLocation, span)
                    self.Map.setRegion(region, animated: false)
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 12.0) {
                    //last point on route
                    exLocation.latitude = eventList[num].location.latitude
                    exLocation.longitude = eventList[num].location.longitude
                    region = MKCoordinateRegionMake(exLocation, span)
                    self.Map.setRegion(region, animated: false)
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 14.0) {
                    //next point on route
                    self.showArriveView(sender: self)
                }
                break
            default:
                print("invalid num")
            }
        } else if (startLoc.latitude == 37.875032 && startLoc.longitude == -122.257806) {
            //start at Food & Stuff
            //go to free movies or coffee chat
            //all others -> directly go to location
            switch num {
            case 1:
                //go directly to Dogs
                exLocation = CLLocationCoordinate2DMake(eventList[num].location.latitude, eventList[num].location.longitude)
                let span: MKCoordinateSpan = MKCoordinateSpanMake(0.008, 0.008)
                let region: MKCoordinateRegion = MKCoordinateRegionMake(exLocation, span)
                Map.setRegion(region, animated: false)
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
                    //next point on route
                    self.showArriveView(sender: self)
                }
                break
            case 2:
                //walk to Free Movie!!
                //first point on route
                exLocation = CLLocationCoordinate2DMake(37.874985, -122.260121)
                let span: MKCoordinateSpan = MKCoordinateSpanMake(0.008, 0.008)
                var region: MKCoordinateRegion = MKCoordinateRegionMake(exLocation, span)
                Map.setRegion(region, animated: false)
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    exLocation.latitude = 37.874375
                    exLocation.longitude = -122.261001
                    region = MKCoordinateRegionMake(exLocation, span)
                    self.Map.setRegion(region, animated: false)
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
                    exLocation.latitude = 37.873426
                    exLocation.longitude = -122.261312
                    region = MKCoordinateRegionMake(exLocation, span)
                    self.Map.setRegion(region, animated: false)
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 6.0) {
                    //last point on route
                    exLocation.latitude = eventList[num].location.latitude
                    exLocation.longitude = eventList[num].location.longitude
                    region = MKCoordinateRegionMake(exLocation, span)
                    self.Map.setRegion(region, animated: false)
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 8.0) {
                    //next point on route
                    self.showArriveView(sender: self)
                }
                break
            case 3:
                //go directly to Substances and Songs
                exLocation = CLLocationCoordinate2DMake(eventList[num].location.latitude, eventList[num].location.longitude)
                let span: MKCoordinateSpan = MKCoordinateSpanMake(0.008, 0.008)
                let region: MKCoordinateRegion = MKCoordinateRegionMake(exLocation, span)
                Map.setRegion(region, animated: false)
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
                    //next point on route
                    self.showArriveView(sender: self)
                }
                break
            case 4:
                //walk to Coffee Chat
                exLocation = CLLocationCoordinate2DMake(37.874985, -122.260121)
                let span: MKCoordinateSpan = MKCoordinateSpanMake(0.008, 0.008)
                var region: MKCoordinateRegion = MKCoordinateRegionMake(exLocation, span)
                Map.setRegion(region, animated: false)
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
                    exLocation.latitude = 37.874375
                    exLocation.longitude = -122.261001
                    region = MKCoordinateRegionMake(exLocation, span)
                    self.Map.setRegion(region, animated: false)
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 6.0) {
                    exLocation.latitude = 37.873426
                    exLocation.longitude = -122.261312
                    region = MKCoordinateRegionMake(exLocation, span)
                    self.Map.setRegion(region, animated: false)
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 8.0) {
                    exLocation.latitude = 37.872745
                    exLocation.longitude = -122.261473
                    region = MKCoordinateRegionMake(exLocation, span)
                    self.Map.setRegion(region, animated: false)
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 10.0) {
                    exLocation.latitude = 37.872203
                    exLocation.longitude = -122.261570
                    region = MKCoordinateRegionMake(exLocation, span)
                    self.Map.setRegion(region, animated: false)
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 12.0) {
                    //last point on route
                    exLocation.latitude = eventList[num].location.latitude
                    exLocation.longitude = eventList[num].location.longitude
                    region = MKCoordinateRegionMake(exLocation, span)
                    self.Map.setRegion(region, animated: false)
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 14.0) {
                    //next point on route
                    self.showArriveView(sender: self)
                }
                break
            default:
                print("invalid num")
            }
        } else if (startLoc.latitude == 37.878032 && startLoc.longitude == -122.256806) {
            //start at Dogs
            //go to any directly
            switch num {
            case 0:
                exLocation = CLLocationCoordinate2DMake(eventList[num].location.latitude, eventList[num].location.longitude)
                let span: MKCoordinateSpan = MKCoordinateSpanMake(0.008, 0.008)
                let region: MKCoordinateRegion = MKCoordinateRegionMake(exLocation, span)
                Map.setRegion(region, animated: false)
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
                    //next point on route
                    self.showArriveView(sender: self)
                }
                break
            case 2:
                exLocation = CLLocationCoordinate2DMake(eventList[num].location.latitude, eventList[num].location.longitude)
                let span: MKCoordinateSpan = MKCoordinateSpanMake(0.008, 0.008)
                let region: MKCoordinateRegion = MKCoordinateRegionMake(exLocation, span)
                Map.setRegion(region, animated: false)
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
                    //next point on route
                    self.showArriveView(sender: self)
                }
                break
            case 3:
                exLocation = CLLocationCoordinate2DMake(eventList[num].location.latitude, eventList[num].location.longitude)
                let span: MKCoordinateSpan = MKCoordinateSpanMake(0.008, 0.008)
                let region: MKCoordinateRegion = MKCoordinateRegionMake(exLocation, span)
                Map.setRegion(region, animated: false)
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
                    //next point on route
                    self.showArriveView(sender: self)
                }
                break
            case 4:
                exLocation = CLLocationCoordinate2DMake(eventList[num].location.latitude, eventList[num].location.longitude)
                let span: MKCoordinateSpan = MKCoordinateSpanMake(0.008, 0.008)
                let region: MKCoordinateRegion = MKCoordinateRegionMake(exLocation, span)
                Map.setRegion(region, animated: false)
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
                    //next point on route
                    self.showArriveView(sender: self)
                }
                break
            default:
                exLocation = CLLocationCoordinate2DMake(eventList[num].location.latitude, eventList[num].location.longitude)
                let span: MKCoordinateSpan = MKCoordinateSpanMake(0.008, 0.008)
                let region: MKCoordinateRegion = MKCoordinateRegionMake(exLocation, span)
                Map.setRegion(region, animated: false)
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
                    //next point on route
                    self.showArriveView(sender: self)
                }
                print("invalid num")
            }
        } else if (startLoc.latitude == 37.873032 && startLoc.longitude == -122.261806) {
            //start at Free Movie!!!
            //go to Food & Stuff or Coffee Chat
            //go to all others directly
            switch num {
            case 0:
                //first point on route
                exLocation = CLLocationCoordinate2DMake(37.873426, -122.261312)
                let span: MKCoordinateSpan = MKCoordinateSpanMake(0.008, 0.008)
                var region: MKCoordinateRegion = MKCoordinateRegionMake(exLocation, span)
                Map.setRegion(region, animated: false)
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    exLocation.latitude = 37.874375
                    exLocation.longitude = -122.261001
                    region = MKCoordinateRegionMake(exLocation, span)
                    self.Map.setRegion(region, animated: false)
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
                    exLocation.latitude = 37.874985
                    exLocation.longitude = -122.260121
                    region = MKCoordinateRegionMake(exLocation, span)
                    self.Map.setRegion(region, animated: false)
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 6.0) {
                    //last point on route
                    exLocation.latitude = eventList[num].location.latitude
                    exLocation.longitude = eventList[num].location.longitude
                    region = MKCoordinateRegionMake(exLocation, span)
                    self.Map.setRegion(region, animated: false)
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 8.0) {
                    //next point on route
                    self.showArriveView(sender: self)
                }
                break
            case 1:
                exLocation = CLLocationCoordinate2DMake(eventList[num].location.latitude, eventList[num].location.longitude)
                let span: MKCoordinateSpan = MKCoordinateSpanMake(0.008, 0.008)
                let region: MKCoordinateRegion = MKCoordinateRegionMake(exLocation, span)
                Map.setRegion(region, animated: false)
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
                    //next point on route
                    self.showArriveView(sender: self)
                }
                break
            case 3:
                exLocation = CLLocationCoordinate2DMake(eventList[num].location.latitude, eventList[num].location.longitude)
                let span: MKCoordinateSpan = MKCoordinateSpanMake(0.008, 0.008)
                let region: MKCoordinateRegion = MKCoordinateRegionMake(exLocation, span)
                Map.setRegion(region, animated: false)
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
                    //next point on route
                    self.showArriveView(sender: self)
                }
                break
            case 4:
                //first point on route
                exLocation = CLLocationCoordinate2DMake(37.872203, -122.261570)
                let span: MKCoordinateSpan = MKCoordinateSpanMake(0.008, 0.008)
                var region: MKCoordinateRegion = MKCoordinateRegionMake(exLocation, span)
                Map.setRegion(region, animated: false)
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    exLocation.latitude = 37.872745
                    exLocation.longitude = -122.261473
                    region = MKCoordinateRegionMake(exLocation, span)
                    self.Map.setRegion(region, animated: false)
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
                    //last point on route
                    exLocation.latitude = eventList[num].location.latitude
                    exLocation.longitude = eventList[num].location.longitude
                    region = MKCoordinateRegionMake(exLocation, span)
                    self.Map.setRegion(region, animated: false)
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 6.0) {
                    //next point on route
                    self.showArriveView(sender: self)
                }
                break
            default:
                print("invalid num")
            }
        } else if (startLoc.latitude == 37.880032 && startLoc.longitude == -122.254806) {
            //start at substances and songs
            //go to all directly
            switch num {
            case 0:
                exLocation = CLLocationCoordinate2DMake(eventList[num].location.latitude, eventList[num].location.longitude)
                let span: MKCoordinateSpan = MKCoordinateSpanMake(0.008, 0.008)
                let region: MKCoordinateRegion = MKCoordinateRegionMake(exLocation, span)
                Map.setRegion(region, animated: false)
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
                    //next point on route
                    self.showArriveView(sender: self)
                }
                break
            case 1:
                exLocation = CLLocationCoordinate2DMake(eventList[num].location.latitude, eventList[num].location.longitude)
                let span: MKCoordinateSpan = MKCoordinateSpanMake(0.008, 0.008)
                let region: MKCoordinateRegion = MKCoordinateRegionMake(exLocation, span)
                Map.setRegion(region, animated: false)
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
                    //next point on route
                    self.showArriveView(sender: self)
                }
                break
            case 2:
                exLocation = CLLocationCoordinate2DMake(eventList[num].location.latitude, eventList[num].location.longitude)
                let span: MKCoordinateSpan = MKCoordinateSpanMake(0.008, 0.008)
                let region: MKCoordinateRegion = MKCoordinateRegionMake(exLocation, span)
                Map.setRegion(region, animated: false)
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
                    //next point on route
                    self.showArriveView(sender: self)
                }
                break
            case 4:
                exLocation = CLLocationCoordinate2DMake(eventList[num].location.latitude, eventList[num].location.longitude)
                let span: MKCoordinateSpan = MKCoordinateSpanMake(0.008, 0.008)
                let region: MKCoordinateRegion = MKCoordinateRegionMake(exLocation, span)
                Map.setRegion(region, animated: false)
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
                    //next point on route
                    self.showArriveView(sender: self)
                }
                break
            default:
                print("invalid num")
            }
        } else if (startLoc.latitude == 37.872313 && startLoc.longitude == -122.260958) {
            //start at Coffee Chat
            //go to Free Movies or Food & Stuff
            //go to all others directly
            switch num {
            case 0:
                //first point on route
                exLocation = CLLocationCoordinate2DMake(37.872745, -122.261473)
                let span: MKCoordinateSpan = MKCoordinateSpanMake(0.008, 0.008)
                var region: MKCoordinateRegion = MKCoordinateRegionMake(exLocation, span)
                Map.setRegion(region, animated: false)
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    exLocation.latitude = 37.872203
                    exLocation.longitude = -122.261570
                    region = MKCoordinateRegionMake(exLocation, span)
                    self.Map.setRegion(region, animated: false)
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
                    exLocation.latitude = 37.873426
                    exLocation.longitude = -122.261312
                    region = MKCoordinateRegionMake(exLocation, span)
                    self.Map.setRegion(region, animated: false)
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 6.0) {
                    exLocation.latitude = 37.874375
                    exLocation.longitude = -122.261001
                    region = MKCoordinateRegionMake(exLocation, span)
                    self.Map.setRegion(region, animated: false)
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 8.0) {
                    exLocation.latitude = 37.874985
                    exLocation.longitude = -122.260121
                    region = MKCoordinateRegionMake(exLocation, span)
                    self.Map.setRegion(region, animated: false)
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 10.0) {
                    //last point on route
                    exLocation.latitude = eventList[num].location.latitude
                    exLocation.longitude = eventList[num].location.longitude
                    region = MKCoordinateRegionMake(exLocation, span)
                    self.Map.setRegion(region, animated: false)
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 12.0) {
                    //next point on route
                    self.showArriveView(sender: self)
                }
                break
            case 1:
                exLocation = CLLocationCoordinate2DMake(eventList[num].location.latitude, eventList[num].location.longitude)
                let span: MKCoordinateSpan = MKCoordinateSpanMake(0.008, 0.008)
                let region: MKCoordinateRegion = MKCoordinateRegionMake(exLocation, span)
                Map.setRegion(region, animated: false)
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
                    //next point on route
                    self.showArriveView(sender: self)
                }
                break
            case 2:
                //first point on route
                exLocation = CLLocationCoordinate2DMake(37.872745, -122.261473)
                let span: MKCoordinateSpan = MKCoordinateSpanMake(0.008, 0.008)
                var region: MKCoordinateRegion = MKCoordinateRegionMake(exLocation, span)
                Map.setRegion(region, animated: false)
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    exLocation.latitude = 37.872203
                    exLocation.longitude = -122.261570
                    region = MKCoordinateRegionMake(exLocation, span)
                    self.Map.setRegion(region, animated: false)
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
                    //last point on route
                    exLocation.latitude = eventList[num].location.latitude
                    exLocation.longitude = eventList[num].location.longitude
                    region = MKCoordinateRegionMake(exLocation, span)
                    self.Map.setRegion(region, animated: false)
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 6.0) {
                    //next point on route
                    self.showArriveView(sender: self)
                }
                break
            case 3:
                exLocation = CLLocationCoordinate2DMake(eventList[num].location.latitude, eventList[num].location.longitude)
                let span: MKCoordinateSpan = MKCoordinateSpanMake(0.008, 0.008)
                let region: MKCoordinateRegion = MKCoordinateRegionMake(exLocation, span)
                Map.setRegion(region, animated: false)
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
                    //next point on route
                    self.showArriveView(sender: self)
                }
                break
            default:
                print("invalid num")
            }
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView?{
        let identifier = "MapAnnotations"
        
        if annotation is MapAnnotations {
            var view: MKAnnotationView? = nil
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
            if annotationView == nil {
                annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                annotationView!.canShowCallout = true
                
                let btn = UIButton(type: .detailDisclosure)
                annotationView!.rightCalloutAccessoryView = btn
                view = annotationView
            } else {
                annotationView!.annotation = annotation
                view = annotationView
            }
            
            return view
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
            ref?.child("status").setValue("lookAtInfo")
            showPopup(sender:self)
        }
    }
    
    //SEARCH BAR CODE - MOVED TO LOCATION SEARCH TABLE
    func searchBarIsEmpty() -> Bool {
        return resultSearchController?.searchBar.text?.isEmpty ?? true
    }
    
    func isFiltering() -> Bool {
//        ref?.child("status").setValue("filterResults")
        return (resultSearchController?.isActive)! && !searchBarIsEmpty()
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
    
    @IBAction func showHostInfo(_ sender: Any) {
        let popUpVC = UIStoryboard(name:"Main", bundle: nil).instantiateViewController(withIdentifier: "hostProfileBoard") as! HostInfoController
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
    
    @IBAction func showHostConfirm(_ sender: Any) {
        let popUpVC = UIStoryboard(name:"Main", bundle: nil).instantiateViewController(withIdentifier: "hostConfirm") as! HostConfirmController
        self.addChildViewController(popUpVC)
        
        popUpVC.view.frame = self.view.frame
        self.view.addSubview(popUpVC.view)
        popUpVC.didMove(toParentViewController: self)
    }
    
    @IBAction func showHostNotify(_ sender: Any) {
        let popUpVC = UIStoryboard(name:"Main", bundle: nil).instantiateViewController(withIdentifier: "hostNotified") as! HostNotifiedController
        self.addChildViewController(popUpVC)
        
        popUpVC.view.frame = self.view.frame
        self.view.addSubview(popUpVC.view)
        popUpVC.didMove(toParentViewController: self)
    }
    
    @IBAction func showUserRejected(_ sender: Any) {
        let popUpVC = UIStoryboard(name:"Main", bundle: nil).instantiateViewController(withIdentifier: "userRejected") as! UserRejectedController
        self.addChildViewController(popUpVC)
        
        popUpVC.view.frame = self.view.frame
        self.view.addSubview(popUpVC.view)
        popUpVC.didMove(toParentViewController: self)
    }
    
    @IBAction func showDiscussionRunning(_ sender: Any) {
        let popUpVC = UIStoryboard(name:"Main", bundle: nil).instantiateViewController(withIdentifier: "discussionRunning") as! DiscussionInProgressController
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
    
    @IBAction func showHostProfile(_ sender: Any) {
        let popUpVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "hostProfileBoard") as! HostProfileController
        self.addChildViewController(popUpVC)
        
        if popUpVC.view != nil {
            popUpVC.view.frame = self.view.frame
            self.view.addSubview(popUpVC.view)
            popUpVC.didMove(toParentViewController: self)
        } else {
            print("invalid")
        }
    }
    
    @IBAction func showReviewPage(_ sender: Any) {
        let popUpVC = UIStoryboard(name:"Main", bundle: nil).instantiateViewController(withIdentifier: "hostReviewBoard") as! ReviewViewController
        self.addChildViewController(popUpVC)
        
        popUpVC.view.frame = self.view.frame
        self.view.addSubview(popUpVC.view)
        popUpVC.didMove(toParentViewController: self)
    }
 }

extension MKPinAnnotationView {
    class func greyPinColor(num: Int) -> UIColor {
        if (num == 5) {
            return UIColor.green
        }
        return UIColor.gray
    }
}

extension Home: HandleMapSearch {
    func dropPinZoomIn(event: Events) {
        //clear existing pins
        Map.removeAnnotations(Map.annotations)
        let pin = MapAnnotations(coordinate: event.location, title: event.discussionTitle, subtitle: "Fun Topic: " + event.funTopic + "\n Intense Topic: " + event.intenseTopic, type: MapMarkerType(rawValue: event.points)!)
        Map.addAnnotation(pin)
        //changes annotation and zoom to search result which isn't what is desired right now
//        let annotation = MKPointAnnotation()
//        annotation.coordinate = event.location
//        annotation.title = event.discussionTitle
//        annotation.subtitle = "Fun Topic: " + event.funTopic + ", Intense Topic: " + event.intenseTopic
//        Map.addAnnotation(annotation)
//        let span = MKCoordinateSpanMake(0.008, 0.008)
//        let region = MKCoordinateRegionMake(event.location, span)
//        Map.setRegion(region, animated: false)
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


//OLD DISCUSSION REACHED ATTEMPTS
//    func discussionReached() {
//        var num = 0
//
//        while (num < eventList.count) {
//            if (exLocation.latitude == eventList[num].location.latitude && exLocation.longitude == eventList[num].location.longitude) {
//                disNum = num
//
//                self.showArriveView(sender: self)
//                break
//            }
//            num += 1
//        }
//    }
/* ADD THIS FUNCTION CALL??
 discussionReached()*/
//    func discussionReached() {
//        //show alert when within range of location
//        let location = exLocation
//
//        var num = 0
//
//        while (num < 5) {
//            if (eventList[num].location.latitude == location.latitude && eventList[num].location.longitude == location.longitude) {
//                let ac = UIAlertController(title: "You have arrived!", message: "Ready to discuss?", preferredStyle: .alert)
//                ac.addAction(UIAlertAction(title: "Discuss", style: .default, handler: {(action) in ac.dismiss(animated: true, completion: nil)
//                    //do something here
//                }))
//                ac.addAction(UIAlertAction(title: "Cancel", style: .default, handler: {(action) in ac.dismiss(animated: true, completion: nil)
//                    //do something here
//                }))
//                disNum = num
//                break
//            }
//            num += 1
//        }
//    }
