//
//  Author.swift
//  Rails
//
//  Created by Irina Ernst on 10/2/16.
//  Copyright © 2016 Irina Ernst. All rights reserved.
//

import Foundation
import SwiftyJSON

class Author {
    
    var author_id: Int
    var author_avatar_url: String
    var author_login_name: String
    var authorCommits: Array<Commit>
    
    init?(json: JSON) {
        
        guard let author_id = json["committer","id"].int
            else { return nil }
        
        guard let author_avatar_url = json["committer","avatar_url"].string
            else { return nil }

        guard let author_login_name = json["committer","login"].string
            else { return nil }
        
        self.author_id = author_id
        self.author_avatar_url = author_avatar_url
        self.author_login_name = author_login_name
        self.authorCommits = []
    }
    
    init?(author_id: Int, author_avatar_url: String, author_login_name: String) {
        self.author_id = author_id
        self.author_avatar_url = author_avatar_url
        self.author_login_name = author_login_name
        self.authorCommits = []
    }
    
    func addCommit(commit:Commit){
        self.authorCommits.append(commit)
    }

    func contained(author: Author) -> Bool{
        if self.contained(author: author) {
            return true
        } else {
            return false
        }
    }
}
