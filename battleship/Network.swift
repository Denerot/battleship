//
//  Network.swift
//  battleship
//
//  Created by Tigran Mnatsakanyan on 4/3/16.
//  Copyright © 2016 u0655487. All rights reserved.
//

import Foundation

class Network {
    let scheme:String = "http"
    let host:String = "battleship.pixio.com"
    let gameListPath:String = "/api/v2/lobby"
    weak var delegate:NetworkDelegate? = nil
    init() {
        
    }
    
//    func requestGameList() {
//        let gameListComponents:NSURLComponents = NSURLComponents()
//        gameListComponents.scheme = scheme
//        gameListComponents.host = host
//        gameListComponents.path = gameListPath
//        let gamesListUrl:NSURL = gameListComponents.URL!
//        let request = NSURLRequest(URL: gamesListUrl)
//        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
//        let session = NSURLSession(configuration: config, delegate: delegate, delegateQueue: nil)
//        let task = session.dataTaskWithRequest(request)
//        task.resume()
//    }
    
    func requestGameList()
    {
        let url: NSURL = NSURL(string: "http://battleship.pixio.com/api/v2/lobby")!
        let request: NSMutableURLRequest = NSMutableURLRequest(URL: url)
        
        
//        request.HTTPMethod = "POST"
        
       // request.HTTPBody = NSJSONSerialization.dataWithJSONObject(myArray, options: NSJSONWritingOptions())
        
        let queue: NSOperationQueue = NSOperationQueue()
        
        NSURLConnection.sendAsynchronousRequest(request, queue: queue, completionHandler: {
            (response: NSURLResponse?, data: NSData?, error: NSError?) -> Void in NSOperationQueue.mainQueue().addOperationWithBlock(
                {
                    if(data == nil)
                    {
                        print("No Data")
                    }
                    else
                    {
                        self.delegate!.updateGameList(data!)
                        //try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions()))
                    }
            })
        })
    }
}