//
//  AppDelegate.swift
//  battleship
//
//  Created by tigran mnatsakanyan on 3/15/16.
//  Copyright © 2016 u0655487. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, GameDelegate, NotificationDelegate, GameListControllerDelegate, NetworkControllerDelegate, JoinGameViewControllerDelegate, AddGameViewDelegate {

    var window: UIWindow?
    var notificationController:NotificationController = NotificationController()
    var gameController:GameViewController = GameViewController()
    var gameListController:GameListController = GameListController()
    var networkController:NetworkController = NetworkController()
    var gameDetailViewController:GameDetailViewController = GameDetailViewController()
    var joinGameViewController:JoinGameViewController = JoinGameViewController()
    var addGameViewController:AddGameViewController = AddGameViewController()
    var gameListNavigationController:UINavigationController

    override init() {
        gameListNavigationController = UINavigationController(rootViewController: gameListController)

        super.init()
    }
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow()
        gameController.delegate = self
        gameListController.delegate = self
        notificationController.delegate = self
        networkController.delegate = self
        networkController.network.appDelegate = self
        joinGameViewController.delegate = self
        addGameViewController.addGameView.delegate = self
        gameListController.title = "Lobby"
        
        // get initial game list
        networkController.network.requestGameList()
        
        window?.rootViewController = gameListNavigationController
        
        //window?.rootViewController = gameController
        window?.makeKeyAndVisible()
        
        return true
    }
    
    func updateGameListArray(gameListData: NSData) {
        gameListController.gameList.updateGameList(gameListData)
        gameListController.gameListView.reloadData()
    }
    
    func presentAddGameController() {
        gameListNavigationController.pushViewController(addGameViewController, animated: true)
    }
    
    func createGame() {
        networkController.network.createGame(addGameViewController.addGameView.gameNameInput.text!, playerName: addGameViewController.addGameView.playerNameInput.text!)
    }
    
    func openNewGame(gameDictionary:NSDictionary) {
        //gameListNavigationController.pushViewController(gameController, animated: true)
        window?.rootViewController = gameController
        gameController.game = Game(gameId: gameDictionary["gameId"] as! NSUUID, whosTurn: WhosTurn.PlayerOne)
        gameController.game.playerOne.playerId = gameDictionary["playerId"] as! NSUUID
        networkController.network.requestPlayerBoard(gameController.game.gameId, playerId: gameController.game.playerOne.playerId)
    }
    
    func openExistingGame(playerIdDictionary: NSDictionary) {
        //gameListNavigationController.pushViewController(gameController, animated: true)
        window?.rootViewController = gameController
    }

    func presentGameDetailController(gameData: NSDictionary) {
        print("non playable game selected")
        gameDetailViewController.title = gameData["name"] as! String
        gameDetailViewController.gameDetailView.playerOneLabel.text = "Player one: \(gameData["player1"] as! String)"
        gameDetailViewController.gameDetailView.playerTwoLabel.text = "Player two: \(gameData["player2"] as! String)"
        gameDetailViewController.gameDetailView.winnerLabel.text = "Winner: \(gameData["winner"] as! String)"
        gameDetailViewController.gameDetailView.missilesLaunchedLabel.text = "Missiles Launched: \(String(gameData["missilesLaunched"] as! Int))"
        gameListNavigationController.pushViewController(gameDetailViewController, animated: true)
    }
    
    func nonJoinableGameSelected(uuid: String) {
        networkController.network.requestGameDetail(uuid)
    }
    func joinableGameSelected(uuid: String) {
        joinGameViewController.gameToJoin = uuid
        gameListNavigationController.pushViewController(joinGameViewController, animated: true)
        
    }
    
    func joinGame(playerName:String, gameId:String) {
        networkController.network.joinGame(playerName, gameId: gameId)
    }
    
    func updateGameBoard(gameId:NSUUID, playerId:NSUUID, playerGrids:NSDictionary) {
        if gameController.game.playerOne.playerId == playerId {
            gameController.game.playerOne.playerBoard = playerGrids
        }
        else if gameController.game.playerTwo.playerId == playerId {
            gameController.game.playerTwo.playerBoard = playerGrids
            gameController.gameView.launchGridView.reloadData()
            gameController.gameView.playerGridView.reloadData()
        }
        else {
            print("ERROR playerid for playerboard doesn't match either player in game")
        }
    }
    
    func playerTurn(whosTurn:WhosTurn) {
        notificationController.notificationView.message = "\(whosTurn)'s turn, please pass the device."
        gameController.presentViewController(notificationController, animated: true, completion: {
            self.gameController.gameView.launchGridView.reloadData()
            self.gameController.gameView.playerGridView.reloadData()
        })
    }
    
    func playerWon(whoWon:GameState) {
        notificationController.notificationView.message = "\(whoWon)"
        gameController.presentViewController(notificationController, animated: true, completion: {})
    }
    
    func dismissNotification() {
        notificationController.notificationView.message = ""
        gameController.dismissViewControllerAnimated(true, completion: {})
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

