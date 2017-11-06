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
        if (eventCreated == 1) {
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2DMake(Map.userLocation.coordinate.latitude, Map.userLocation.coordinate.longitude)
            
            Map.addAnnotation(annotation)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


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

