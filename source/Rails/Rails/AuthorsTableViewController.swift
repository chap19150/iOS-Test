//
//  AuthorsTableViewController.swift
//  Rails
//
//  Created by Irina Kalashnikova on 10/2/16.
//  Copyright © 2016 Irina Ernst. All rights reserved.
//

import UIKit

class AuthorsTableViewController: UITableViewController {
        
    let store = CommitsDataStore.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Rails"
        
        store.getCommitsWithCompletion { (success) in
            if success {
                OperationQueue.main.addOperation {
                    self.tableView.reloadData()
                }
            } else {
                print("ERROR: Unable to get commits for table view")
            }
        }
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return store.commits.count
        return store.authors.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath) as! AuthorTableViewCell
        cell.author = store.authors[indexPath.row]
        
        return cell
    }

}
