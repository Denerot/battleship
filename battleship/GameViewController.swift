//
//  GameController.swift
//  battleship
//
//  Created by Tigran Mnatsakanyan on 3/20/16.
//  Copyright © 2016 u0655487. All rights reserved.
//

import UIKit

class GameViewController:UIViewController, UICollectionViewDataSource {
    var gameView:GameScreen
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        gameView = GameScreen(frame:CGRectZero)
        
        super.init(nibName: nil, bundle: nil)
        gameView.frame = view.frame
        let game:Game = Game()
        
        //view.setNeedsDisplay()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(NSStringFromClass(UICollectionViewCell.self), forIndexPath: indexPath)
        cell.backgroundColor=UIColor.whiteColor()
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    func collectionView(collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
            return CGSize(width: 100, height: 100)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        gameView.launchGridView.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: NSStringFromClass(UICollectionView.self))
        gameView.launchGridView.dataSource = self
        print("view loaded")
    }
    override func loadView() {
        super.loadView()
        print("loading view")
        view = gameView
    }
}
