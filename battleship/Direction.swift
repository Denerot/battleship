//
//  Direction.swift
//  battleship
//
//  Created by Tigran Mnatsakanyan on 3/19/16.
//  Copyright © 2016 u0655487. All rights reserved.
//

import Foundation

/* Giving the cases a Uint rawValue will
 * let me generate a random direction */
enum Direction: UInt32 {
    case North
    case East
    case South
    case West
}