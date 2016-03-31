//
//  GameList.swift
//  battleship
//
//  Created by Tigran Mnatsakanyan on 3/25/16.
//  Copyright © 2016 u0655487. All rights reserved.
//

import Foundation

class GameList {
    
    var gameList:[Game] = []
    
    init() {
        //let documentsDirectory: String? = NSSearchPathForDirectoriesInDomains(
           // .DocumentDirectory, .UserDomainMask, true)[0] as String?
        //let filePath:String? = documentsDirectory?.stringByAppendingPathComponent("gameList.txt")
        
    }
    
    func saveGame() {
        
    }
    
    func loadGame() {
        
    }
    
    func requestGamesList() {
        let url:NSURL = NSURL(string: "http://battleship.pixio.com/api/games")!
        let session = NSURLSession.sharedSession()
        
        let request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "GET"
        request.cachePolicy = NSURLRequestCachePolicy.ReloadIgnoringCacheData
    
        let task = session.dataTaskWithRequest(request, completionHandler: handler)
    
        task.resume()
    }
    
    func handler (data: NSData?, response: NSURLResponse?, error: NSError?) {
        
        guard let _:NSData = data, let _:NSURLResponse = response  where error == nil else {
            print("error")
            return
        }
        
        let dataString = NSString(data: data!, encoding: NSUTF8StringEncoding)
        print(dataString)
        
    }
    

    
}