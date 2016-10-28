//
//  WebViewController.swift
//  StrivrProject
//
//  Created by David Nadri on 10/27/16.
//  Copyright © 2016 David Nadri. All rights reserved.
//

import UIKit

class WebViewController: UIViewController {
    
    var webView = UIWebView()
    var url: String!
    var viewControllerTitle: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.scalesPageToFit = true
        view = webView
        self.title = viewControllerTitle
        let webViewUrl = NSURL(string: url)
        webView.loadRequest(NSURLRequest(URL: webViewUrl!))

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
