//
//  WebViewController.swift
//  rails-commits
//
//  Created by Jeff Spingeld on 10/24/16.
//  Copyright © 2016 Jeff Spingeld. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    
    var webView: WKWebView?
    var urlString: String?

    override func loadView() {
        
        super.loadView()
        self.webView = WKWebView()
        self.view = self.webView
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Open the link that the ViewController passed us 
        let url = URL(string: urlString!)
        let request = URLRequest(url: url!)
        webView!.load(request)
 
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
