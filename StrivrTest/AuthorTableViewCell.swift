//
//  AuthorTableViewCell.swift
//  StrivrTest
//
//  Created by Hailey Sholty on 10/13/16.
//  Copyright © 2016 Hailey Sholty. All rights reserved.
//

import UIKit

class AuthorTableViewCell: UITableViewCell {

    @IBOutlet var commitButton: UIButton!
    @IBOutlet var date: UILabel!
    @IBOutlet var message: UILabel!
    @IBOutlet var name: UILabel!
    @IBOutlet var avatar: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
