//
//  ViewController.swift
//  StrivrTest
//
//  Created by Lloyd W. Sykes on 9/22/16.
//  Copyright © 2016 Strivr, Inc. All rights reserved.
//

import UIKit

class CommitsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var commitsTableView: UITableView!
    
    let customTableViewCell = CommitsCustomTableViewCell()
    let authorData = AuthorDataStore.authorStore
    var selectedAuthorCommitURL: URL!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.commitsTableView.delegate = self
        self.commitsTableView.dataSource = self
        
        self.authorData.getCommitsForRepoByAuthor { (authorDict, error) in
            
            if authorDict != nil {
                
                print("This is the count of login names: \(self.authorData.loginName.count)")
                self.commitsTableView.reloadData()
                
            } else if let error = error {
                print("There was a network error in the ViewController: \(error.localizedDescription)")
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.authorData.loginName.count
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        tableView.estimatedRowHeight = 121
        tableView.rowHeight = UITableViewAutomaticDimension
        
        return tableView.estimatedRowHeight
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CommitsCustomTableViewCell.cellReuseIdentifier , for: indexPath as IndexPath) as! CommitsCustomTableViewCell

        if let imageURL = URL(string: self.authorData.avatar[indexPath.row]) {
            
            do {
                let imageData = try Data(contentsOf: imageURL)
                cell.userAvatarImageView?.image = UIImage(data: imageData)
                // cell.authorAvatarImageView?.image = UIImage(data: imageData)
            } catch {
                
            }
            
            //                        cell.loginNameLabel?.text = "Username: \(self.authorData.loginName[indexPath.row])"
            //                        cell.timeStampLabel?.text = "Time: \(self.authorData.timeStamp[indexPath.row])"
            //                        cell.timeStampLabel?.numberOfLines = 2
            //                        cell.messageLabel?.text = "Message: \(self.authorData.commitMessage[indexPath.row])"
            
        }
        
        //        cell.loginNameLabel?.text = "Username: \(self.authorData.loginName)"
        //        cell.timeStampLabel?.text = "Time: \(self.authorData.timeStamp)"
        //        cell.timeStampLabel?.numberOfLines = 2
        //        cell.messageLabel?.text = "Message: \(self.authorData.commitMessage)"
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //   let webView = UIWebView()
        
        let destinationVC = AuthorInfoViewController()
        //        destinationVC.selectedAuthorCommitURL = URL(string: self.authorData.commitHTMLURL[indexPath.row])
        
        //    self.selectedAuthorCommitURL = url
        // destinationVC.selectedAuthorCommitURL = self.selectedAuthorCommitURL
        
        self.present(destinationVC, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
    }
}
