//
//  NetworkError.swift
//  OnTheMap
//
//  Created by Farzad on 1/2/18.
//  Copyright © 2018 Farzad Zamani. All rights reserved.
//


 enum NetworkError: Error {
    case requestFailed
    case responseUnsuccessful
    case invalidData
    case jsonConversionFailure
    case invalidUrl
    case jsonParsingFailure
    case invalidUserName
    case noValue
    case UknownError
}
extension NetworkError {
    var description: String {
        switch self {
        case .invalidData:
            return "InvalidData"
        case .invalidUserName:
            return "Invalid UserName Or Password Entered"
        case .jsonConversionFailure:
            return "json Conversion Failed"
        case .responseUnsuccessful:
            return "failure to connect to the Server"
        default:
           return "Uknown Error"
        }
    }
}
