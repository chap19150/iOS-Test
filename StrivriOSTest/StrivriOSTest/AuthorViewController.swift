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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 30
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AuthorCustomTableViewCell.reuseIdentifer, for: indexPath) as? AuthorCustomTableViewCell else {
            fatalError("There was an issue unwrapping the AuthorCustomTableViewCell.")
        }
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == AuthorCustomTableViewCell.segueIdentifier {
            
            if segue.destination as? CommitsViewController != nil {
                
                print("Moving from AuthorVC to CommitsVC")
            }
        }
    }
}
