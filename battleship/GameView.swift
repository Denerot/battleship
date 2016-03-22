//
//  GameScreen.swift
//  battleship
//
//  Created by Tigran Mnatsakanyan on 3/20/16.
//  Copyright © 2016 u0655487. All rights reserved.
//

import UIKit

class GameView:UIView {
    //player grid
    
    //launch grid
    
    var launchGridView:UICollectionView
    var layout:UICollectionViewFlowLayout
    let playerGridView:UICollectionView
    
    override init(frame: CGRect) {
    
        layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0;
        layout.minimumLineSpacing = 0;
        launchGridView = UICollectionView(frame: CGRectZero, collectionViewLayout: layout)
        playerGridView = UICollectionView(frame: CGRectZero, collectionViewLayout: layout)
        super.init(frame: frame)
        
        launchGridView.backgroundColor = UIColor.greenColor()

        playerGridView.backgroundColor = UIColor.blueColor()
        
        addSubview(launchGridView)
        addSubview(playerGridView)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        var windowRect:CGRect = bounds
        
        let orientation:UIInterfaceOrientation = UIApplication.sharedApplication().statusBarOrientation
        
        if orientation == .Portrait || orientation == .PortraitUpsideDown {
            // shave a little off of the top for the carrier/time/battery section
            (_, windowRect) = windowRect.divide(windowRect.height * 0.04, fromEdge: .MinYEdge)
            (launchGridView.frame, windowRect) = windowRect.divide(windowRect.height * 0.5, fromEdge: CGRectEdge.MinYEdge)
            (playerGridView.frame, windowRect) = windowRect.divide(windowRect.height, fromEdge: .MinYEdge)
        }
        else if orientation == .LandscapeLeft || orientation == .LandscapeRight {
            (launchGridView.frame, windowRect) = windowRect.divide(windowRect.width * 0.5, fromEdge: CGRectEdge.MinXEdge)
            (playerGridView.frame, windowRect) = windowRect.divide(windowRect.width, fromEdge: .MinXEdge)
        }
        
        layout.itemSize = CGSize(width: launchGridView.frame.width * 0.1, height: launchGridView.frame.height * 0.1)
    }
}
