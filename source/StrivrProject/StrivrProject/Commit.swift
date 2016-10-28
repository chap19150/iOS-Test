//
//  Commit.swift
//  StrivrProject
//
//  Created by David Nadri on 10/26/16.
//  Copyright © 2016 David Nadri. All rights reserved.
//
import UIKit

class Commit {
    
    var avatarURL: String?
    var author: String?
    var message: String?
    var timestamp: String?
    var commitURL: String?
    
    init(avatarURL: String?, author: String?, message: String?, timestamp: String?, commitURL: String?) {
        
        self.avatarURL = avatarURL
        self.author = author
        self.message = message
        self.timestamp = timestamp
        self.commitURL = commitURL
        
    }
    
}
