//
//  NetworkController.swift
//  battleship
//
//  Created by Tigran Mnatsakanyan on 4/3/16.
//  Copyright © 2016 u0655487. All rights reserved.
//

import Foundation

protocol NetworkControllerDelegate: class {
    func updateGameListArray(gameListData:NSData)
    func presentGameDetailController(gameData:NSDictionary)
}

class NetworkController:NetworkDelegate {
    let network:Network = Network()
    //weak var gameListDelegate:GameListDelegate? = nil
    weak var delegate:NetworkControllerDelegate? = nil
    
    init() {
        network.delegate = self
        network.requestGameList()
    }
    
    func updateGameList(gameListData: NSData) {
        delegate?.updateGameListArray(gameListData)
    }
    
    func gameDetailRecieved(gameData:NSData) {
        let gameDictionary:NSDictionary = try! NSJSONSerialization.JSONObjectWithData(gameData, options: NSJSONReadingOptions()) as! NSDictionary
        delegate?.presentGameDetailController(gameDictionary)
    }
}