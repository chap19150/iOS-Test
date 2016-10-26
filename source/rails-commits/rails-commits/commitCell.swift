//
//  commitCell.swift
//  rails-commits
//
//  Created by Jeff Spingeld on 10/22/16.
//  Copyright © 2016 Jeff Spingeld. All rights reserved.
//

import UIKit

class commitCell: UITableViewCell {

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var messageTextView: UITextView!
    @IBOutlet weak var avatarView: UIImageView!
    @IBOutlet weak var authorLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
