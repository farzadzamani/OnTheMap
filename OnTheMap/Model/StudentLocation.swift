//
//  StudentLocation.swift
//  OnTheMap
//
//  Created by Farzad on 12/30/17.
//  Copyright © 2017 Farzad Zamani. All rights reserved.
//
import Foundation
import MapKit

struct StudentLocation {
    
    var objectId:String?
    //Populate With UDACITY ACCOUNT ID
    var uniqueKey:String?
    var firstName:String
    var lastName:String
    var mapString:String?
    var mediaURL:String
    var latitude:Double
    var longitude:Double
    var fullName:String?
    
}

extension StudentLocation{
    struct Key {
        static let objectId="objectId"
        static let uniqueKey="uniqueKey"
        static let firstName="firstName"
        static let lastName="lastName"
        static let mapString="mapString"
        static let mediaURL="mediaURL"
        static let latitude="latitude"
        static let longitude="longitude"
     
    }
    
    init?(json:[String:Any]) {
    
        objectId=json[Key.objectId] as! String ?? ""
        uniqueKey=json[Key.uniqueKey] as? String ?? ""
        firstName=json[Key.firstName] as? String ?? " "
        lastName=json[Key.lastName] as? String ?? " "
        mapString=json[Key.mapString] as? String ?? ""
        mediaURL=json[Key.mediaURL] as? String ?? " "
        latitude=json[Key.latitude] as? Double ?? 0.0
        longitude=json[Key.longitude] as? Double ?? 0.0
        fullName = firstName + lastName
        
    }
    
}
extension String {
    func toDate() -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return dateFormatter.date(from: self)!
    }
    
    
}
