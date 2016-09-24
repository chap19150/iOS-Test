//
//  ViewController.swift
//  StrivriOSTest
//
//  Created by Lloyd W. Sykes on 9/23/16.
//  Copyright © 2016 Strivr, Inc. All rights reserved.
//

import UIKit

class AuthorViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var authorTableView: UITableView!
    let authorDataStore = AuthorDataStore.authorStore
    var urlPlaceholder = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.authorTableView.delegate = self
        self.authorTableView.dataSource = self
        
        self.authorDataStore.getCommitsForRepoByAuthor { (authorDict, error) in
            
            if authorDict != nil {
                
                 self.authorTableView.reloadData()
                
            } else if error != nil {
                
                print("There was a network error in AuthoVC: \(error?.localizedDescription)")
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.authorDataStore.loginName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AuthorCustomTableViewCell.reuseIdentifer, for: indexPath) as? AuthorCustomTableViewCell else {
            fatalError("There was an issue unwrapping the AuthorCustomTableViewCell.")
        }
        
        if let url = URL(string: self.authorDataStore.avatar[indexPath.row]) {
           
            do {
                let imageData = try  Data(contentsOf: url)
                cell.userAvatarImageView.image = UIImage(data: imageData)
                
            } catch {
                print("There was an issue unwrapping the imageData for the Avatar in AuthorVC")
            }
        }

        cell.usernameLabel.text = "Username: \(self.authorDataStore.loginName[indexPath.row])"
        cell.dateLabel.text = "Date: \(self.authorDataStore.timeStamp[indexPath.row])"
        cell.messageLabel.text = "Message: \(self.authorDataStore.commitMessage[indexPath.row])"
        
        self.urlPlaceholder = self.authorDataStore.commitHTMLURL[indexPath.row]
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == AuthorCustomTableViewCell.segueIdentifier {
            
            if let destination = segue.destination as? WebViewController {
                
                destination.urlString = self.urlPlaceholder
                
                print("Moving from AuthorVC to CommitsVC")
            }
        }
    }
}
