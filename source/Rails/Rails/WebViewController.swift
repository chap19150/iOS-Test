//
//  ViewController.swift
//  Rails
//
//  Created by Irina Kalashnikova on 10/1/16.
//  Copyright © 2016 Irina Ernst. All rights reserved.
//

import UIKit

class WebViewController: UIViewController, UIWebViewDelegate {
    
    var selectedCommit: Commit!
    var webView: UIWebView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setWebView()
        setNav()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setWebView(){
        self.title = selectedCommit.author.author_login_name
        let url = NSURL(string: selectedCommit.commit_html_url)

        webView = UIWebView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        webView.loadRequest(NSURLRequest(url: url as! URL) as URLRequest)
        webView.delegate = self
        view.addSubview(webView)
    }

    func setNav(){
        self.navigationController?.navigationBar.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: nil, action: nil)
    }
    
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        let isPortrait = size.height > size.width
        let isLandscape = size.width > size.height
        
        UIView.animate(withDuration: 0.25) {
            if isPortrait {
                self.webView.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
            } else if isLandscape {
                self.webView.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
            } else {
                print("ERROR")
            }
            self.view.layoutIfNeeded()
        }
    }


}

