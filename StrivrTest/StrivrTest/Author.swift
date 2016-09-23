//
//  Author.swift
//  StrivrTest
//
//  Created by Lloyd W. Sykes on 9/22/16.
//  Copyright © 2016 Strivr, Inc. All rights reserved.
//

import Foundation

class Author {
    
    static let authorStore = Author()
    static var loginName: String?
    static var avatar: String?
    static var timeStamp: String?
    static var commitMessage: String?
    static var commitHTMLURL: String?
    
    class func getCommitsForRepoByAuthor(completion: @escaping ([NSDictionary]?, Error?) -> ()) {
        
        GitHubAPIClient.getCommitsForRepoByAuthor { (authorsWithCommits, error) in
            
            if let authorsWithCommits = authorsWithCommits {
                
                for authorInfo in authorsWithCommits {
                    
                    guard
                        let authorDict = authorInfo["author"] as? NSDictionary,
                        let loginNameData = authorDict["login"] as? String,
                        let avatarURL = authorDict["avatar_url"] as? String,
                        let commitDict = authorInfo["commit"] as? NSDictionary,
                        let dateDict = commitDict["committer"] as? NSDictionary,
                        let message = commitDict["message"] as? String,
                        let dateTime = dateDict["date"] as? String,
                        let htmlURL = authorInfo["html_url"] as? String else {
                            fatalError("There was an issue unwrapping the author information in the Author Class.")
                    }
                    
                    self.loginName = loginNameData
                    self.avatar = avatarURL
                    self.timeStamp = dateTime
                    self.commitMessage = message
                    self.commitHTMLURL = htmlURL
                    
                    print("Login name: /n\(self.loginName) Avatar URL: /n\(self.avatar) TimeStamp: /n\(self.timeStamp) Message: /n\(self.commitMessage) HTMLURL: /n\(self.commitHTMLURL)")
                    
                    completion(authorsWithCommits, nil)
                }
                
            } else if let error = error {
                
                print("There was a network error in the Author Class: \(error.localizedDescription)")
                completion(nil, error)
            }
        }
    }
}
