//
//  GameListController.swift
//  battleship
//
//  Created by Tigran Mnatsakanyan on 3/30/16.
//  Copyright © 2016 u0655487. All rights reserved.
//

import UIKit

protocol GameListDelegate: class {
    func updateGameList(gameListData:NSData)
    func getGameDetail(uuid:String)
}

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
        return gameList.gameList.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: GameListCell = tableView.dequeueReusableCellWithIdentifier("GameListCell", forIndexPath: indexPath) as! GameListCell
        
        cell.textLabel!.text = gameList.gameList[indexPath.item]["name"] as! String

        cell.detailTextLabel!.text = gameList.gameList[indexPath.item]["status"] as! String
            
        return cell
    }
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        <#code#>
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gameListView.registerClass(GameListCell.self, forCellReuseIdentifier: "GameListCell")
        
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