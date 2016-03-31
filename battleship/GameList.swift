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
    var gameListDictionary:NSMutableDictionary = NSMutableDictionary()
    weak var delegate: NSURLSessionDataDelegate? = nil
    
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
        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession(configuration: config, delegate: delegate, delegateQueue: nil)
        let request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "GET"
        request.cachePolicy = NSURLRequestCachePolicy.ReloadIgnoringCacheData
    
        let task = session.dataTaskWithRequest(request)
    
        task.resume()
    }
    
    func populateGamesList(gamesData:NSData) {
        do {
            try print(NSJSONSerialization.JSONObjectWithData(gamesData, options: NSJSONReadingOptions.MutableContainers) as? [String:AnyObject])
        }
        catch {
            print("json error: \(error)")
        }
        //print(gameListDictionary)
    }
    
    
}