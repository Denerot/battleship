//
//  Game.swift
//  battleship
//
//  Created by tigran mnatsakanyan on 3/15/16.
//  Copyright © 2016 u0655487. All rights reserved.
//

import Foundation

enum GameState:Int {
    case Start
    case InProgress
    case PlayerOneWon
    case PlayerTwoWon
}

enum GameStatus:Int {
    case DONE
    case WAITING
    case PLAYING
}

class Game {
    
    var isMyTurn:Bool;
    
    let player:Player
    var gameId:String
    
    init(gameId:String) {
        self.gameId = gameId
        player = Player()
        isMyTurn = false;
    }
    
    init(gameId:String, isMyTurn:Bool) {
        self.gameId = gameId
        player = Player()
        self.isMyTurn = isMyTurn
    }
    
    init() {
        self.gameId = ""
        self.player = Player(playerId: "")
        self.isMyTurn = false
    }
}
