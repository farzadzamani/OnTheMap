//
//  MapViewController.swift
//  OnTheMap
//
//  Created by Farzad on 12/29/17.
//  Copyright © 2017 Farzad Zamani. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    //var studentLocations = [StudentLocation]()
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mapView.delegate = self
        Entity.shared.delegate = self
        //addPlacesOnMapWith(studentLocations: Entity.shared.studentLocations!, MapView: mapView)
        print("ViewDidLOAd -> MAPVIEW")
        // Do any additional setup after loading the view.
    }


    
}
extension MapViewController:MKMapViewDelegate{
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        var anotationview:MKAnnotationView? = mapView.dequeueReusableAnnotationView(withIdentifier: "StudentAnotaion")
        if anotationview == nil {
            anotationview = MKAnnotationView(annotation: annotation, reuseIdentifier: "StudentAnotaion")
            anotationview?.canShowCallout = true
            anotationview?.rightCalloutAccessoryView = UIButton(type: .infoLight)
        }else {
            anotationview!.annotation = annotation
        }
        
        anotationview!.image = #imageLiteral(resourceName: "icon_pin")
        return anotationview
        
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == view.rightCalloutAccessoryView {
            goTo(url: view.annotation?.subtitle!)
        }
    }
}

extension MapViewController:EntityDelegateProtocol {
    func didAddStudentLocation(studentLocation: StudentLocation) {
        performUIUpdatesOnMain {
            let anotation = StudentAnotaion(studentLocation: studentLocation)
            self.mapView.addAnnotation(anotation)
        }
        
    }
}
















