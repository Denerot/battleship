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

class Game {
    
    var whosTurnIsIt:WhosTurn;
    
    let playerOne:Player
    let playerTwo:Player
    var gameJSON:NSMutableDictionary = NSMutableDictionary()
    var playerOneGridJSON:NSMutableDictionary = NSMutableDictionary()
    var playerOneLaunchHistoryJSON:NSMutableDictionary = NSMutableDictionary()
    var playerTwoGridJSON:NSMutableDictionary = NSMutableDictionary()
    var playerTwoLaunchHistoryJSON:NSMutableDictionary = NSMutableDictionary()
    let uuid:NSUUID
    var gameState:GameState
    
    init() {
        uuid = NSUUID()
        whosTurnIsIt = .PlayerOne
        playerOne = Player()
        playerTwo = Player()
        gameState = .Start
        saveGame()
    }
    
    func saveGame() {
        gameJSON.setObject(uuid.UUIDString, forKey: "uuid")
        gameJSON.setObject(gameState.rawValue, forKey: "gameState")
        gameJSON.setObject(whosTurnIsIt.rawValue, forKey: "whosTurnIsIt")
        
        // copy player one grid to ns dictionary
        for var x=0; x<10; x++ {
            for var y=0; y<10; y++ {
                let cellState:GridState = playerOne.playerGrid[x][y]
                playerOneGridJSON.setObject(cellState.rawValue, forKey: "\(x),\(y)")
            }
        }
        // copy player two grid to ns dictionary
        for var x=0; x<10; x++ {
            for var y=0; y<10; y++ {
                let cellState:GridState = playerTwo.playerGrid[x][y]
                playerTwoGridJSON.setObject(cellState.rawValue, forKey: "\(x),\(y)")
            }
        }
        // copy launch histories to dictionaries
        for (coord, cellState) in playerOne.launchHistory {
            playerOneLaunchHistoryJSON.setObject(cellState.rawValue, forKey: "\(coord.x),\(coord.y)")
        }
        for (coord, cellState) in playerTwo.launchHistory {
            playerTwoLaunchHistoryJSON.setObject(cellState.rawValue, forKey: "\(coord.x),\(coord.y)")
        }
        
        gameJSON.setObject(playerOneGridJSON, forKey: "playerOneGrid")
        gameJSON.setObject(playerTwoGridJSON, forKey: "playerTwoGrid")
        
        gameJSON.setObject(playerOneLaunchHistoryJSON, forKey: "playerOneLaunchHistory")
        gameJSON.setObject(playerTwoLaunchHistoryJSON, forKey: "playerTwoLaunchHistory")
        
        print(gameJSON)
    }
    
    
    func launchMissle(location:Coordinate, whosTurn:WhosTurn) {
        if whosTurn == WhosTurn.PlayerOne {
            print("player one's turn")
            // does the opponent have a ship there?
            if playerTwo.playerGrid[location.x][location.y] == GridState.Ship {
                // hit!
                playerOne.launchHistory[location] = GridState.Hit
                print("p1 hit p2 \(location.x),\(location.y)")
                // check which ship was hit
                for (index, ship) in playerTwo.ships.enumerate() {
                    if ship.coords.contains(location) {
                        ship.hp -= 1
                        // mark it in the other player's grid so they can see their ship has been hit
                        playerTwo.playerGrid[location.x][location.y] = GridState.Hit
                        // if ship done died, remove it from ships, and change gridstates on ship coords to sunk
                        if ship.hp <= 0 {
                            print("ship sunk")
                            for coord in ship.coords {
                                playerTwo.playerGrid[coord.x][coord.y] = GridState.Sunk
                                playerOne.launchHistory[coord] = GridState.Sunk
                            }
                            playerTwo.ships.removeAtIndex(index)
                            if playerTwo.ships.isEmpty {
                                // Player one wins!
                                print("Player One Wins")
                                gameState = GameState.PlayerOneWon
                            }
                        }
                    }
                }
            }
            else {
                // misfire
                print("miss")
                playerOne.launchHistory[location] = GridState.Miss
            }
            self.whosTurnIsIt = WhosTurn.PlayerTwo
        }
        else { //playa 2 turn
            print("player 2's turn")
            // does the opponent have a ship there?
            if playerOne.playerGrid[location.x][location.y] == GridState.Ship {
                // hit!
                playerTwo.launchHistory[location] = GridState.Hit
                print("p2 hit p1 \(location.x),\(location.y)")
                // check which ship was hit
                for (index, ship) in playerOne.ships.enumerate() {
                    if ship.coords.contains(location) {
                        ship.hp -= 1
                        // mark it in the other player's grid so they can see their ship has been hit
                        playerOne.playerGrid[location.x][location.y] = GridState.Hit
                        // if ship done died, remove it from ships, and change gridstates on ship coords to sunk
                        if ship.hp <= 0 {
                            print("ship sunk!")
                            for coord in ship.coords {
                                playerOne.playerGrid[coord.x][coord.y] = GridState.Sunk
                                playerTwo.launchHistory[coord] = GridState.Sunk
                            }
                            playerOne.ships.removeAtIndex(index)
                            if playerOne.ships.isEmpty {
                                // Player two wins!
                                print("Player Two Wins")
                                gameState = GameState.PlayerTwoWon
                            }
                        }
                    }
                }
            }
            else {
                // misfire
                playerTwo.launchHistory[location] = GridState.Miss
                print("miss")
            }
            self.whosTurnIsIt = WhosTurn.PlayerOne
        }
    }
}
