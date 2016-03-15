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
    
    var whosTurnIsIt:WhosTurn;
    
    init() {
        whosTurnIsIt = .PlayerOne
    }
}
