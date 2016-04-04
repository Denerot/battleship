//
//  Player.swift
//  battleship
//
//  Created by tigran mnatsakanyan on 3/15/16.
//  Copyright © 2016 u0655487. All rights reserved.
//

import UIKit

class Player {
    var playerGrid:[[GridState]]
    var launchHistory:[Coordinate: GridState] = [:]
    //var launchGrid:[[GridState]]
    var ships:[Ship] = [Ship]()
    
    var launchHistoryJSON:NSMutableDictionary = NSMutableDictionary()
    
    init() {
        // 10x10 grids with each spot's value initialized to empty
        /*
        launchGrid = Array(count: 10, repeatedValue: Array(count: 10, repeatedValue: .Empty))*/
        playerGrid = Array(count: 10, repeatedValue: Array(count: 10, repeatedValue: .Empty))
        // mutable vars for creating ships for the ships array, within loop below
        var ship:Ship
        var facingDirection:Direction
        var startingCoordinate:Coordinate
        // A player needs 4 ships
        // counting from two so that the index can match desired ship size (2,3,4,5)
        for var i=2; i<6; i++ {
            startingCoordinate = generateRandomStartingPoint()
            facingDirection = generateRandomDirection()
            // Try another starting point and direction until there is no overlap
            while shipOverlaps(startingCoordinate, size: i, direction: facingDirection) {
                startingCoordinate = generateRandomStartingPoint()
                facingDirection = generateRandomDirection()
            }
            ship = Ship(size: Int(i), facing: facingDirection, startingCoordinate: startingCoordinate)
            ships.append(ship)
            for shipCoord in ship.coords {
                playerGrid[shipCoord.x][shipCoord.y] = .Ship
            }
        }
    }
    
    func generateRandomDirection() -> Direction {
        //generate random number from 0 to 3
        let directionRawValue:UInt32 = arc4random_uniform(4)
        // create a direction from the random raw value
        let direction = Direction(rawValue: directionRawValue)
        return direction!
    }
    
    func generateRandomStartingPoint() -> Coordinate {
        //generate random coordinates from 0 to 9
        let randomX:UInt32 = arc4random_uniform(10)
        let randomY:UInt32 = arc4random_uniform(10)
        let randomCoordinate:Coordinate = Coordinate(x: Int(randomX), y: Int(randomY))
        return randomCoordinate
    }
    
    /**
     * Returns true if the ship of the given size would
     * overlap the edge of the game board or a previously
     * set ship
    **/
    func shipOverlaps(startingCoord:Coordinate, size:Int, direction:Direction) -> Bool {
        let remainingSize:Int = size-1
        
        // check to see if starting coordinate overlaps a ship
        if(playerGrid[Int(startingCoord.x)][Int(startingCoord.y)] == GridState.Ship) {
            return true
        }
        
        // now, depending on direction, check if ship overlaps another ship
        switch direction {
        case .North:
            // overlaps top of the board
            if startingCoord.y - remainingSize < 0 {
                return true;
            }
            for var i=1; i<size; i++ {
                // check for ships in the north within size
                if(playerGrid[startingCoord.x][startingCoord.y - i] == .Ship) {
                    return true
                }
            }
        case .East:
            // overlaps right side of the board
            if startingCoord.x + remainingSize > 9 {
                return true
            }
            for var i=1; i<size; i++ {
                // check for ships in the east
                if playerGrid[startingCoord.x + i][startingCoord.y] == .Ship {
                    return true
                }
            }
        case .South:
            // overlaps bottom of the board
            if startingCoord.y + remainingSize > 9 {
                return true
            }
            for var i=1; i<size; i++ {
                // check for ships in the south
                if(playerGrid[startingCoord.x][startingCoord.y + i] == .Ship) {
                    return true
                }
            }
        case .West:
            // overlaps left side of the board
            if startingCoord.x - remainingSize < 0 {
                return true
            }
            for var i=1; i<size; i++ {
                // check for ships in the west
                if(playerGrid[startingCoord.x - i][startingCoord.y] == .Ship) {
                    return true
                }
            }
        }
        
        // no problems here, capn
        return false
    }
    
    func printGrid() {
        for rowIndex in 0...9 {
            for colIndex in 0...9 {
                print(playerGrid[colIndex][rowIndex], terminator:"")
            }
            print("")
        }
    }
}