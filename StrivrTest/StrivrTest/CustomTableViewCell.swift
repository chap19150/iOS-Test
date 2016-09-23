//
//  CustomTableViewCell.swift
//  StrivrTest
//
//  Created by Lloyd W. Sykes on 9/23/16.
//  Copyright © 2016 Strivr, Inc. All rights reserved.
//

import Foundation
import UIKit

class CustomTableViewCell: UITableViewCell {
    
    static let cellReuseIdentifier = "authorInfo"

    @IBOutlet weak var authorAvatarImageView = UIImageView()
    @IBOutlet weak var loginNameLabel = UILabel()
    @IBOutlet weak var timeStampLabel = UILabel()
    @IBOutlet weak var messageLabel = UILabel()
}
