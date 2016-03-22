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
    let game:Game
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        gameView = GameView()
        game = Game()
        super.init(nibName: nil, bundle: nil)
        
        
        //view.setNeedsDisplay()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        if collectionView == gameView.launchGridView {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("LaunchGridCell", forIndexPath: indexPath)
            cell.backgroundColor=UIColor.whiteColor()
            cell.layer.borderWidth = 0.5
            cell.layer.borderColor = UIColor.blackColor().CGColor
            
            let cellLabel = UILabel(frame: CGRect(x: 1, y: 0, width: cell.frame.width, height: cell.frame.height))
            if(game.whosTurnIsIt == WhosTurn.PlayerOne) {
                if game.playerOne.launchHistory[Coordinate(x: indexPath.row, y: indexPath.section)] == GridState.Hit {
                    cellLabel.text = "Hit"
                }
                else if game.playerOne.launchHistory[Coordinate(x: indexPath.row, y: indexPath.section)] == GridState.Sunk {
                    cellLabel.text = "Sunk"
                }
            }
            else {
                if game.playerTwo.launchHistory[Coordinate(x: indexPath.row, y: indexPath.section)] == GridState.Hit {
                    cellLabel.text = "Hit"
                }
                else if game.playerTwo.launchHistory[Coordinate(x: indexPath.row, y: indexPath.section)] == GridState.Sunk {
                    cellLabel.text = "Sunk"
                }
            }
            cellLabel.font = cellLabel.font.fontWithSize(9)
            cell.contentView.addSubview(cellLabel)
            cell.setNeedsDisplay()
            cell.setNeedsLayout()
            return cell
        }
        else {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("PlayerGridCell", forIndexPath: indexPath)
            cell.backgroundColor=UIColor.cyanColor()
            cell.layer.borderWidth = 0.5
            cell.layer.borderColor = UIColor.blackColor().CGColor
            
            let cellLabel = UILabel(frame: CGRect(x: 1, y: 2, width: cell.frame.width, height: cell.frame.height))
            if(game.whosTurnIsIt == WhosTurn.PlayerOne) {
                if game.playerOne.playerGrid[Int(indexPath.row)][Int(indexPath.section)] == GridState.Ship {
                    cellLabel.text = "Ship"
                }
                else if game.playerOne.playerGrid[Int(indexPath.row)][Int(indexPath.section)] == GridState.Hit {
                    cellLabel.text = "Hit"
                }
                else if game.playerOne.playerGrid[Int(indexPath.row)][Int(indexPath.section)] == GridState.Sunk {
                    cellLabel.text = "Sunk"
                }
            }
            else {
                if game.playerTwo.playerGrid[Int(indexPath.row)][Int(indexPath.section)] == GridState.Ship {
                    cellLabel.text = "Ship"
                }
                else if game.playerTwo.playerGrid[Int(indexPath.row)][Int(indexPath.section)] == GridState.Hit {
                    cellLabel.text = "Hit"
                }
                else if game.playerTwo.playerGrid[Int(indexPath.row)][Int(indexPath.section)] == GridState.Sunk {
                    cellLabel.text = "Sunk"
                }
            }
            cellLabel.font = cellLabel.font.fontWithSize(9)
            cell.contentView.addSubview(cellLabel)
            cellLabel.setNeedsDisplay()
            cell.setNeedsDisplay()
            cell.setNeedsLayout()
            return cell
        }
        /*let cell = collectionView.dequeueReusableCellWithReuseIdentifier(NSStringFromClass(UICollectionViewCell.self), forIndexPath: indexPath)
        cell.backgroundColor=UIColor.whiteColor()
        let cellLabel = UILabel(frame: CGRect(x: 1, y: 0, width: cell.frame.width, height: cell.frame.height))
        if(game.whosTurnIsIt == WhosTurn.PlayerOne) {
            cellLabel.text = String(game.playerTwo.playerGrid[Int(indexPath.row)][Int(indexPath.section)])
            
        }
        cellLabel.font = cellLabel.font.fontWithSize(9)

        cell.contentView.addSubview(cellLabel)
        cell.setNeedsDisplay()
        return cell*/
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
        
        gameView.launchGridView.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: "LaunchGridCell")
        gameView.playerGridView.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: "PlayerGridCell")
        
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
