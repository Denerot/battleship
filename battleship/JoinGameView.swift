//
//  JoinGameView.swift
//  battleship
//
//  Created by Tigran Mnatsakanyan on 4/5/16.
//  Copyright © 2016 u0655487. All rights reserved.
//

import UIKit

protocol JoinGameViewDelegate:class {
    func playerReady()
}

class JoinGameView:UIView {
    var playerNameLabel:UILabel = UILabel()
    var playerNameInput:UITextField = UITextField()
    var joinGameButton:UIButton
    weak var delegate:JoinGameViewDelegate? = nil
    
    override init(frame: CGRect) {
        joinGameButton = UIButton.init(type: .System)
        super.init(frame: frame)
        playerNameLabel.text = "Player Name:"
        playerNameInput.placeholder = "Enter Name"
        joinGameButton.setTitle("Join Game", forState: .Normal)
        joinGameButton.addTarget(delegate, action: "playerReady", forControlEvents: UIControlEvents.TouchUpInside)
        addSubview(playerNameLabel)
        addSubview(playerNameInput)
        addSubview(joinGameButton)
        backgroundColor = UIColor.whiteColor()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        var windowRect:CGRect = bounds
        var textInputRect:CGRect
        var buttonRect:CGRect
        
        (_, windowRect) = windowRect.divide(windowRect.height * 0.2, fromEdge: .MinYEdge)
        (textInputRect, windowRect) = windowRect.divide(windowRect.height * 0.05, fromEdge: CGRectEdge.MinYEdge)
        (_, textInputRect) = textInputRect.divide(textInputRect.width * 0.1, fromEdge: CGRectEdge.MinXEdge)
        (playerNameLabel.frame, textInputRect) = textInputRect.divide(textInputRect.width * 0.4, fromEdge: CGRectEdge.MinXEdge)
        (playerNameInput.frame, textInputRect) = textInputRect.divide(textInputRect.width * 0.9, fromEdge: CGRectEdge.MinXEdge)
        (_, windowRect) = windowRect.divide(windowRect.height * 0.01, fromEdge: CGRectEdge.MinYEdge)
        (buttonRect, windowRect) = windowRect.divide(windowRect.height * 0.05, fromEdge: CGRectEdge.MinYEdge)
        (_, buttonRect) = buttonRect.divide(buttonRect.width * 0.2, fromEdge: CGRectEdge.MinXEdge)
        (joinGameButton.frame, buttonRect) = buttonRect.divide(buttonRect.width * 0.5, fromEdge: CGRectEdge.MinXEdge)
        playerNameInput.layer.borderWidth = 1.0
        playerNameInput.layer.borderColor = UIColor.blackColor().CGColor
        joinGameButton.layer.borderWidth = 1.0
        joinGameButton.layer.borderColor = UIColor.blackColor().CGColor
    }
}
