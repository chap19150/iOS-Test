//
//  ViewController.swift
//  rails-commits
//
//  Created by Jeff Spingeld on 10/20/16.
//  Copyright © 2016 Jeff Spingeld. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    var authors:[Author] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Register nib
        tableView.register(UINib(nibName: "commitCell", bundle: nil), forCellReuseIdentifier: "cell")
        
        // Access the GitHub API and get a list of recent commits to the rails repo.
        APIClient().getRailsCommits(number: 30) { (authors) in
            
            self.authors = authors
            self.tableView.reloadData()
            
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Get a cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! commitCell
        // Find the commit
        let commit = authors[indexPath.section].commits?[indexPath.row]
        // Set the cell properties
        cell.timeLabel.text = commit!.timestamp
        cell.messageTextView.text = commit!.message
        cell.authorLabel.text = commit!.author
        cell.avatarView.image = UIImage(named: "test")
        
        return cell
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.authors.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.authors[section].commits!.count
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

