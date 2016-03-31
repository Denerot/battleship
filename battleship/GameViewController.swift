//
//  GameController.swift
//  battleship
//
//  Created by Tigran Mnatsakanyan on 3/20/16.
//  Copyright © 2016 u0655487. All rights reserved.
//

import UIKit

protocol GameDelegate: class {
    func playerTurn(whosTurn:WhosTurn)
    func playerWon(whoWon:GameState)
}

class GameViewController:UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    var gameView:GameView
    var game:Game
    weak var delegate: GameDelegate? = nil
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        gameView = GameView()
        game = Game()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        if collectionView == gameView.launchGridView {
            let cell = gameView.launchGridView.dequeueReusableCellWithReuseIdentifier("LaunchGridCell", forIndexPath: indexPath) as! GameCell
            cell.layer.borderColor = UIColor.blackColor().CGColor
            
            if(game.whosTurnIsIt == WhosTurn.PlayerOne) {
                if game.playerOne.launchHistory[Coordinate(x: indexPath.row, y: indexPath.section)] == GridState.Sunk {
                    cell.cellState = GridState.Sunk
                }
                else if game.playerOne.launchHistory[Coordinate(x: indexPath.row, y: indexPath.section)] == GridState.Hit {
                    cell.cellState = GridState.Hit
                }
                else if game.playerOne.launchHistory[Coordinate(x: indexPath.row, y: indexPath.section)] == GridState.Miss {
                    cell.cellState = GridState.Miss
                }
                else {
                    cell.cellState = GridState.Empty
                }
            }
            else {
                
                if game.playerTwo.launchHistory[Coordinate(x: indexPath.row, y: indexPath.section)] == GridState.Sunk {
                    cell.cellState = GridState.Sunk
                }
                else if game.playerTwo.launchHistory[Coordinate(x: indexPath.row, y: indexPath.section)] == GridState.Hit {
                    cell.cellState = GridState.Hit
                }
                else if game.playerTwo.launchHistory[Coordinate(x: indexPath.row, y: indexPath.section)] == GridState.Miss {
                    cell.cellState = GridState.Miss
                }
                else {
                    cell.cellState = GridState.Empty
                }
            }
            return cell
        }
        else {
            let cell = gameView.playerGridView.dequeueReusableCellWithReuseIdentifier("PlayerGridCell", forIndexPath: indexPath) as! GameCell
            cell.layer.borderColor = UIColor.whiteColor().CGColor
            
            if(game.whosTurnIsIt == WhosTurn.PlayerOne) {
                if game.playerOne.playerGrid[indexPath.row][indexPath.section] == GridState.Ship {
                    cell.cellState = GridState.Ship
                }
                else if game.playerOne.playerGrid[indexPath.row][indexPath.section] == GridState.Hit {
                    cell.cellState = GridState.Hit
                }
                else if game.playerOne.playerGrid[indexPath.row][indexPath.section] == GridState.Sunk {
                    cell.cellState = GridState.Sunk
                }
                else {
                    cell.cellState = GridState.Empty
                }
            }
            else {
                if game.playerTwo.playerGrid[indexPath.row][indexPath.section] == GridState.Ship {
                    cell.cellState = GridState.Ship
                }
                else if game.playerTwo.playerGrid[indexPath.row][indexPath.section] == GridState.Hit {
                    cell.cellState = GridState.Hit
                }
                else if game.playerTwo.playerGrid[indexPath.row][indexPath.section] == GridState.Sunk {
                    cell.cellState = GridState.Sunk
                }
                else {
                    cell.cellState = GridState.Empty
                }
            }
            return cell
        }
    }
    
    /* Since this controller is only a delegate for the launch grid, we don't need to check which collectionView
     * is calling this, it's guaranteed to be the launchGrid */
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        print("firing missile to \(indexPath.row),\(indexPath.section)")
        game.launchMissle(Coordinate(x: indexPath.row, y: indexPath.section), whosTurn: game.whosTurnIsIt)
        print("Other person's turn, no peeking!")
        if(game.gameState == GameState.PlayerOneWon) {
            delegate?.playerWon(GameState.PlayerOneWon)
        }
        else if game.gameState == GameState.PlayerTwoWon {
            delegate?.playerWon(GameState.PlayerTwoWon)
        }
        else {
            delegate?.playerTurn(game.whosTurnIsIt)
        }
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 10
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        gameView.launchGridView.registerClass(GameCell.self, forCellWithReuseIdentifier: "LaunchGridCell")
        gameView.playerGridView.registerClass(GameCell.self, forCellWithReuseIdentifier: "PlayerGridCell")
        
        gameView.launchGridView.dataSource = self
        gameView.launchGridView.delegate = self
        
        gameView.playerGridView.dataSource = self
        print("view loaded")
    }
    override func loadView() {
        super.loadView()
        print("loading view")
        view = gameView
    }
    
    
}
