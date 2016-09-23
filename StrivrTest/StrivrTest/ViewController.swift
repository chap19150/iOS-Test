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
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "authorInfo", for: indexPath)
        
        Author.getCommitsForRepoByAuthor { (authorDict, error) in
        
            
            
            
        }
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 30
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        tableView.estimatedRowHeight = 121
        tableView.rowHeight = UITableViewAutomaticDimension
        
        return tableView.estimatedRowHeight
    }
}
