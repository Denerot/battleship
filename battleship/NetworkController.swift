//
//  NetworkController.swift
//  battleship
//
//  Created by Tigran Mnatsakanyan on 4/3/16.
//  Copyright © 2016 u0655487. All rights reserved.
//

import Foundation

protocol NetworkControllerDelegate: class {
    func updateGameListArray(gameListData:NSData)
    func presentGameDetailController(gameData:NSDictionary)
    func openNewGame(gameDictionary:NSDictionary)
    func openExistingGame(playerIdDictionary:NSDictionary)
}

class NetworkController:NetworkDelegate {
    let network:Network = Network()
    //weak var gameListDelegate:GameListDelegate? = nil
    weak var delegate:NetworkControllerDelegate? = nil
    
    init() {
        network.delegate = self
        network.requestGameList()
    }
    
    func updateGameList(gameListData: NSData) {
        delegate?.updateGameListArray(gameListData)
    }
    
    func gameDetailRecieved(gameData:NSData) {
        let gameDictionary:NSDictionary = try! NSJSONSerialization.JSONObjectWithData(gameData, options: NSJSONReadingOptions()) as! NSDictionary
        delegate?.presentGameDetailController(gameDictionary)
    }
    
    func gameJoined(playerId: NSData) {
        let playerIdDictionary:NSDictionary = try! NSJSONSerialization.JSONObjectWithData(playerId, options: NSJSONReadingOptions()) as! NSDictionary
        print("game joined player id: \(playerIdDictionary["playerId"])")
        delegate?.openExistingGame(playerIdDictionary)
    }
    
    func gameCreated(gameData: NSData) {
        let gameDictionary:NSDictionary = try! NSJSONSerialization.JSONObjectWithData(gameData, options: NSJSONReadingOptions()) as! NSDictionary
        print("game created id: \(gameDictionary["gameId"])")
        print("game created playerId: \(gameDictionary["playerId"])")
        let documentsDirectory: NSString? = NSSearchPathForDirectoriesInDomains(
            .DocumentDirectory, .UserDomainMask, true)[0] as NSString?
        let filePath: String? = documentsDirectory?.stringByAppendingPathComponent("battleshipGames.json")
        print(filePath)
        let fileHandle = NSFileHandle(forUpdatingAtPath: filePath!)
        if fileHandle == nil {
            let fileManager = NSFileManager()
            fileManager.createFileAtPath(filePath!, contents: gameData, attributes: nil)
        }
        else {
            fileHandle!.seekToEndOfFile()
            fileHandle!.writeData(gameData)
            fileHandle!.closeFile()
        }
        delegate?.openNewGame(gameDictionary)
    }
}