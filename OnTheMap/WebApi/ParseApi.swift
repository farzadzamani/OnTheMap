//
//  ParseApi.swift
//  OnTheMap
//
//  Created by Farzad on 12/30/17.
//  Copyright © 2017 Farzad Zamani. All rights reserved.
//

import Foundation
class ParseApi {
    static let Shared = ParseApi()
    private init(){}
    
    typealias JSONArray = [[String:Any]]
    
    typealias studentLocationCompilationHandler = (JSONArray?, NetworkError?) -> Void
    func getStudentLocations(compilationHandler compilation: @escaping studentLocationCompilationHandler) -> () {
        let request = makeRequest(url: value.GetAllStudentsMethod,
                                  method: .GET,
                                  params: nil,body: nil,
                                  headers: [key.ParseApplicationID:value.ParseApplicationID,
                                                       key.RESTAPIKey:value.RESTAPIKey,]) as URLRequest
        
   
        
        
        let task = JSONDownloader().jsonTask(with: request, isForUdacity: false) { (data, error) in
            
            if error == nil {
                if let data = data {
                  let list = data["results"] as? [[String:Any]]
                 compilation(list, nil)
                }
                
            }else {
                compilation(nil, NetworkError.invalidData)
            }
        }
        task.resume()
    }
  


typealias studentCompilationHandler = (StudentLocation?, NetworkError?) -> Void
    
    func getStudentLocation(uniqueKey:String, compilationHandler compilation: @escaping studentCompilationHandler) -> () {
        let request = makeRequest(url: value.GetStudentLocationUrl,
                                  method: .GET,
                                  params: [key.SearchByWhere:"{\"uniqueKey\":\"\(uniqueKey)\"}"],
                                  body: nil, headers: [key.ParseApplicationID:value.ParseApplicationID,
                                                       key.RESTAPIKey:value.RESTAPIKey,]) as URLRequest
        print(request)
        

        
        
    let task = JSONDownloader().jsonTask(with: request, isForUdacity: false) { (data, error) in
        
        if error == nil,let data = data {
           
            if let list = data["results"] as? [[String:AnyObject]] {
                if list.isEmpty {compilation(nil, NetworkError.noValue)} else {
                    let student = StudentLocation(json: list.first!)
                        compilation(student, nil)
                }

                
            }else {
                   compilation(nil, NetworkError.invalidData)
            }
            
        }else {
            compilation(nil, NetworkError.invalidData)
        }
    }
    task.resume()
}
    
    //
    func postStudentLocation(student: StudentLocation, compilationHandler compilation: @escaping (NetworkError?) -> Void) {
        let request = makeRequest(url: value.PostStudentLocationUrl,
                                  method: .POST,
                                  params: nil, body: [
                                    "uniqueKey": student.uniqueKey,
                                    "firstName": student.firstName,
                                    "lastName": student.lastName,
                                    "mapString": student.mapString,
                                    "mediaURL": student.mediaURL,
                                    "latitude": student.latitude,
                                    "longitude": student.longitude,
                                    ] as AnyObject, headers: [key.ParseApplicationID:value.ParseApplicationID,
                                                 key.RESTAPIKey:value.RESTAPIKey,
                                                 key.ContentType:value.ContentType]) as URLRequest
        
        

        let task = JSONDownloader().postJsonTask(with: request) { (error) in
            if error == nil {
            compilation(nil)
            }else {compilation(error)}
        }
        task.resume()
        
}
//
//    /*
//     * Update existing student object in Parse storage
//     */
    func putStudentLocation(student: StudentLocation,  compilationHandler compilation: @escaping (NetworkError?) -> Void) {
        
        let request = makeRequest(url: value.PostStudentLocationUrl + student.objectId!,
                                  method: .PUT,
                                  params: nil, body: [
                                    "uniqueKey": student.uniqueKey,
                                    "firstName": student.firstName,
                                    "lastName": student.lastName,
                                    "mapString": student.mapString,
                                    "mediaURL": student.mediaURL,
                                    "latitude": student.latitude,
                                    "longitude": student.longitude,
                                    ] as AnyObject, headers: [key.ParseApplicationID:value.ParseApplicationID,
                                                              key.RESTAPIKey:value.RESTAPIKey,
                                                              key.ContentType:value.ContentType]) as! URLRequest
       
      
        

        let task = JSONDownloader().postJsonTask(with: request) { (error) in
            if error == nil {
                compilation(nil)
            }else {compilation(error)}
        }
        task.resume()
        
        }
    
}


extension ParseApi {
   
   struct key {
    
    static let SearchByWhere = "where"
    static let ContentType = "Content-Type"
    static let ParseApplicationID = "X-Parse-Application-Id"
    static let RESTAPIKey = "X-Parse-REST-API-Key"
    
   
    }
    struct value {
        
       
        static let BaseUrl = "https://parse.udacity.com/parse/classes/"
        static let GetAllStudentsMethod = "https://parse.udacity.com/parse/classes/StudentLocation?limit=100&order=-updatedAt"
         static let ContentType = "application/json"
        static let ParseApplicationID = "QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr"
        static let RESTAPIKey = "QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY"
        static let PostStudentLocationUrl = "https://parse.udacity.com/parse/classes/StudentLocation/"
        static let GetStudentLocationUrl = "https://parse.udacity.com/parse/classes/StudentLocation"
        
    }
    
    

    
}





