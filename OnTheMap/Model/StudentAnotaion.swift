//
//  StudentAnotaion.swift
//  OnTheMap
//
//  Created by Farzad on 1/2/18.
//  Copyright © 2018 Farzad Zamani. All rights reserved.
//

import Foundation
import MapKit
class StudentAnotaion: NSObject,MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
     //var description: String
    
    init(studentLocation:StudentLocation) {
        
        self.coordinate = CLLocationCoordinate2D(latitude: studentLocation.latitude, longitude: studentLocation.longitude)
        self.title = "\(studentLocation.firstName) \(studentLocation.lastName)"
        self.subtitle = studentLocation.mediaURL
        super.init()
        
    }
    
}

