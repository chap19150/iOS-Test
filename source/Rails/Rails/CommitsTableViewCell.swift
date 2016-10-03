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
    

    @IBOutlet weak var authorImageView: UIImageView!
    @IBOutlet weak var authorUsernameLabel: UILabel!
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
            if let author_avatar = commit?.author.author_avatar_url {
                updateAvatarImageView(avatarUrl: author_avatar)
            }
            if let author_login_name = commit?.author.author_login_name {
                updateAuthorLoginName(loginName: author_login_name)
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
    
    private func updateAvatarImageView(avatarUrl: String) {
        guard let url = URL(string: avatarUrl) else { return }
        if let data = NSData(contentsOf: url) {
            self.authorImageView.layer.cornerRadius = 30
            self.authorImageView.clipsToBounds = true
            self.authorImageView.image = UIImage(data: data as Data)
        }
    }
    
    private func updateAuthorLoginName(loginName: String) {
        self.authorUsernameLabel.text = loginName
        self.authorUsernameLabel.font = UIFont.boldSystemFont(ofSize: 20)
    }


}
