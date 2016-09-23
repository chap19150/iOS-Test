//
//  Author.swift
//  StrivrTest
//
//  Created by Lloyd W. Sykes on 9/22/16.
//  Copyright © 2016 Strivr, Inc. All rights reserved.
//

import Foundation

class AuthorDataStore {
    
    static let authorStore = AuthorDataStore()
    var authorDict = [String: [String: String]]()
    var loginName = [String]()
    var avatar = [String]()
    var timeStamp = [String]()
    var commitMessage = [String]()
    var commitHTMLURL = [String]()
    
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
                    
                    self.loginName.append(loginNameData)
                    self.avatar.append(avatarURL)
                    self.timeStamp.append(dateTime)
                    self.commitMessage.append(message)
                    self.commitHTMLURL.append(htmlURL)

//                    self.avatar = avatarURL
//                    self.timeStamp = dateTime
//                    self.commitMessage = message
//                    self.commitHTMLURL = htmlURL
//                    
//                    for username in self.loginName {
//                        
//                        self.authorDict[username] = [
//                            "avatar"    : self.avatar,
//                            "timeStamp" : self.timeStamp,
//                            "message"   : self.commitMessage,
//                            "commitURL" : self.commitHTMLURL]
//                        
//                    }
                    
                    
                    //  print("Login name: \(self.loginName) \nAvatar URL: \(self.avatar) \nTimeStamp: \n\(self.timeStamp) \nMessage: \(self.commitMessage) \nHTMLURL: \(self.commitHTMLURL)")
                    
                    completion(authorsWithCommits, nil)
                }
                
            } else if let error = error {
                
                print("There was a network error in the Author Class: \(error.localizedDescription)")
                completion(nil, error)
            }
        }
    }
}
