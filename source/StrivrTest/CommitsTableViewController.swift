//
//  CommitsTableViewController.swift
//  StrivrTest
//
//  Created by Hailey Sholty on 10/13/16.
//  Copyright © 2016 Hailey Sholty. All rights reserved.
//

import UIKit
import SDWebImage

class CommitsTableViewController: UITableViewController {
    
    let downloader : SDWebImageDownloader = SDWebImageDownloader.shared()
    var images : [Int : UIImage] = [:]
    var repoData : [[String:AnyObject]]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getRepoData(url: "https://api.github.com/repos/rails/rails/commits")
        
        // register custom tableview cell
        self.tableView.register(UINib.init(nibName: "AuthorTableViewCell", bundle: nil), forCellReuseIdentifier: "AuthorCell")

        self.navigationItem.title = "Commits for rails/rails"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let data = self.repoData {
            return data.count
        }
        return 0
    }
    
    func getRepoData(url:String) {
        let url = URL(string: url)
        
        let urlRequest = URLRequest.init(url: url!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 20)
        
        let session : URLSession = URLSession.shared
        
        session.dataTask(with: urlRequest,
                         completionHandler: {(data : Data?, response: URLResponse?, error: Error?) in
                if data == nil {
                    return
                }
                let data2 = data!
                            
                if data2.count > 0 && error == nil{
                    self.extract_json(jsonData: data2)
                }else if data2.count == 0 && error == nil{
                    print("Nothing was downloaded")
                } else if error != nil{
                    print("Error happened = \(error)")
                }
            }
        ).resume()
    }
    
    func extract_json(jsonData: Data)
    {
        var parseError: Error?
        let json: Any?
        do {
            json = try JSONSerialization.jsonObject(with: jsonData, options: [])
        } catch let error{
            parseError = error
            json = nil
        }
        
        let info = json as? [[String:AnyObject]]
        
        if (parseError == nil && info != nil)
        {
            self.repoData = info!
        }
        else {
            self.repoData = []
        }
        // now that data has downloaded, reload table
        DispatchQueue.main.async(execute: {
            self.tableView.reloadData()
            return
        })
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AuthorCell") as! AuthorTableViewCell
        // ensure data exists
        if let data = self.repoData , data.count > 0 {
            // get data for given row
            let commit = data[indexPath.row]
            let commitInfo = commit["commit"] as! [String: AnyObject]
            cell.message.text = commitInfo["message"] as? String
            let authorInfo = commit["author"] as! [String : AnyObject]
            
            // if image dictionary has the image, give the cell that image
            if let image = self.images[indexPath.row] {
                cell.avatar.image = image
            }
    
            // Otherwise, download image asynchronously to avoid delays in tableview scrolling
            else {
                downloader.downloadImage(with: URL.init(string: authorInfo["avatar_url"] as! String)!, options: [], progress: {(recievedSize : Int, expectedSize :Int) in }, completed: {(image : UIImage?, data : Data?, error : Error?, finished : Bool) in
                if image != nil && finished == true {
                    // update image dictionary and reload the row
                    self.images[indexPath.row] = image!
                    DispatchQueue.main.async(execute: {
                        self.tableView.reloadRows(at: [indexPath], with: .automatic)
                    })
                }
            })
            }
            
            
            // set name
            cell.name.text = authorInfo["login"] as? String
            
            // get date if it exists and format it, or set date to empty string
            if let date = (commitInfo["author"] as! [String : String])["date"] {
                let index = date.index((date.startIndex), offsetBy: 10)
                let range = (date.startIndex)..<index
                cell.date.text = date[range]
            }
            else{
                cell.date.text = ""
            }
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // ensure the data exists
        if let data = self.repoData {
            // get data, URL, and name for current row
            let commit = data[indexPath.row] 
            let url = URL.init(string: commit["html_url"] as! String)
            let cell : AuthorTableViewCell = self.tableView.cellForRow(at: indexPath) as! AuthorTableViewCell
            // bundle the data to send along with segue
            let dict = ["name" : cell.name.text, "url" : url] as [String : Any]
            self.performSegue(withIdentifier: "goToWebView", sender: dict)
        }
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // get the data I passed in
        let dict = sender as! [String : Any]
        let name = dict["name"] as! String
        let url = dict["url"] as! URL
        self.navigationItem.backBarButtonItem?.title = "Back"
        
        // get the destination view controller
        if let destination = segue.destination as? WebViewController {
            
            // set destination view controller properties
            destination.url = url
            destination.name = name
        }
    }
 
}
