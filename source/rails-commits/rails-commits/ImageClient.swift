//
//  ImageClient.swift
//  rails-commits
//
//  Created by Jeff Spingeld on 10/24/16.
//  Copyright © 2016 Jeff Spingeld. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class ImageClient: NSObject {
    
    // Asynchronously get the avatar for a given author
    func getImage(for author: Author, completion: @escaping (UIImage) -> Void ) {
        
        // Download the author's avatar
            Alamofire.request(author.avatarURL!).responseImage { response in
             
                // Convert to UIImage
                guard let image = response.result.value as UIImage! else {
                    print("Could not get the avatar for GitHub user \(author.username!)")
                    return
                }
                
                // Pass back to caller
                completion(image)
        }
    }

}
