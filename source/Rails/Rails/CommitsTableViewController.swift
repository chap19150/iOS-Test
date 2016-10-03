//
//  CommitsTableViewController.swift
//  Rails
//
//  Created by Irina Kalashnikova on 10/1/16.
//  Copyright © 2016 Irina Ernst. All rights reserved.
//

import UIKit

class CommitsTableViewController: UITableViewController {

    var author: Author!
    var selectedCommit: Commit!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNav()
        
        tableView.estimatedRowHeight = 74
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    func setNav(){
        self.title = "Author's login name"
        self.navigationController?.navigationBar.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: nil, action: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.title = author.author_login_name
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return author.authorCommits.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "commitCell", for: indexPath) as! CommitsTableViewCell
        cell.commit = author.authorCommits[indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedCommit = author.authorCommits[(tableView.indexPathForSelectedRow?.row)!]
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toWebViewController" {
            let webViewController = segue.destination as? WebViewController
            if let commitIndex = tableView.indexPathForSelectedRow?.row {
                webViewController?.selectedCommit = author.authorCommits[commitIndex]
            }
        }
    }
    
    // MARK: - Table view data source - Dynamic cells
//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return UITableViewAutomaticDimension
//    }
//    
//    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
//         return UITableViewAutomaticDimension
//    }
//    
    

}
