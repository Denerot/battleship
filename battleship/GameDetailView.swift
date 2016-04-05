//
//  GameDetailView.swift
//  battleship
//
//  Created by Tigran Mnatsakanyan on 4/5/16.
//  Copyright © 2016 u0655487. All rights reserved.
//

import UIKit

class GameDetailView:UIView {
    var nameLabel:UILabel = UILabel()
    var playerOneLabel:UILabel = UILabel()
    var playerTwoLabel:UILabel = UILabel()
    var winnerLabel:UILabel = UILabel()
    var missilesLaunchedLabel:UILabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(nameLabel)
        addSubview(playerOneLabel)
        addSubview(playerTwoLabel)
        addSubview(winnerLabel)
        addSubview(missilesLaunchedLabel)
        backgroundColor = UIColor.whiteColor()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        var windowRect:CGRect = bounds
        
        //give each label frame a fifth of the window height
        (nameLabel.frame, windowRect) = windowRect.divide(windowRect.height * 0.2, fromEdge: .MinYEdge)
        (playerOneLabel.frame, windowRect) = windowRect.divide(windowRect.height * 0.2, fromEdge: CGRectEdge.MinYEdge)
        (playerTwoLabel.frame, windowRect) = windowRect.divide(windowRect.height * 0.2, fromEdge: CGRectEdge.MinYEdge)
        (winnerLabel.frame, windowRect) = windowRect.divide(windowRect.height * 0.2, fromEdge: CGRectEdge.MinYEdge)
        (missilesLaunchedLabel.frame, windowRect) = windowRect.divide(windowRect.height * 0.2, fromEdge: CGRectEdge.MinYEdge)
    }
}