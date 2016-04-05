//
//  NetworkController.swift
//  battleship
//
//  Created by Tigran Mnatsakanyan on 4/3/16.
//  Copyright © 2016 u0655487. All rights reserved.
//

import Foundation

protocol NetworkDelegate: class {
    func updateGameList(gameListData:NSData)
}



class NetworkController:NetworkDelegate {
    let network:Network = Network()
    weak var gameListDelegate:GameListDelegate? = nil
    
    init() {
        network.delegate = self
        network.requestGameList()
    }
    
    func updateGameList(gameListData: NSData) {
        gameListDelegate?.updateGameList(gameListData)
    }
}