//
//  Entity.swift
//  OnTheMap
//
//  Created by Farzad on 1/4/18.
//  Copyright © 2018 Farzad Zamani. All rights reserved.
//

import Foundation

protocol EntityDelegateProtocol: class {
    func didAddStudentLocation(studentLocation:StudentLocation)
}
class Entity {
    weak var delegate:EntityDelegateProtocol?
    static var shared = Entity()
    private init(){}
  
    var user: UdacityUser? = nil
    
    
    var studentLocation: StudentLocation? = nil
    
    
    var studentLocations: [StudentLocation] = [StudentLocation]() {
        didSet{
            if studentLocations.count > 0 {
                delegate?.didAddStudentLocation(studentLocation: studentLocations.last!)
            }
            
        
        }
    }
    
    
   
}
