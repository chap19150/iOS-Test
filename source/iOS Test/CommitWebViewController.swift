//
//  ViewController.swift
//  iOS Test
//
//  Created by Michael Kaminowitz on 10/20/16.
//  Copyright © 2016 Michael Kaminowitz. All rights reserved.
//

import UIKit


class CommitWebViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    
    var urlString = String!()

    override func viewDidLoad() {
        super.viewDidLoad()
        let testURL = NSURL(string: urlString)
        let request : NSURLRequest = NSURLRequest(URL: testURL!)
        webView.loadRequest(request)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

