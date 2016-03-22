//
//  GameController.swift
//  battleship
//
//  Created by Tigran Mnatsakanyan on 3/20/16.
//  Copyright © 2016 u0655487. All rights reserved.
//

import UIKit

class GameViewController:UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    var gameView:GameView
    var game:Game
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        gameView = GameView()
        game = Game()
        super.init(nibName: nil, bundle: nil)
        
        
        view.setNeedsDisplay()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        if collectionView == gameView.launchGridView {
            let cell = gameView.launchGridView.dequeueReusableCellWithReuseIdentifier("LaunchGridCell", forIndexPath: indexPath) as! GameCell
            print("row \(indexPath.row)")
            print("item \(indexPath.item)")
            print("section \(indexPath.section)")
            
            if(game.whosTurnIsIt == WhosTurn.PlayerOne) {
                if game.playerOne.launchHistory[Coordinate(x: indexPath.row, y: indexPath.section)] == GridState.Hit {
                    cell.cellState = GridState.Hit
                }
                else if game.playerOne.launchHistory[Coordinate(x: indexPath.row, y: indexPath.section)] == GridState.Sunk {
                    cell.cellState = GridState.Sunk
                }
            }
            else {
                if game.playerTwo.launchHistory[Coordinate(x: indexPath.row, y: indexPath.section)] == GridState.Hit {
                    cell.cellState = GridState.Hit
                }
                else if game.playerTwo.launchHistory[Coordinate(x: indexPath.row, y: indexPath.section)] == GridState.Sunk {
                    cell.cellState = GridState.Sunk
                }
            }
            cell.setNeedsDisplay()
            return cell
        }
        else {
            let cell = gameView.playerGridView.dequeueReusableCellWithReuseIdentifier("PlayerGridCell", forIndexPath: indexPath) as! GameCell

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
            }
            cell.setNeedsDisplay()
            return cell
        }
    }
    
    /* Since this controller is only a delegate for the launch grid, we don't need to check which collectionView
     * is calling this, it's guaranteed to be the launchGrid */
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        print("firing missile to \(indexPath.row),\(indexPath.section)")
        game.launchMissle(Coordinate(x: indexPath.row, y: indexPath.section), whosTurn: game.whosTurnIsIt)
        print("Other person's turn, no peeking!")
        gameView.launchGridView.reloadData()
        gameView.playerGridView.reloadData()
        view.setNeedsDisplay()
        gameView.setNeedsDisplay()
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
        view.setNeedsDisplay()
        gameView.setNeedsDisplay()
        print("view loaded")
    }
    override func loadView() {
        super.loadView()
        print("loading view")
        view = gameView
    }
    
    
}
