//
//  Author.swift
//  StrivrProject
//
//  Created by David Nadri on 10/27/16.
//  Copyright © 2016 David Nadri. All rights reserved.
//

import Foundation

struct Author {
    
    var header: String
    var commits: [Commit]
    
    init(header: String, commits: [Commit]) {
        self.header = header
        self.commits = commits
    }
    
}
