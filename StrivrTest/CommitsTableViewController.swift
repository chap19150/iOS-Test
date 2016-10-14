//
//  CommitsTableViewController.swift
//  StrivrTest
//
//  Created by Hailey Sholty on 10/13/16.
//  Copyright © 2016 Hailey Sholty. All rights reserved.
//

import UIKit
import SDWebImage


// add clicking on user takes you to the commit in a web view


class CommitsTableViewController: UITableViewController {
    
    let downloader : SDWebImageDownloader = SDWebImageDownloader.shared()
    var images : [Int : UIImage] = [:]
    var repoData : [[String:AnyObject]]?
    override func viewDidLoad() {
        super.viewDidLoad()
        getRepoData(url: "https://api.github.com/repos/rails/rails/commits")
        
        self.tableView.register(UINib.init(nibName: "AuthorTableViewCell", bundle: nil), forCellReuseIdentifier: "AuthorCell")

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
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
//        print(info)
        
        
        if (parseError == nil && info != nil)
        {
            self.repoData = info!
//            print(self.repoData.count)
        }
        else {
            self.repoData = []
        }
        
        DispatchQueue.main.async(execute: {
            self.tableView.reloadData()
            return
        })
    }
    

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "AuthorCell") as! AuthorTableViewCell
        
        if let data = self.repoData , data.count > 0 {
            let commit = data[indexPath.row]
            let commitInfo = commit["commit"] as! [String: AnyObject]
            cell.message.text = commitInfo["message"] as? String
            let authorInfo = commit["author"] as! [String : AnyObject]
//            let imageData = Data.init(contentsOf: URL.init(authorInfo["avatar_url"] as! String))
//            var imageData : Data? = nil
//            do {
//                imageData = try Data.init(contentsOf: URL.init(string: authorInfo["avatar_url"] as! String)!)
//            } catch {
//                print("there was an error getting the image data")
//            }
//            
//            if imageData != nil {
//                cell.avatar.image = UIImage.init(data: imageData!)
//            }
            if let image = self.images[indexPath.row] {
                cell.avatar.image = image
            }
                
            
            
            else {
                downloader.downloadImage(with: URL.init(string: authorInfo["avatar_url"] as! String)!, options: [], progress: {(recievedSize : Int, expectedSize :Int) in }, completed: {(image : UIImage?, data : Data?, error : Error?, finished : Bool) in
                if image != nil && finished == true {
//                    cell.avatar.image = image
                    self.images[indexPath.row] = image!
                    DispatchQueue.main.async(execute: {
                        self.tableView.reloadRows(at: [indexPath], with: .automatic)
                    })
                }
            })
            }
            
            
            
            cell.name.text = authorInfo["login"] as? String
//            print(authorInfo["date"])
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


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
