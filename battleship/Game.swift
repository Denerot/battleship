//
//  Game.swift
//  battleship
//
//  Created by tigran mnatsakanyan on 3/15/16.
//  Copyright © 2016 u0655487. All rights reserved.
//

import Foundation

class Game {
    
    enum WhosTurn {
        case PlayerOne
        case PlayerTwo
    }
    
    enum GameState {
        case Start
        case InProgress
        case PlayerOneWon
        case PlayerTwoWon
    }
    
    var whosTurnIsIt:WhosTurn;
    
    let playerOne:Player
    let playerTwo:Player
    
    let gameState:GameState
    
    init() {
        whosTurnIsIt = .PlayerOne
        playerOne = Player()
        playerTwo = Player()
        gameState = .Start
    }
    
    func launchMissle() {
        
    }
}
