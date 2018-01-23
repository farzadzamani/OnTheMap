//
//  UdacityApi.swift
//  OnTheMap
//
//  Created by Farzad on 12/30/17.
//  Copyright © 2017 Farzad Zamani. All rights reserved.
//

import Foundation
class UdacityApi {
    let jsonDownloader = JSONDownloader()
    static let shared = UdacityApi()
    private init(){}
    
     typealias JSON = [String: AnyObject]
    typealias sessionIdCompilationHandler = (NetworkError?) -> Void
    typealias userInfoCompilationHandler = (UdacityUser?, NetworkError?) -> Void
    
    func getSessionIdWith(username:String,password:String,compilationHandler Compilation: @escaping sessionIdCompilationHandler) -> ()
    {
      
        var request = URLRequest(url: URL(string: Key.sessionMethod)!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = "{\"udacity\": {\"username\": \"\(username)\", \"password\": \"\(password)\"}}".data(using: .utf8)
        
        let task = jsonDownloader.jsonTask(with: request, isForUdacity: true) { (data, error) in
            if error != nil {
                 Compilation(NetworkError.invalidUserName)
                return
            }else if let user = data!["account"] as? [String:Any], let userId = user["key"] as? String  {
                     if let session = data!["session"] as? [String:Any], let sessionId = session["id"] as? String  {
                    AppDelegate.userId = userId
                        
                    AppDelegate.sessionId = sessionId
                    Compilation(nil)
                     }else {
                        Compilation(NetworkError.invalidUserName)
                }
          
          
            }else {
                Compilation(NetworkError.invalidUserName)
            }
        }
        
     task.resume()
      
        }
       
    
        
    
    
    func getUserInfo(userId:String,compiltaionHandler compilation: @escaping userInfoCompilationHandler) -> () {
        
        let request = URLRequest(url: URL(string: Key.userDataMethod + userId)!)
        let session = URLSession.shared
        
        let task = session.dataTask(with: request) { data, response, error in
            if error != nil { // Handle error...
                print(error!)
                compilation(nil, NetworkError.invalidData)
            }
        
            let range = Range(5..<data!.count)
            let newData = data?.subdata(in: range) /* subset response data! */
            if let json = try! JSONSerialization.jsonObject(with: newData!, options: []) as? [String: AnyObject] {
                if let user = json["user"]  {
               
                    if let firstName = user[Key.firstName] as? String,  let lastName = user[Key.lastName] as? String {
                        let newUdacityUser = UdacityUser(firstName: firstName, lastName: lastName, userId: userId)
                       
                        compilation(newUdacityUser, nil)
                    }else
                    {
                        compilation(nil, NetworkError.invalidData)
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
}
extension UdacityApi {
    struct  Key {
     static let  sessionMethod = "https://www.udacity.com/api/session"
     static let  userDataMethod = "https://www.udacity.com/api/users/"
     static let firstName = "first_name"
     static let lastName = "last_name"
    }
   
    
}
