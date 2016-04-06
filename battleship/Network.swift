//
//  Network.swift
//  battleship
//
//  Created by Tigran Mnatsakanyan on 4/3/16.
//  Copyright © 2016 u0655487. All rights reserved.
//

import Foundation

protocol NetworkDelegate: class {
    func updateGameList(gameListData:NSData)
    func gameDetailRecieved(gameData:NSData)
    func gameJoined(playerId:NSData)
    func gameCreated(gameInfo:NSData)
}

class Network {
    let scheme:String = "http"
    let host:String = "battleship.pixio.com"
    let gameListPath:String = "/api/v2/lobby"
    weak var delegate:NetworkDelegate? = nil
    init() {
        
    }
    
    func requestGameList()
    {
        let url: NSURL = NSURL(string: "http://battleship.pixio.com/api/games")!
        let request: NSMutableURLRequest = NSMutableURLRequest(URL: url)
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
                }
            )
        })
    }
    
    func requestGameDetail(uuid:String) {
        let url: NSURL = NSURL(string: "http://battleship.pixio.com/api/games/\(uuid)")!
        let request: NSMutableURLRequest = NSMutableURLRequest(URL: url)
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
                        self.delegate!.gameDetailRecieved(data!)
                        //try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions()))
                    }
                }
            )
        })
    }
    
    func joinGame(playerName:String, gameId:String) {
        let url: NSURL = NSURL(string: "http://battleship.pixio.com/api/games/\(gameId)/join")!
        let request: NSMutableURLRequest = NSMutableURLRequest(URL: url)
        
        request.HTTPMethod = "POST"
        
        let playerNameDictionary:NSDictionary = ["playerName" : playerName]
        request.HTTPBody = try! NSJSONSerialization.dataWithJSONObject(playerNameDictionary, options: NSJSONWritingOptions())
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
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
                        self.delegate!.gameJoined(data!)
                        //try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions()))
                    }
                }
            )
        })
    }
    
    func createGame(gameName:String, playerName:String) {
        let url: NSURL = NSURL(string: "http://battleship.pixio.com/api/games")!
        let request: NSMutableURLRequest = NSMutableURLRequest(URL: url)
        
        request.HTTPMethod = "POST"
        
        let createGameDictionary:NSDictionary = ["gameName" : gameName, "playerName" : playerName]
        print(createGameDictionary)
        request.HTTPBody = try! NSJSONSerialization.dataWithJSONObject(createGameDictionary, options: NSJSONWritingOptions())
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
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
                        self.delegate!.gameCreated(data!)
                    }
                }
            )
        })
    }
}