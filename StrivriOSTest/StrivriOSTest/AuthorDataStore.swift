//
//  AuthorDataStore.swift
//  StrivriOSTest
//
//  Created by Lloyd W. Sykes on 9/23/16.
//  Copyright © 2016 Strivr, Inc. All rights reserved.
//

import Foundation

class AuthorDataStore {
    
    static let authorStore = AuthorDataStore()
    var authorDict = [String: AnyObject]()
//    var loginName = [String]()
//    var avatar = [String]()
//    var timeStamp = [String]()
//    var commitMessage = [String]()
//    var commitHTMLURL = [String]()
    
    func getCommitsForRepoByAuthor(completion: @escaping ([NSDictionary]?, Error?) -> ()) {
        
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
                    
//                    self.loginName.append(loginNameData)
//                    self.avatar.append(avatarURL)
//                    self.timeStamp.append(dateTime)
//                    self.commitMessage.append(message)
//                    self.commitHTMLURL.append(htmlURL)
                    
                    completion(authorsWithCommits, nil)
                }
            } else if let error = error {
                
                print("There was a network error in AuthorDataStore: \(error.localizedDescription)")
                completion(nil, error)
            }
        }
    }
}
