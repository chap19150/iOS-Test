//
//  authorHeaderView.swift
//  rails-commits
//
//  Created by Jeff Spingeld on 10/23/16.
//  Copyright © 2016 Jeff Spingeld. All rights reserved.
//

import UIKit

class authorHeaderView: UIView {
    
    @IBOutlet weak var avatarView: UIImageView! = UIImageView()
    @IBOutlet weak var authorLabel: UILabel! = UILabel()
    
    // Apparently, if you implement the rounding somewhere else (say, in the viewForHeaderInSection tableview method), things may go wrong.
    // http://stackoverflow.com/questions/31928522/uiimageview-should-be-as-circle-view-instead-of-diamond-in-uicollectionview
    // Screenshot similar to what was happening: http://stackoverflow.com/questions/27267854/rounded-corner-images
    override func layoutSubviews() {
        
        super.layoutSubviews()
        avatarView.layer.cornerRadius = avatarView.frame.size.height / 2.0
        
    }
    
}
