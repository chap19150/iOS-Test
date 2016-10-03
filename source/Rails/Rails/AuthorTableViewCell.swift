//
//  AuthorTableViewCell.swift
//  Rails
//
//  Created by Irina Ernst on 10/2/16.
//  Copyright © 2016 Irina Ernst. All rights reserved.
//

import UIKit

class AuthorTableViewCell: UITableViewCell {
    
    let store = CommitsDataStore.sharedInstance
    
    @IBOutlet weak var authorsImageView: UIImageView!
    @IBOutlet weak var loginNameLabel: UILabel!
    @IBOutlet weak var numberOfCommitsLabel: UILabel!
    
    var author:Author? {
        didSet{
            
            if let author = author?.author_login_name {
                updateLoginNameLabel(text: author)
            }
            if let countCommits = author?.authorCommits.count {
                updateNumberOfCommitsLabel(numberOfCommits: countCommits as NSNumber)
            }
            if let avatarUrl = author?.author_avatar_url {
                updateAvatarImageView(avatarUrl: avatarUrl)
            }
        }
    }

    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private func updateLoginNameLabel(text: String){
        //self.textLabel?.text = text
        self.loginNameLabel.text = text
        self.loginNameLabel.font = UIFont.boldSystemFont(ofSize: 20)
    }
    
    private func updateNumberOfCommitsLabel(numberOfCommits: NSNumber){
        let numOfCommits:String = "Number of commits: " + numberOfCommits.stringValue
        self.numberOfCommitsLabel.text = numOfCommits
    }
    
    private func updateAvatarImageView(avatarUrl: String) {
        guard let url = URL(string: avatarUrl) else { return }
        if let data = NSData(contentsOf: url) {
            self.authorsImageView.layer.cornerRadius = 30
            self.authorsImageView.clipsToBounds = true
            self.authorsImageView.image = UIImage(data: data as Data)
        }
    }

}
