//
//  Helper.swift
//  OnTheMap
//
//  Created by Farzad on 12/31/17.
//  Copyright © 2017 Farzad Zamani. All rights reserved.
//

import Foundation
import UIKit

// Mark - Netowrking Helper Function
enum requestMethod:String {
    case POST = "POST"
    case GET = "GET"
    case PUT = "PUT"
    case DELETE = "DELETE"
}

// Mark - Netowrking Helper Function
func makeRequest(url: String, method: requestMethod = .GET, params: [String: String]? = nil, body: AnyObject?=nil ,headers:[String:String]? = nil) ->  NSMutableURLRequest {
    var url = url
    if let params = params {
       url = url + (params.escapedUrlParams())
    }
    
    let request = NSMutableURLRequest(url: URL(string: url)!)
    request.httpMethod = method.rawValue.uppercased()
    if let headers = headers {
        for (header, value) in headers {
            request.addValue(value, forHTTPHeaderField: header)
        }
    }

    if body != nil {
        do {
            request.httpBody = try! JSONSerialization.data(withJSONObject: body! , options: [])
        }
    }
    
    return request
}

// Mark - Netowrking Helper Function
extension Dictionary {
    func escapedUrlParams () -> String {
        if self.isEmpty {
            return ""
        }else {
            var keyValuePairs = [String]()
            for (key, value) in self as! [String:AnyObject] {
                let stringValue = "\(value)"
                let escapedValue = stringValue.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                keyValuePairs.append(key + "=" + "\(escapedValue!)")
                
            }
            return "?\(keyValuePairs.joined(separator: "&"))"
        }
    }
    
}





// Mark - GENERAL UI HELPER Method(Alert)
    func alert(view:UIViewController,title:String,message:String) {
        performUIUpdatesOnMain {
            let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            view.present(alert, animated: true, completion: nil)
        }
    }
// Mark - GENERAL UI HELPER Method(Alert)
func confirmAlert(view:UIViewController,title:String,message: String, dismissButtonTitle: String = "Cancel", actionButtonTitle: String = "OK", action: @escaping ((UIAlertAction!) -> Void)) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    
    alert.addAction(UIAlertAction(title: dismissButtonTitle, style: .default) { (action: UIAlertAction!) in
        alert.dismiss(animated: true, completion: nil)
    })
    
    alert.addAction(UIAlertAction(title: actionButtonTitle, style: .default, handler: action))
    
    view.present(alert, animated: true, completion: nil)
}
    // Mark - GENERAL Helper Method(Go to Link )
    func goTo(url:String?) {
        if let url = URL(string: url! ) {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
    // Mark - GCD Helper Method
    func performUIUpdatesOnMain(_ updates: @escaping () -> Void) {
        DispatchQueue.main.async {
            updates()
        }
}


