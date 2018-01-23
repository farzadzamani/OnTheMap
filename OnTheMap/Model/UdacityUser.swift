//
//  UdacityAccount.swift
//  OnTheMap
//
//  Created by Farzad on 12/31/17.
//  Copyright © 2017 Farzad Zamani. All rights reserved.
//

import Foundation
struct UdacityUser {
    let firstName:String
    let lastName:String
    let userId:String?
}

extension UdacityUser{
    init?(userId:String,firstname:String,lastName:String)
    {
        self.userId = userId
        self.firstName = firstname
        self.lastName = lastName
        
    }
    var fullName : String {
        
       return "\(self.firstName) \(self.lastName)"
    }
    
}
