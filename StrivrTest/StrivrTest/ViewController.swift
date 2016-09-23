//
//  ViewController.swift
//  StrivrTest
//
//  Created by Lloyd W. Sykes on 9/22/16.
//  Copyright © 2016 Strivr, Inc. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        GitHubAPIClient.getCommitsForRepoByAuthor { (results, error) in
            
            if let results = results {
                
                print("The count of Authors with commits: \(results.count)")
                
                for author in results {
                    
                    print("Individual author data: \(author)")
                }
            } else if let error = error {
                print("There's been an error: \(error.localizedDescription)")
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
