//
//  WebViewController.swift
//  StrivrTest
//
//  Created by Hailey Sholty on 10/25/16.
//  Copyright © 2016 Hailey Sholty. All rights reserved.
//

import UIKit
import MBProgressHUD

class WebViewController: UIViewController, UIWebViewDelegate {

    
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
    var progressHUD : MBProgressHUD?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if self.progressHUD != nil {
            self.progressHUD?.hide(false)
        }
            
        else {
            self.progressHUD = MBProgressHUD.showAdded(to: self.view, animated: true)
            self.progressHUD?.labelText = "Loading..."
        }
        
        webView.delegate = self
        
        // open the desired web page
        webView.loadRequest(URLRequest.init(url: url!))
        self.navigationItem.title = name
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        self.progressHUD?.hide(true)
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
