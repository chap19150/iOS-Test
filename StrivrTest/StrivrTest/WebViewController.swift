//
//  WebViewController.swift
//  StrivrTest
//
//  Created by Lloyd W. Sykes on 9/23/16.
//  Copyright © 2016 Strivr, Inc. All rights reserved.
//

import UIKit

class WebViewController: UIViewController, UIWebViewDelegate {
    
    @IBOutlet weak var commitWebView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
//        self.commitWebView = UIWebView()
//        self.commitWebView.delegate = self
        if let selectedAuthorCommitURL = ViewController().selectedAuthorCommitURL {
            let request = URLRequest(url: selectedAuthorCommitURL)
            self.commitWebView.loadRequest(request)
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
