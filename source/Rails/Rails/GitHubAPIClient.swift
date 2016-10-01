//
//  GitHubAPIClient.swift
//  Rails
//
//  Created by Irina Kalashnikova on 10/1/16.
//  Copyright © 2016 Irina Ernst. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class GitHubAPIClient{
    static let repo = "rails/rails"
    static let urlString = "https://api.github.com/repos/rails/rails/commits/master"
}

// MARK: Repository "rails/rails" - Commits"
extension GitHubAPIClient {
    
    class func getRepositoriesWithCompletion(completionHandler: @escaping (JSON?) -> Void) {
        
        Alamofire.request(urlString, method: .get, parameters: ["":""], encoding: URLEncoding.default, headers: nil)
            .validate()
            .responseJSON(completionHandler: { response in
                switch response.result {
                case .success:
                    if let data = response.data {
                        print(JSON(data: data))
                        completionHandler(JSON(data: data))
                    }
                case .failure(let error):
                    print("ERROR: \(error.localizedDescription)")
                    completionHandler(nil)
                }
            })
    }
    
}
