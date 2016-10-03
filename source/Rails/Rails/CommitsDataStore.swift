//
//  CommitsDataStore.swift
//  Rails
//
//  Created by Irina Ernst on 10/1/16.
//  Copyright © 2016 Irina Ernst. All rights reserved.
//

import Foundation

class CommitsDataStore {
    
    static let sharedInstance = CommitsDataStore()
    private init() {}
    
    var commits:[Commit] = []
    var authors:[Author] = []
    
    func getCommitsWithCompletion(completion: @escaping (Bool) -> ()) {
        
        GitHubAPIClient.getCommitsWithCompletion { json in
            
            guard let json = json else {
                print("ERROR: JSON data was not received by data store")
                completion(false)
                return
            }
            
            for (_, object) in json {
                let commit = Commit(json: object)
                self.addNewCommit(commit: commit!)
                if let commitForArray = commit {
                    self.commits.append(commitForArray)
                }
            }
            completion(true)
        }
    }
    
    func addNewCommit(commit: Commit){
        var isOldAuthor = false
        for author in self.authors {
            if author.author_id == commit.author.author_id {
                author.addCommit(commit: commit)
                print("Old Author %@", author.author_login_name)
                isOldAuthor = true
                break
            }
        }
        if !isOldAuthor {
            let newAuthor: Author = commit.author
            newAuthor.addCommit(commit: commit)
            self.authors.append(newAuthor)
            print("New Author %@", newAuthor.author_login_name)
        }
    }
   
}

