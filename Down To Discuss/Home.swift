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

class Home: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet var Map: MKMapView!
    
    //required for current location
    let manager = CLLocationManager()
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[0]
        
        let span = MKCoordinateSpanMake(0.05, 0.05)
        
        let myLocation = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
        
        let region = MKCoordinateRegionMake(myLocation, span)
        
        Map.setRegion(region, animated: true)
        
        self.Map.showsUserLocation = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //current location code section
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        
        //location annotation/load in specific location code
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
        addOtherDiscussions(manager, didUpdateLocations: [manager.location!])
        
        //fix to add user's created event to the map
        if (eventCreated == 1) {
            addNewDiscussionMarker(manager, didUpdateLocations: [manager.location!])
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addOtherDiscussions(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        let nePoint = CGPoint(x: Map.bounds.origin.x + Map.bounds.size.width, y: Map.bounds.origin.y)
//        let sePoint = CGPoint(x: Map.bounds.origin.x, y: Map.bounds.origin.y + Map.bounds.size.height)
//        let neCoordinate = Map.convert(nePoint, toCoordinateFrom: Map)
//        let seCoordinate = Map.convert(sePoint, toCoordinateFrom: Map)
//        
        let location = locations.first
        if (location != nil) {
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
                let lat = (location?.coordinate.latitude)! + ((0.001 * amt) * otherAmt)
                //longitude
                let long = (location?.coordinate.longitude)! + ((0.001 * amt) * mulAmt)
                //location
                let disLocation = CLLocationCoordinate2D(latitude: lat, longitude: long)
                //pin
                let pin = MKPointAnnotation()
                //place pin
                pin.coordinate = disLocation
                //add info to that marker
                pin.title = "Dis: " + String(y)
                
                Map.addAnnotation(pin)
                y += 1
            }
        }
    }
    
    func addNewDiscussionMarker(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //to add a waypoint to the user's location if they created a discussion
        let location = locations.first
        let type = MapMarkerType(rawValue: 0) ?? .onePt
        if (location != nil) {
            let annotation = MapAnnotations(coordinate: (location?.coordinate)!, title: eventName, subtitle: "User's subtitle", type: type)
            Map.addAnnotation(annotation)
        }
    }
    
    //for custom annotations to show up
    func mapMarks(_ Map: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let annotationView = MapAnnotationsView(annotation: annotation, reuseIdentifier: "MapMarker")
        annotationView.canShowCallout = true
        return annotationView
    }


    //POP UP CODE
    @IBAction func showPopup(_ sender: Any) {
        let popUpVC = UIStoryboard(name:"Main", bundle: nil).instantiateViewController(withIdentifier: "disPopUpId") as! PopUpViewController
        self.addChildViewController(popUpVC)
        
        popUpVC.view.frame = self.view.frame
        self.view.addSubview(popUpVC.view)
        popUpVC.didMove(toParentViewController: self)
    }
    
    //map control section
//    override func viewWillLayoutSubviews() {
//        [super.viewWillLayoutSubviews]
//        self.mapView.frame = self.view.bounds
//    }
}

