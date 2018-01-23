//
//  newLocationMapViewController.swift
//  OnTheMap
//
//  Created by Farzad on 1/16/18.
//  Copyright © 2018 Farzad Zamani. All rights reserved.
//

import UIKit
import MapKit
class newLocationMapViewController: UIViewController {
    var studentLocation:StudentLocation?
    var newLocation:CLLocation?
    var linkUrl:String? = ""
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let studentLocation = studentLocation {
              let anotation = StudentAnotaion(studentLocation: studentLocation)
              self.mapView.addAnnotation(anotation)
            
        }else {
            //Get First Name And Last name From Udacity
//            print(newLocation?.coordinate)
//            print(linkUrl)
            studentLocation = StudentLocation(objectId: nil,
                                              uniqueKey: AppDelegate.userId,
                                              firstName: "",
                                              lastName: "",
                                              mapString: nil,
                                              mediaURL: linkUrl!,
                                              latitude: (newLocation?.coordinate.latitude)!,
                                              longitude: (newLocation?.coordinate.longitude)!,
                                              fullName: nil)
            
            let anotation = StudentAnotaion(studentLocation: studentLocation!)
            self.mapView.addAnnotation(anotation)
            
        }
      zoomToRegion(lat: studentLocation!.latitude, lon: studentLocation!.longitude)
     
    }
    private func zoomToRegion(lat:Double,lon:Double){
        let span = MKCoordinateSpanMake(0.0275, 0.0275)
        let coodinate = CLLocationCoordinate2D(latitude: lat, longitude: lon)
        let region = MKCoordinateRegion(center: coodinate, span: span)
        self.mapView.setRegion(region, animated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
