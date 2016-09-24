//
//  WebViewController.swift
//  StrivriOSTest
//
//  Created by Lloyd W. Sykes on 9/23/16.
//  Copyright © 2016 Strivr, Inc. All rights reserved.
//

import Foundation
import UIKit

class WebViewController: UIViewController, UIWebViewDelegate {
    
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var urlString = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.loadGitHubPage()
    }
    
    func loadGitHubPage() {
        
        self.webView.delegate = self
        
        guard let url = URL(string: self.urlString) else {
            fatalError("There was an issue unwrapping the url in WebViewController")
        }
        
        let request = URLRequest(url: url)
        self.webView.loadRequest(request)
    }
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        
        self.activityIndicator.startAnimating()
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        
        self.activityIndicator.stopAnimating()
        self.activityIndicator.hidesWhenStopped = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
