//
//  CustomTableViewCell.swift
//  StrivrTest
//
//  Created by Lloyd W. Sykes on 9/23/16.
//  Copyright © 2016 Strivr, Inc. All rights reserved.
//

import UIKit

class AuthorInfoCustomTableViewCell: UITableViewCell {
    
    static let cellReuseIdentifier = "authorInfo"
    
    @IBOutlet weak var gitImageView: UIImageView!
    @IBOutlet weak var timeStampLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
}
