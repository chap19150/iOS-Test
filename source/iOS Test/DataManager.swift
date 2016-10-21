//
//  DataManager.swift
//  iOS Test
//
//  Created by Michael Kaminowitz on 10/20/16.
//  Copyright © 2016 Michael Kaminowitz. All rights reserved.
//

import Foundation

class DataManager {

    class func loadDataFromURL(path: String, params: [String: AnyObject], completion:(data: NSData?, error: NSError?) -> Void) {
        let session = NSURLSession.sharedSession()
        
        var fullPath = kApiBaseUrl + path
        for (key, value) in params {
            if fullPath == kApiBaseUrl + path {
                fullPath.appendContentsOf("?\(key)=\(value)")
            } else {
                fullPath.appendContentsOf("&\(key)=\(value)")
            }
        }
        print(fullPath)
        let loadDataTask = session.dataTaskWithURL(NSURL(string: fullPath)!, completionHandler: { (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
            if let responseError = error {
                completion(data: nil, error: responseError)
            } else if let httpResponse = response as? NSHTTPURLResponse {
                if httpResponse.statusCode != 200 {
                    let statusError = NSError(domain:"Access Denied", code:httpResponse.statusCode, userInfo:[NSLocalizedDescriptionKey : "HTTP status code has unexpected value."])
                    completion(data: nil, error: statusError)
                } else {
                    completion(data: data, error: nil)
                }
            }
        })
        
        loadDataTask.resume()
    }
}