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
    
    var whosTurnIsIt:WhosTurn;
    
    let playerOne:Player
    let playerTwo:Player
    var gameJSON:NSMutableDictionary = NSMutableDictionary()
    var gameId:NSUUID
    /*let uuid:NSUUID
    var gameState:GameState
    var name:String = "shaboopi"
    var status:GameStatus = .WAITING*/
    
    init(gameId:NSUUID) {
        self.gameId = gameId
        playerOne = Player()
        playerTwo = Player()
        whosTurnIsIt = WhosTurn.PlayerOne
    }
    
    init(gameId:NSUUID, whosTurn:WhosTurn) {
        self.gameId = gameId
        playerOne = Player()
        playerTwo = Player()
        whosTurnIsIt = whosTurn
    }
}
