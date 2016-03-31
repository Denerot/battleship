//
//  GridState.swift
//  battleship
//
//  Created by Tigran Mnatsakanyan on 3/21/16.
//  Copyright © 2016 u0655487. All rights reserved.
//

import Foundation

enum GridState:Int {
    case Empty
    case Ship
    case Hit
    case Miss
    case Sunk
}