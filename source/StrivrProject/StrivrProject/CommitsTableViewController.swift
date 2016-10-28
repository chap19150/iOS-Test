//
//  CommitsTableViewController.swift
//  StrivrProject
//
//  Created by David Nadri on 10/26/16.
//  Copyright © 2016 David Nadri. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

extension Array where Element: Equatable {
    
    public func uniq() -> [Element] {
        var arrayCopy = self
        arrayCopy.removeDuplicates()
        return arrayCopy
    }
    
    mutating public func removeDuplicates() {
        var seen = [Element]()
        var index = 0
        for element in self {
            if seen.contains(element) {
                removeAtIndex(index)
            } else {
                seen.append(element)
                index += 1
            }
        }
    }
}

class CommitsTableViewController: UITableViewController {
    
    private let reuseIdentifier = "CommitCell"
    var authors = [String]()
    var commits = [Commit?]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Commits for rails/rails"
        
        // Self-sizing cells (auto-layout constraints must be set for cell)
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 80
        
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
        
        // Removes extra cell separators below tableview (of empty/unused cells)
        self.tableView.tableFooterView = UIView(frame: CGRectZero)

         self.clearsSelectionOnViewWillAppear = false

    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        
        getCommits()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source
    
//    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return authors[section]
//    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
        //return authors.count
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return commits.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier, forIndexPath: indexPath) as! CommitTableViewCell
        
        guard let commit = commits[indexPath.row] else {
            return UITableViewCell()
        }
        
        if let avatarURL = commit.avatarURL {
            cell.avatarImageView.loadImageUsingUrlString(avatarURL)
        }
    
        if let message = commit.message {
            cell.commitMessageLabel.text = message
            
        }
        
        dispatch_async(dispatch_get_main_queue()) {
            if let author = commit.author, let timestamp = commit.timestamp {
                let dateFormatter = NSDateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:sszzz"
                let date = dateFormatter.dateFromString(timestamp)
                
                cell.commitDetailsLabel.text = "\(author) • \(NSDate().offsetFrom(date!))"
            }   
        }
        
        return cell
    }
    
    func getCommits() {
        
        // Remove all the commits from the array and keep the capacity
        commits.removeAll(keepCapacity: true)
        
        Alamofire.request(.GET, "https://api.github.com/repos/rails/rails/commits").validate().responseJSON { response in
            
            if let json = response.result.value {
                print("***json.count: \(json.count)")
                
                if let commitData = response.result.value {
                    let json = JSON(commitData)
                    
                    if let commits = json.array {
                        
                        for commit in commits {
                            
                            guard let avatarURL = commit["author"]["avatar_url"].string else {
                                print("***ERROR***")
                                return
                            }
                            
                            guard let author = commit["author"]["login"].string else {
                                return
                            }

                            guard let message = commit["commit"]["message"].string else {
                                return
                            }
                            
                            guard let timestamp = commit["commit"]["committer"]["date"].string else {
                                return
                            }
                            
                            guard let commitURL = commit["html_url"].string else {
                                return
                            }
                            
                            let commit = Commit(avatarURL: avatarURL, author: author, message: message, timestamp: timestamp, commitURL: commitURL)
                            
                            self.commits.append(commit)
                            self.authors.append(author)
                        }
                        
                        // Remove duplicates
                        self.authors.removeDuplicates()
                        
                    }
                    
                    dispatch_async(dispatch_get_main_queue()) {
                        self.tableView.reloadData()
                    }
                    
                } else {
                    print("ERROR: \(response.result.error)")
                    let alert = UIAlertController(title: "Error", message: "\(response.result.error)", preferredStyle: .Alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: nil))
                    alert.presentViewController(alert, animated: true, completion: nil)

                }
            }
        
            
        }
        
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // Commit HTML URL: commit["html_url"]
        let webViewController = WebViewController()
        webViewController.viewControllerTitle = commits[indexPath.row]?.message
        webViewController.url = commits[indexPath.row]?.commitURL
        self.navigationController!.pushViewController(webViewController, animated: true)
        
    }

    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }


}
