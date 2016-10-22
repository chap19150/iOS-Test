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
        
        // Access the GitHub API and get a list of recent commits to the rails repo.
        APIClient().getRailsCommits(number: 30) { (authors) in
            
            self.authors = authors
            
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
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

