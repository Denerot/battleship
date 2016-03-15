//
//  Player.swift
//  battleship
//
//  Created by tigran mnatsakanyan on 3/15/16.
//  Copyright © 2016 u0655487. All rights reserved.
//

import Foundation

class Player {
    
    enum state {
        case empty
        case ship
        case hit
        case miss
        case sunk
    }
    
    var grid:[[state]]
    
    init() {
        
    }
}