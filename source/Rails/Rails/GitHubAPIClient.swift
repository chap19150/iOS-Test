//
//  GitHubAPIClient.swift
//  Rails
//
//  Created by Irina Ernst on 10/1/16.
//  Copyright © 2016 Irina Ernst. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class GitHubAPIClient{
    static let urlString = "https://api.github.com/repos/rails/rails/commits"
}

// MARK: Repository "rails/rails" - Commits"
extension GitHubAPIClient {
    
    class func getCommitsWithCompletion(completionHandler: @escaping (JSON?) -> Void) {
        
        Alamofire.request(urlString, method: .get, parameters: ["":""], encoding: URLEncoding.default, headers: nil)
            .validate()
            .responseJSON(completionHandler: { response in
                switch response.result {
                case .success:
                    if let data = response.data {
                        completionHandler(JSON(data: data))
                    }
                case .failure(let error):
                    print("ERROR: \(error.localizedDescription)")
                    completionHandler(nil)
                }
            })
    }
    
}
