//
//  TableViewController.swift
//  iOS Test
//
//  Created by Michael Kaminowitz on 10/20/16.
//  Copyright © 2016 Michael Kaminowitz. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

    var commits: [Commit] = []
    var currentPage = 1
    var selectedRow = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Rails Commits"
    }

    override func viewWillAppear(animated: Bool) {
        setupDataSource()
        //self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func setupDataSource() {
        let params = ["per_page": 25, "page":currentPage]

        DataManager.loadDataFromURL(kRailsRepoCommitPath, params: params, completion: { (data, error) -> Void in
            do {
                let jsonResult = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSMutableArray
                var newCommits: [Commit] = []
                for item in jsonResult {
                    let commit : Commit = Commit(dictionary: item as! Dictionary<String, AnyObject>)
                    newCommits.append(commit)
                }
                newCommits.sortInPlace{(commit1:Commit, commit2:Commit) -> Bool in
                    commit1.timeStamp?.timeIntervalSinceNow > commit2.timeStamp?.timeIntervalSinceNow
                }
                self.commits.appendContentsOf(newCommits)
                self.tableView.reloadData()
            } catch {
                print(error)
            }
        })

    }

    func fetchNextPage() {
        currentPage += 1
        setupDataSource()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return commits.count
        } else {
            return 1
        }
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier("CommitCell", forIndexPath: indexPath) as! TableViewCell
            let commit = commits[indexPath.row]

            cell.messageLabel.text = commit.message
            cell.authorLabel.text = commit.login
            if let timeStamp = commit.timeStamp {
                cell.authorLabel.text?.appendContentsOf(" - \(timeStamp.timeDifference()) ago")
            }

            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
                if let avatarUrl = commit.avatar {
                    if let url = NSURL(string: avatarUrl) {
                        if let data = NSData(contentsOfURL: url) {
                            dispatch_async(dispatch_get_main_queue(), {
                                cell.avatarImageView.image = UIImage(data: data)
                                cell.avatarImageView.layer.masksToBounds = true
                                cell.avatarImageView.layer.cornerRadius = 5
                            })
                        }
                    }
                }
            }
            return cell
        } else {
            if commits.count > 0 {
                self.fetchNextPage()
            }
            let cell = tableView.dequeueReusableCellWithIdentifier("loadingCell", forIndexPath: indexPath) as UITableViewCell
            return cell
        }

    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selectedRow = indexPath.row
        performSegueWithIdentifier("segueToWebview", sender: nil)
    }

    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 90
        } else {
            return 0
        }
    }
    // MARK: - Navigation


    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "segueToWebview" {
            let commit = commits[selectedRow]
            let commitWebVC = segue.destinationViewController as! CommitWebViewController
            commitWebVC.urlString = commit.url

        }
    }


}
