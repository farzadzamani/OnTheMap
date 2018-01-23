//
//  TabBarViewController.swift
//  OnTheMap
//
//  Created by Farzad on 1/4/18.
//  Copyright © 2018 Farzad Zamani. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {
   
    @IBAction func logout(_ sender: Any) {
        
            confirmAlert(view: self, title: "Confirmation", message: "Do you want to logout?", action: { (action) in
                // UdacityClient.shared.deleteSession { (error) -> Void in }
                self.dismiss(animated: true, completion: nil)
            })
    }
    
    @IBAction func refreshEntity(_ sender: Any) {
        loadStudentLocations(isUpdate: true)
       
        
        
    }
    
    @IBAction func addNewLocation(_ sender: Any) {
        
     
        ParseApi.Shared.getStudentLocation(uniqueKey: AppDelegate.userId) { (student, error) in
         
            if error != nil {
                performUIUpdatesOnMain({
                    if error == NetworkError.noValue {
                        let newLocationViewController = self.storyboard?.instantiateViewController(withIdentifier: "newLocationViewController")
                        self.present(newLocationViewController!, animated: true, completion: nil)
                    }
                    alert(view: self, title: "Error", message: error!.description)
                })
            }else if let student = student {
                performUIUpdatesOnMain({
                    Entity.shared.studentLocation = student
                    confirmAlert(view: self, title: "Confirmation", message: "You have already posted mark \"\(student.firstName)\".as \(student.mapString!)\". Would you like to overwrite it?", action: { (action) in
                        let newLocationViewController = self.storyboard?.instantiateViewController(withIdentifier: "newLocationViewController") as! newLocationViewController
                        newLocationViewController.studentLocation = student
                        self.present(newLocationViewController, animated: true, completion: nil)
                    })
                })
               
                
            }else {
                performUIUpdatesOnMain({
                    let newLocationViewController = self.storyboard?.instantiateViewController(withIdentifier: "newLocationViewController")
                    self.present(newLocationViewController!, animated: true, completion: nil)
                })
             
            }
                
            
        }
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadStudentLocations(isUpdate: false)
        
    }
    
    func loadStudentLocations(isUpdate:Bool) {
       Entity.shared.studentLocations.removeAll()
        
        ParseApi.Shared.getStudentLocations { (listOfStudentLocations, error) in
            if let data = listOfStudentLocations {
                var count = 0
                print(data.count)
                for node in  data {
                    if let newStudent = StudentLocation(json: node ) {
                        count = count + 1
                       Entity.shared.studentLocations.append(newStudent)
                        if count == data.count && isUpdate {
                            performUIUpdatesOnMain {
                                let viewController = self.viewControllers![1] as! TableViewController
                                viewController.refresh()
                            }
                        }
                    }
                }
                
            }else {
                print(error!.description)
                alert(view: self, title: "Error", message: error!.description)
            }
        }
    }

}
