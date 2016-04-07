//
//  GameController.swift
//  battleship
//
//  Created by Tigran Mnatsakanyan on 3/20/16.
//  Copyright © 2016 u0655487. All rights reserved.
//

import UIKit

protocol GameDelegate: class {
    func playerWon(whoWon:GameState)
}

class GameViewController:UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    var gameView:GameView
    var game:Game
    weak var delegate: GameDelegate? = nil
    weak var appDelegate:AppDelegate? = nil
    
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
            
            
            if game.player.playerBoard["opponentBoard"]![indexPath.item] as! GridState == GridState.HIT {
                cell.cellState = GridState.HIT
            }
            else if game.player.playerBoard["opponentBoard"]![indexPath.item] as! GridState == GridState.MISS {
                cell.cellState = GridState.MISS
            }
            else {
                cell.cellState = GridState.NONE
            }
            
            return cell
        }
        else {
            let cell = gameView.playerGridView.dequeueReusableCellWithReuseIdentifier("PlayerGridCell", forIndexPath: indexPath) as! GameCell
            cell.layer.borderColor = UIColor.whiteColor().CGColor
            
            if game.player.playerBoard["playerBoard"]![indexPath.item] as! GridState == GridState.SHIP {
                cell.cellState = GridState.SHIP
            }
            else if game.player.playerBoard["playerBoard"]![indexPath.item] as! GridState == GridState.HIT {
                cell.cellState = GridState.HIT
            }
            else {
                cell.cellState = GridState.NONE
            }
            
            return cell
        }
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        appDelegate!.launchMissile(indexPath.item)
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
