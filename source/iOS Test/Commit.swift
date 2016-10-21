//
//  Commit.swift
//  iOS Test
//
//  Created by Michael Kaminowitz on 10/20/16.
//  Copyright © 2016 Michael Kaminowitz. All rights reserved.
//

import Foundation

class Commit: NSObject {

    var sha: String!
    var avatar : String?
    var login: String!
    var message: String!
    var timeStamp: NSDate?
    var url: String!

    init(dictionary: Dictionary<String, AnyObject>) {
        super.init()
        if let fullSha = dictionary["sha"] as? String {
            let index = fullSha.startIndex.advancedBy(7)
            self.sha = fullSha.substringToIndex(index)
        }
        self.sha = dictionary["sha"] as? String ?? ""
        self.message = dictionary["commit"]!["message"] as? String ?? "..."
        self.login = dictionary["author"]!["login"] as? String ?? "author"
        self.avatar = dictionary["author"]!["avatar_url"] as? String
        self.url = dictionary["html_url"] as? String ?? "https://github.com"
        if let dateString = dictionary["commit"]!["author"]!!["date"] as? String {
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HHmmssZZ"
            self.timeStamp = dateFormatter.dateFromString(dateString.stringByReplacingOccurrencesOfString(":", withString: ""))
        }
    }
}