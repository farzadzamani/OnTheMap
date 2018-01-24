//
//  newLocationViewController.swift
//  OnTheMap
//
//  Created by Farzad on 1/14/18.
//  Copyright © 2018 Farzad Zamani. All rights reserved.
//

import UIKit
import MapKit
class newLocationViewController: UIViewController {
    var studentLocation:StudentLocation?
    var updateLocation = false
    @IBOutlet weak var locationText: UITextField!
    @IBOutlet weak var urlLinkText: UITextField!
    @IBOutlet weak var finish: UIButton!
    @IBOutlet weak var titleNavigationItem: UINavigationItem!
    @IBOutlet weak var leftBarButton: UIBarButtonItem!
    @IBOutlet weak var stackviewFindLocation: UIStackView!
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    enum StepProccess {
        case start
        case finish
    }

    var showStartingStep:StepProccess = .start {
        didSet {
            if showStartingStep == .start {
                
                stackviewFindLocation.isHidden = false
                mapView.isHidden = true
                finish.isHidden = true
                titleNavigationItem.title = "Add Location"
                finish.isHidden = true
                leftBarButton.title = "Cancel"
                leftBarButton.tag = 0
            }else {
                stackviewFindLocation.isHidden = true
                mapView.isHidden = false
                finish.isHidden = false
                titleNavigationItem.title = "Confirm Location"
                finish.isHidden = false
                leftBarButton.title = "< Add Location"
                leftBarButton.tag = 1
            }
            
            
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        showStartingStep = .start
     
        self.activityIndicator.isHidden = true
        if self.studentLocation != nil {
            locationText.text = studentLocation?.mapString
            urlLinkText.text = studentLocation?.mediaURL
        }
        // Do any additional setup after loading the view.
    }
    
    @IBAction func findLocation(_ sender: Any) {
         self.activityIndicator.isHidden = false
        self.activityIndicator.startAnimating()
       
        if let address = self.locationText.text,let link = self.urlLinkText.text {
            let geocoder =  CLGeocoder()
           
            
            geocoder.geocodeAddressString(address) { (placemarks, error) in
                performUIUpdatesOnMain {
                    
                    guard
                        let placemarks = placemarks,
                        let location = placemarks.first?.location
                        
                        else {
                            alert(view: self, title: "Error", message: "This Location Coordinate is wronge Please enter correct location")
                            self.activityIndicator.stopAnimating()
                            self.activityIndicator.isHidden = true
                            return
                    }
                    
                   
                    
                    if self.studentLocation != nil {
                        self.updateLocation = true
                        self.studentLocation?.longitude = location.coordinate.longitude
                        self.studentLocation?.latitude = location.coordinate.latitude
                        self.studentLocation?.mediaURL = link
                        self.studentLocation?.mapString = address
                        self.finishStep()
                        
                        
                    } else {
                        self.createNewStudentLocationAndFinishWith(location: location, linkUrl: link)
                        self.updateLocation = false
                        
                    }
                    
                    self.activityIndicator.stopAnimating()
                    self.activityIndicator.isHidden = true
                }
                
            }
            
            
        }
        
    }
    
    
    @IBAction func leftBarButton(_ sender: Any) {
        switch showStartingStep {
        case .start:
            dismiss(animated: true, completion: nil)
        default:
            showStartingStep = .start
        }
    }
    
    @IBAction func finish(_ sender: Any) {
  
        
        if updateLocation {
            
            ParseApi.Shared.putStudentLocation(student: self.studentLocation!, compilationHandler: { (error) in
                if error != nil {
                    performUIUpdatesOnMain {
                        alert(view: self, title: "Error", message: "Proccess Faild,Please check the internet connection and Try Again")
                    }
                }else {
                    performUIUpdatesOnMain {
                        self.studentLocation = nil
                        self.dismiss(animated: true, completion: nil)
                    }
                    
                }
            })
            
        }else {
            ParseApi.Shared.postStudentLocation(student: self.studentLocation!, compilationHandler: { (error) in
                if error != nil {
                    performUIUpdatesOnMain {
                        alert(view: self, title: "Error", message: "Proccess Faild,Please check the internet connection and Try Again")
                    }
                }else {
                    performUIUpdatesOnMain {
                        self.studentLocation = nil
                        self.dismiss(animated: true, completion: nil)
                    }
                    
                }
            })
            
        }
        
        
    }
    private func startStep() {
        showStartingStep = .start
        
        
    }
    
    
    private func finishStep() {
        
        showStartingStep = .finish
        
        let anotation = StudentAnotaion(studentLocation: self.studentLocation!)
        self.mapView.addAnnotation(anotation)
        zoomToRegion(lat: self.studentLocation!.latitude, lon: self.studentLocation!.longitude)
        
        
        
        
    }
    
    private func createNewStudentLocationAndFinishWith(location:CLLocation,linkUrl:String) {
        
        UdacityApi.shared.getUserInfo(userId: AppDelegate.userId) { (udacityUser, error) in
            if error == nil,let udacityUser = udacityUser {
                self.studentLocation = StudentLocation(objectId: nil,
                                                       uniqueKey: AppDelegate.userId,
                                                       firstName: udacityUser.firstName,
                                                       lastName: udacityUser.lastName,
                                                       mapString: self.locationText?.text,
                                                       mediaURL: linkUrl,
                                                       latitude: (location.coordinate.latitude),
                                                       longitude: (location.coordinate.longitude),
                                                       fullName: nil)
                performUIUpdatesOnMain {
                    self.finishStep()
                }
                
            }
            
        }
    }
    
    private func zoomToRegion(lat:Double,lon:Double){
        let span = MKCoordinateSpanMake(0.0275, 0.0275)
        let coodinate = CLLocationCoordinate2D(latitude: lat, longitude: lon)
        let region = MKCoordinateRegion(center: coodinate, span: span)
        self.mapView.setRegion(region, animated: true)
    }
    
}
