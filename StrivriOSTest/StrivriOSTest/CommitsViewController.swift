//
//  CommitsViewController.swift
//  StrivriOSTest
//
//  Created by Lloyd W. Sykes on 9/23/16.
//  Copyright © 2016 Strivr, Inc. All rights reserved.
//

import Foundation
import UIKit

class CommitsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var commitsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.commitsTableView.delegate = self
        self.commitsTableView.dataSource = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CommitsCustomTableViewCell.reuseIdentifier, for: indexPath) as? CommitsCustomTableViewCell else {
            fatalError("There was an issue unwrapping the CommitsCustomTableViewCell")
        }
        
        cell.gitImageView.image = #imageLiteral(resourceName: "gitLogo")
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == CommitsCustomTableViewCell.segueIdentifier {
            
            if segue.destination as? WebViewController != nil {
                
                print("Moving from CommitsVC to WebView")
            }
        }
    }
}
