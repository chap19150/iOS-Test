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
    let placeholderImage: UIImage = UIImage(named: "placeholder")!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Can we do nav bar stuff here?
        //TODO: test if navigation bar properties set here persist into the next VC
        self.navigationController?.navigationBar.backgroundColor = UIColor.orange
        
        // Access the GitHub API and get the last 30 commits to the rails repo.
        APIClient().getRailsCommits(number: 30) { (authors) in
            
            // Populate the tableview with everything except the avatars
            self.authors = authors
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
            // Get the authors' avatars and add them to the tableview
            self.getAvatars()

        }
    }

    // Download every author's avatar, and update the tableview with the images as they come in
    func getAvatars() {
        
        let imageClient = ImageClient()
        
        for index in self.authors.indices {
            
            imageClient.getImage(for: self.authors[index], completion: { (avatar) in
                
                self.authors[index].avatarImage = avatar
                
                // Reload
                DispatchQueue.main.async {
                    
                    self.tableView.reloadData()
                    
                    // Can't seem to get this working, to reload only the relevant section instead of the whole table...
                    // self.tableView.reloadSections(IndexSet(integer: index), with: .none)
                    
                }
                
            })
        }
    }
    
    // MARK: tableview methods
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        // Get the author this section represents
        let author = authors[section]

        // Load the header view xib
        guard let headerView = Bundle.main.loadNibNamed("authorHeaderView", owner: self, options: nil)?.first as? authorHeaderView else {
            print("Couldn't load nib")
            return UIView()
        }
        headerView.layoutIfNeeded()
        
        // Set author label
        headerView.authorLabel.text = author.username
        
        // Set the avatar image if it's come in already; if it hasn't yet, use the placeholder
        if let avatar = author.avatarImage {
            headerView.avatarView.image = avatar
        } else {
            headerView.avatarView.image = self.placeholderImage
        }
        
        return headerView
        
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Get a cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! commitCell
        
        // Get the right commit
        let commit = authors[indexPath.section].commits?[indexPath.row]
        
        // Set the cell properties
        cell.timeLabel.text = commit!.timestamp
        cell.messageTextView.text = commit!.message
        cell.authorLabel.text = commit!.author
        // Limit textview to 2 lines, otherwise truncate with an ellipsis
        cell.messageTextView.textContainer.maximumNumberOfLines = 2
        cell.messageTextView.textContainer.lineBreakMode = .byTruncatingTail
        
        // Make the avatar image view circular
        cell.avatarView.layer.cornerRadius = cell.avatarView.frame.size.height / 2.0
        // Set the avatar image if it's come in already; if it hasn't yet, use the placeholder
        if let avatar = authors[indexPath.section].avatarImage {
            cell.avatarView.image = avatar
        } else {
            cell.avatarView.image = self.placeholderImage
        }
        
        return cell
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.authors.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.authors[section].commits!.count
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // Pass the selected commit's URL to the webview
        let indexPath = self.tableView.indexPathForSelectedRow!
        let url = authors[indexPath.section].commits?[indexPath.row].URL
        if let destVC: WebViewController = segue.destination as? WebViewController {
            destVC.urlString = url
        }
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

