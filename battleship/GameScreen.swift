//
//  GameScreen.swift
//  battleship
//
//  Created by Tigran Mnatsakanyan on 3/20/16.
//  Copyright © 2016 u0655487. All rights reserved.
//

import UIKit

class GameScreen:UIView {
    //player grid
    
    //launch grid
    
    var launchGridView:UICollectionView
    let playerGridView:UIView = UIView()
    
    override init(frame: CGRect) {
        let layout:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        launchGridView = UICollectionView(frame: frame, collectionViewLayout: layout)
    
        super.init(frame: frame)
        
        launchGridView.backgroundColor = UIColor.greenColor()
        playerGridView.backgroundColor = UIColor.redColor()
        
        addSubview(launchGridView)
        addSubview(playerGridView)
        setNeedsDisplay()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        var windowRect:CGRect = bounds
        
        let orientation:UIInterfaceOrientation = UIApplication.sharedApplication().statusBarOrientation
        
        if orientation == .Portrait || orientation == .PortraitUpsideDown {
            (launchGridView.frame, windowRect) = windowRect.divide(windowRect.height * 0.5, fromEdge: CGRectEdge.MinYEdge)
            (playerGridView.frame, windowRect) = windowRect.divide(windowRect.height, fromEdge: .MinYEdge)
        }
        else if orientation == .LandscapeLeft || orientation == .LandscapeRight {
            (launchGridView.frame, windowRect) = windowRect.divide(windowRect.width * 0.5, fromEdge: CGRectEdge.MinXEdge)
            (playerGridView.frame, windowRect) = windowRect.divide(windowRect.width, fromEdge: .MinXEdge)
        }
        

    }

}
