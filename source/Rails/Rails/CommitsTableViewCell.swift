//
//  CommitsTableViewCell.swift
//  Rails
//
//  Created by Irina Ernst on 10/1/16.
//  Copyright © 2016 Irina Ernst. All rights reserved.
//

import UIKit

class CommitsTableViewCell: UITableViewCell {
    
    let store = CommitsDataStore.sharedInstance
    
    @IBOutlet weak var commitMessageLabel: UILabel!
    @IBOutlet weak var dateOfCommitLabel: UILabel!
    
    var commit:Commit? {
        didSet{
            if let commit_message = commit?.commit_message {
                updateTextLabelWith(commit: commit_message)
            }
            if let date_of_commit = commit?.date {
                updateDateLabelWith(date: date_of_commit)
            }
        }
    }
    
    
    private func updateTextLabelWith(commit: String){
        self.commitMessageLabel.text = commit
    }
    
    private func updateDateLabelWith(date: String){
        //2016-10-03T13:11:08Z
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let dateObj = dateFormatter.date(from: date)
        print("DATE %@",dateObj)
        
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateInFormat = dateFormatter.string(from: dateObj!)
        self.dateOfCommitLabel.text = dateInFormat
        
    }
}
