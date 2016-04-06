//
//  Player.swift
//  battleship
//
//  Created by tigran mnatsakanyan on 3/15/16.
//  Copyright © 2016 u0655487. All rights reserved.
//

import UIKit

class Player {
    var playerId:NSUUID
    var playerName:String = ""
    var playerBoard:NSDictionary = NSDictionary()
    
    init(playerId:NSUUID) {
        self.playerId = playerId
    }
}