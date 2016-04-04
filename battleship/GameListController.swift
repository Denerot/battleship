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
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
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