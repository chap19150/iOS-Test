//
//  AuthorsTableViewController.swift
//  Rails
//
//  Created by Irina Ernst on 10/2/16.
//  Copyright © 2016 Irina Ernst. All rights reserved.
//

import UIKit

class AuthorsTableViewController: UITableViewController {
        
    let store = CommitsDataStore.sharedInstance
    var selectedAuthor: Author!
    
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
        
        self.clearsSelectionOnViewWillAppear = false

        self.navigationController?.navigationBar.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: nil, action: nil)
        
        tableView.tableFooterView = UIView()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return store.authors.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath) as! AuthorTableViewCell
        let author = store.authors[indexPath.row]
        cell.author = author
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedAuthor = store.authors[(tableView.indexPathForSelectedRow?.row)!]
        self.performSegue(withIdentifier: "toCommitsViewController", sender: selectedAuthor)
        //navigationController?.pushViewController(CommitsTableViewController, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toCommitsViewController" {
            let commitViewController = segue.destination as? CommitsTableViewController
            let authorIndex = tableView.indexPathForSelectedRow?.row
            commitViewController?.author = store.authors[authorIndex!]
            print(commitViewController?.author.author_login_name)
        }
    }

}
