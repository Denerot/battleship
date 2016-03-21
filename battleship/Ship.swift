//
//  Ship.swift
//  battleship
//
//  Created by Tigran Mnatsakanyan on 3/19/16.
//  Copyright © 2016 u0655487. All rights reserved.
//

import Foundation

class Ship {
    
    var size:Int
    var hp:Int
    var coords = [Coordinate]()
    
    init(size:Int, facing:Direction, startingCoordinate:Coordinate) {
        self.size = size
        self.hp = size
        
        coords.append(startingCoordinate)
        
        /* Fill in the remaining coordinates by using the direction
         * in which the ship is facing.
         *
         * The game will check missile coordinates against ship coordinates
         * when detecting whether or not a missile launch was successfull.
         *
         * Ship coordinates are added to each player's grid, after ship creation.
         */
        for var i=1; i<size; i++ {
            // append to the ships coordinates by retreiving the
            switch facing {
            case .North:
                coords.append(Coordinate(x: coords[i-1].x, y: coords[i-1].y-1))
            case .East:
                coords.append(Coordinate(x: coords[i-1].x+1, y: coords[i-1].y))
            case .South:
                coords.append(Coordinate(x: coords[i-1].x, y: coords[i-1].y+1))
            case .West:
                coords.append(Coordinate(x: coords[i-1].x-1, y: coords[i-1].y))
            }
        }
    }
}