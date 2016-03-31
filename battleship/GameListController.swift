//
//  GameListController.swift
//  battleship
//
//  Created by Tigran Mnatsakanyan on 3/30/16.
//  Copyright © 2016 u0655487. All rights reserved.
//

import UIKit

class GameListController:NSObject, NSURLSessionDataDelegate, UITableViewDelegate, UITableViewDataSource {
    var gameList:GameList
    
    override init() {
        gameList = GameList()
        super.init()
        
        gameList.delegate = self
        gameList.requestGamesList()
    }
    func URLSession(session: NSURLSession, dataTask: NSURLSessionDataTask, didReceiveResponse response: NSURLResponse, completionHandler: (NSURLSessionResponseDisposition) -> Void) {
        completionHandler(NSURLSessionResponseDisposition.Allow)
    }
    func URLSession(session: NSURLSession, dataTask: NSURLSessionDataTask, didBecomeDownloadTask downloadTask: NSURLSessionDownloadTask) {
        //
    }
    func URLSession(session: NSURLSession, dataTask: NSURLSessionDataTask, didBecomeStreamTask streamTask: NSURLSessionStreamTask) {
        //
    }
    func URLSession(session: NSURLSession, dataTask: NSURLSessionDataTask, didReceiveData data: NSData) {
        let dataString = NSString(data: data, encoding: NSUTF8StringEncoding)
        //print(dataString)
        gameList.populateGamesList(data)
        
    }
    func URLSession(session: NSURLSession, dataTask: NSURLSessionDataTask, willCacheResponse proposedResponse: NSCachedURLResponse, completionHandler: (NSCachedURLResponse?) -> Void) {
        //
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //
        return 2
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //
        return UITableViewCell()
    }
}