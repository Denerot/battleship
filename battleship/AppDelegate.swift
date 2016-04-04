//
//  AppDelegate.swift
//  battleship
//
//  Created by tigran mnatsakanyan on 3/15/16.
//  Copyright © 2016 u0655487. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, GameDelegate, NotificationDelegate, NetworkDelegate {

    var window: UIWindow?
    var notificationController:NotificationController = NotificationController()
    var gameController:GameViewController = GameViewController()
    var gameListController:GameListController = GameListController()
    var networkController:NetworkController = NetworkController()

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow()
        gameController.delegate = self
        notificationController.delegate = self
        networkController.networkDelegate = self
        window?.rootViewController = gameListController
        //window?.rootViewController = gameController
        window?.makeKeyAndVisible()
        
        return true
    }
    
    func updateGameList(gameListData: NSData) {
        gameListController.gameList.updateGameList(gameListData)
        gameListController.gameListView.reloadData()
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

