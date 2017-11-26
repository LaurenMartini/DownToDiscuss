//
//  MapAnnotationView.swift
//  Down To Discuss
//
//  Created by Lauren Martini on 11/25/17.
//  Copyright © 2017 cs160_team. All rights reserved.
//

import UIKit
import MapKit

class MapAnnotationView: MKAnnotationView {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(annotation: MKAnnotation?, reuseIdentifier:String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        guard let mapAnnotation = self.annotation as? MapAnnotations else {return}
        
        image = mapAnnotation.type.image()
    }
}

extension MKPinAnnotationView {
    class func greyPinColor() -> UIColor {
        return UIColor.gray
    }
}
