//
//  CommitsTableViewCell.swift
//  Rails
//
//  Created by Irina Kalashnikova on 10/1/16.
//  Copyright © 2016 Irina Ernst. All rights reserved.
//

import UIKit

class CommitsTableViewCell: UITableViewCell {
    
    let store = CommitsDataStore.sharedInstance
    
    var commit:Commit? {
        didSet{
            print("COMMIT MESSAGE IN THE CELL: %@", commit?.commit_message)
            if let commit_message = commit?.commit_message {
                updateTextLabelWith(text: commit_message)
            }
        }
    }
    
    var author:Author? {
        didSet{
            if let author = author?.author_login_name {
                updateTextLabelWith(text: author)
            }
            if let countCommits = author?.authorCommits.count {
                updateDetailWith(numberOfCommits: countCommits)
            }
        }
    }
    
    private func updateTextLabelWith(text: String){
        self.textLabel?.text = text
    }
    
    private func updateDetailWith(numberOfCommits: Int){
        self.detailTextLabel?.text = String(numberOfCommits)
    }
}
