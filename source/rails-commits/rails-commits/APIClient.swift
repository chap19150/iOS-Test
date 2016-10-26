//
//  APIClient.swift
//  rails-commits
//
//  Created by Jeff Spingeld on 10/20/16.
//  Copyright © 2016 Jeff Spingeld. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class APIClient: NSObject {
    
    // Make GET request to GitHub API for the (number) most recent Rails commits.
    func getRailsCommits(number: Int, completion: @escaping ([Author]) -> Void ) {
        
        Alamofire.request("https://api.github.com/repos/rails/rails/commits").responseJSON { response in
            
            if let JSON = response.result.value {
                
                // Turn JSON into array of dictionaries if possible
                guard var allCommits = JSON as? [[String: AnyObject]] else {
                    print("JSON cannot be converted into an array with string keys")
                    return
                }
                
                // Truncate to the specified length
                allCommits = Array(allCommits.prefix(number))
                
                // Create an array of Authors
                var authors: [Author] = []
                
                // For each commit: Create a Commit instance. If we don't yet have an Author instance for the commit's author, create one. Then append the Commit instance to that author's array of commits.
                
                for commit in allCommits {
                    
                    // First, pull the necessary variables out of the JSON
                    // ...intermediate JSON levels
                    guard let authorInfo = commit["author"] as? [String: AnyObject] else { return }
                    guard let commitInfo = commit["commit"] as? [String: AnyObject] else { return }
                    guard let committer = commitInfo["committer"] as? [String: String] else { return }
                    // ...author info
                    guard let username = authorInfo["login"] as? String else { return }
                    guard let authorURL = authorInfo["url"] as? String else { return }
                    guard let avatarURL = authorInfo["avatar_url"] as? String else { return }
                    // ...commit info
                    guard let timestamp = committer["date"] else { return }
                    guard let message = commitInfo["message"] as? String else { return }
                    guard let commitURL = commit["html_url"] as? String else { return }
                    
                    // Create a Commit instance
                    let newCommit = Commit(URL: commitURL,
                                           author: username,
                                           timestamp: timestamp,
                                           message: message)
                    
                    // If the author isn't in the Authors array yet, create an Author instance and add it
                    if self.indexOfAuthor(named: username, in: authors) == nil {
                        let newAuthor = Author(username: username,
                                               URL: authorURL,
                                               avatarURL: avatarURL,
                                               commits: [],
                                               avatarImage: nil)
                        authors.append(newAuthor)
                    }
                    
                    // Add the new commit to its author's commits array
                    authors[self.indexOfAuthor(named: username, in: authors)!].commits!.append(newCommit)

                }

                // Pass the array of authors to the caller
                completion(authors)
            }
        }
    }
    
    // MARK: helper functions
    
    // Get index of an author in an array
    func indexOfAuthor(named username: String, in authors: [Author]) -> Int? {
        
        var index = 0
        for author in authors {
            if author.username == username {
                return index
            }
            index += 1
        }
        return nil
    }

}
