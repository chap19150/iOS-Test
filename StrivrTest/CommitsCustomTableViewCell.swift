//
//  CommitsCustomTableViewCell.swift
//  StrivrTest
//
//  Created by Lloyd W. Sykes on 9/23/16.
//  Copyright © 2016 Strivr, Inc. All rights reserved.
//

import Foundation
import UIKit

class CommitsCustomTableViewCell: UITableViewCell {
    
    static let cellReuseIdentifier = "recentCommits"
    
    @IBOutlet weak var userAvatarImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var numberOfCommitsLabel: UILabel!
}
