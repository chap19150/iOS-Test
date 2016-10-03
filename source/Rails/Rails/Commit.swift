//
//  Commit.swift
//  Rails
//
//  Created by Irina Kalashnikova on 10/1/16.
//  Copyright © 2016 Irina Ernst. All rights reserved.
//

import Foundation
import SwiftyJSON

class Commit {
   
    var commit_message: String
    var commit_html_url: String
    var date: String
    var author: Author
    
    init?(json: JSON) {
        
        guard let commit_message = json["commit","message"].string
            else { return nil }
        

        guard let commit_html_url = json["html_url"].string
            else { return nil }

        guard let date = json["commit","author","date"].string
            else { return nil }
        
        guard let author_id = json["author","id"].int
            else { return nil }

        guard let author_avatar_url = json["author","avatar_url"].string
            else { return nil }

        guard let author_login_name = json["author","login"].string
            else { return nil }

        
        guard let author = Author(author_id: author_id,
                                  author_avatar_url: author_avatar_url,
                                  author_login_name: author_login_name)
            else { return nil }
        
        
        self.commit_message = commit_message
        self.commit_html_url = commit_html_url
        self.date = date
        self.author = author
        
        print("LALLALA COMMIT %@", self.commit_message)
        print("LALLALA COMMIT URL %@", self.commit_html_url)
        print("LALLALA COMMIT URL %@", self.date)
        print("LALLALA AUTHOR %@", self.author.author_id)
    }
}
