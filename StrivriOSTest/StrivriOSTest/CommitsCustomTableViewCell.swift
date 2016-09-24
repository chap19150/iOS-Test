//
//  CommitsCustomTableViewCell.swift
//  StrivriOSTest
//
//  Created by Lloyd W. Sykes on 9/23/16.
//  Copyright © 2016 Strivr, Inc. All rights reserved.
//

import Foundation
import UIKit

class CommitsCustomTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "recentCommits"
    static let segueIdentifier = "webView"
    
    @IBOutlet weak var gitImageView: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
}
