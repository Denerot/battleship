//
//  GameListController.swift
//  battleship
//
//  Created by Tigran Mnatsakanyan on 3/30/16.
//  Copyright © 2016 u0655487. All rights reserved.
//

import UIKit

class GameListController:UIViewController, NSURLSessionDataDelegate, UITableViewDelegate, UITableViewDataSource {
    var gameList:GameList
    let gameListView:GameListView
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        gameList = GameList()
        gameListView = GameListView()
        super.init(nibName: nil, bundle: nil)
        
        gameList.delegate = self
        gameList.requestGamesList()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        //print(dataString)
        let string1 = NSString(data: data, encoding: NSUTF8StringEncoding)
        print(string1)
        gameList.populateGamesList(data)
        
    }
    func URLSession(session: NSURLSession, dataTask: NSURLSessionDataTask, willCacheResponse proposedResponse: NSCachedURLResponse, completionHandler: (NSCachedURLResponse?) -> Void) {
        //
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //
        return gameList.gameList.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //
        let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
        cell.textLabel!.text = "test"
        return cell
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gameListView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        gameListView.dataSource = self
        gameListView.delegate = self
        
        print("view loaded")
    }
    override func loadView() {
        super.loadView()
        print("loading view")
        view = gameListView
    }
}