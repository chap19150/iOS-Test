//
//  CommitTableViewCell.swift
//  StrivrProject
//
//  Created by David Nadri on 10/26/16.
//  Copyright © 2016 David Nadri. All rights reserved.
//

import UIKit

class CommitTableViewCell: UITableViewCell {
    
    @IBOutlet weak var avatarImageView: CustomImageView! {
        didSet {
            avatarImageView.layer.masksToBounds = true
            avatarImageView.layer.cornerRadius = 8.0
            avatarImageView.layer.borderWidth = 1.0
            avatarImageView.layer.borderColor = UIColor.groupTableViewBackgroundColor().CGColor
        }
    }
    @IBOutlet weak var commitMessageLabel: UILabel!
    @IBOutlet weak var commitDetailsLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
