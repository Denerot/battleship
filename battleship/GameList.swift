//
//  GameList.swift
//  battleship
//
//  Created by Tigran Mnatsakanyan on 3/25/16.
//  Copyright © 2016 u0655487. All rights reserved.
//

import Foundation

class GameList {
    
    var gameList:NSArray = NSArray()
    
    init() {
    }
    
    func saveGame() {
        
    }
    
    func loadGame() {
        
    }
    
    func updateGameList(gameListData:NSData) {
        gameList = try! NSJSONSerialization.JSONObjectWithData(gameListData, options: NSJSONReadingOptions()) as! NSArray
    }
    
    
}