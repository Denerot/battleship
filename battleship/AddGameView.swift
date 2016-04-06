//
//  JoinGameView.swift
//  battleship
//
//  Created by Tigran Mnatsakanyan on 4/5/16.
//  Copyright © 2016 u0655487. All rights reserved.
//

import UIKit

protocol AddGameViewDelegate:class {
    func createGame()
}

class AddGameView:UIView {
    var gameNameLabel:UILabel = UILabel()
    var gameNameInput:UITextField = UITextField()
    var playerNameLabel:UILabel = UILabel()
    var playerNameInput:UITextField = UITextField()
    var addGameButton:UIButton
    weak var delegate:AddGameViewDelegate? = nil
    
    override init(frame: CGRect) {
        addGameButton = UIButton.init(type: .System)
        super.init(frame: frame)
        gameNameLabel.text = "Game Name:"
        gameNameInput.placeholder = "battleshipz"
        playerNameLabel.text = "Player Name:"
        playerNameInput.placeholder = "admiral ackbar"
        addGameButton.setTitle("Create Game", forState: .Normal)
        addGameButton.addTarget(delegate, action: "createGame", forControlEvents: UIControlEvents.TouchUpInside)
        addSubview(gameNameInput)
        addSubview(gameNameLabel)
        addSubview(playerNameLabel)
        addSubview(playerNameInput)
        addSubview(addGameButton)
        backgroundColor = UIColor.whiteColor()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        var windowRect:CGRect = bounds
        var textInputRect:CGRect
        var textInputRect2:CGRect
        var buttonRect:CGRect
        
        (_, windowRect) = windowRect.divide(windowRect.height * 0.2, fromEdge: .MinYEdge)
        (textInputRect, windowRect) = windowRect.divide(windowRect.height * 0.05, fromEdge: CGRectEdge.MinYEdge)
        (_, textInputRect) = textInputRect.divide(textInputRect.width * 0.1, fromEdge: CGRectEdge.MinXEdge)
        (gameNameLabel.frame, textInputRect) = textInputRect.divide(textInputRect.width * 0.4, fromEdge: CGRectEdge.MinXEdge)
        (gameNameInput.frame, textInputRect) = textInputRect.divide(textInputRect.width * 0.9, fromEdge: CGRectEdge.MinXEdge)
        
        (textInputRect2, windowRect) = windowRect.divide(windowRect.height * 0.05, fromEdge: CGRectEdge.MinYEdge)
        (_, textInputRect2) = textInputRect2.divide(textInputRect2.width * 0.1, fromEdge: CGRectEdge.MinXEdge)
        (playerNameLabel.frame, textInputRect2) = textInputRect2.divide(textInputRect2.width * 0.4, fromEdge: CGRectEdge.MinXEdge)
        (playerNameInput.frame, textInputRect2) = textInputRect2.divide(textInputRect2.width * 0.9, fromEdge: CGRectEdge.MinXEdge)
        
        (_, windowRect) = windowRect.divide(windowRect.height * 0.01, fromEdge: CGRectEdge.MinYEdge)
        (buttonRect, windowRect) = windowRect.divide(windowRect.height * 0.05, fromEdge: CGRectEdge.MinYEdge)
        (_, buttonRect) = buttonRect.divide(buttonRect.width * 0.2, fromEdge: CGRectEdge.MinXEdge)
        (addGameButton.frame, buttonRect) = buttonRect.divide(buttonRect.width * 0.5, fromEdge: CGRectEdge.MinXEdge)
        
        playerNameInput.layer.borderWidth = 1.0
        playerNameInput.layer.borderColor = UIColor.blackColor().CGColor
        
        gameNameInput.layer.borderWidth = 1.0
        gameNameInput.layer.borderColor = UIColor.blackColor().CGColor
        
        addGameButton.layer.borderWidth = 1.0
        addGameButton.layer.borderColor = UIColor.blackColor().CGColor
    }
}
