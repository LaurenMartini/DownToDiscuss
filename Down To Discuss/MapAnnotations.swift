//
//  MapAnnotations.swift
//  Down To Discuss
//
//  Created by Lauren Martini on 11/6/17.
//  Copyright © 2017 cs160_team. All rights reserved.
//

import UIKit
import MapKit

//add image info here
enum MapMarkerType: Int {
    case onePt = 0
    case fivePt
    
    func image() -> UIImage {
        switch self {
        case .onePt:
            return #imageLiteral(resourceName: "waypoint")
        case .fivePt:
            return #imageLiteral(resourceName: "waypoint")
        }
    }
}

class MapAnnotations: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    var type: MapMarkerType
    
    init(coordinate: CLLocationCoordinate2D, title: String, subtitle: String, type: MapMarkerType) {
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
        self.type = type
    }
}
