//
//  WebViewController.swift
//  StrivrTest
//
//  Created by Hailey Sholty on 10/25/16.
//  Copyright © 2016 Hailey Sholty. All rights reserved.
//

import UIKit

class WebViewController: UIViewController {

    
    // Standard web view actions
    
    @IBAction func refresh(_ sender: AnyObject) {
        webView.reload()
    }
    @IBAction func stop(_ sender: AnyObject) {
        webView.stopLoading()
    }
    @IBAction func forward(_ sender: AnyObject) {
        if webView.canGoForward {
            webView.goForward()
        }
        
    }
    @IBAction func back(_ sender: AnyObject) {
        if webView.canGoBack {
            webView.goBack()
        }
    }
    @IBOutlet var webView: UIWebView!
    @IBOutlet var navigationBar: UINavigationItem!
    
    var url : URL?
    var name : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // open the desired web page
        webView.loadRequest(URLRequest.init(url: url!))
        self.navigationItem.title = name
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
