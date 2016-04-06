//
//  JoinGameViewController.swift
//  battleship
//
//  Created by Tigran Mnatsakanyan on 4/5/16.
//  Copyright © 2016 u0655487. All rights reserved.
//

import UIKit

protocol JoinGameViewControllerDelegate:class {
    func joinGame(playerName:String, gameId:String)
}

class JoinGameViewController:UIViewController, JoinGameViewDelegate {
    let joinGameView:JoinGameView
    var gameToJoin:String = ""
    weak var delegate:JoinGameViewControllerDelegate? = nil
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        joinGameView = JoinGameView()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("view loaded")
    }
    override func loadView() {
        super.loadView()
        print("loading view")
        view = joinGameView
    }
    
    func playerReady() {
        if joinGameView.playerNameInput.text! == "" {
            joinGameView.playerNameInput.text = "Anonymous"
        }
        
        delegate?.joinGame(joinGameView.playerNameInput.text!, gameId: gameToJoin)
    }
}
