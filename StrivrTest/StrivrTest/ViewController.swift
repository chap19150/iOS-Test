//
//  ViewController.swift
//  StrivrTest
//
//  Created by Lloyd W. Sykes on 9/22/16.
//  Copyright © 2016 Strivr, Inc. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var authorTableView: UITableView!
    let customTableViewCell = CustomTableViewCell()
    //   let authorData = Author.authorStore
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.authorTableView.delegate = self
        self.authorTableView.dataSource = self
        
        Author.getCommitsForRepoByAuthor { (authorDict, error) in
            
            if authorDict != nil {
                
                print("This is the count of login names: \(Author.loginName.count)")
                self.authorTableView.reloadData()
                
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
        
        return Author.loginName.count
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        tableView.estimatedRowHeight = 121
        tableView.rowHeight = UITableViewAutomaticDimension
        
        return tableView.estimatedRowHeight
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.cellReuseIdentifier , for: indexPath as IndexPath) as! CustomTableViewCell
        
        if let image = UIImage(contentsOfFile: Author.avatar[indexPath.row]) {
            
            cell.authorAvatarImageView?.image = image
            
        }
        
        cell.loginNameLabel?.text = "Username: \(Author.loginName[indexPath.row])"
        cell.timeStampLabel?.text = "Time: \(Author.timeStamp[indexPath.row])"
        cell.messageLabel?.text = "Message: \(Author.commitMessage[indexPath.row])"
        
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    
}
