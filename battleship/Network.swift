//
//  Network.swift
//  battleship
//
//  Created by Tigran Mnatsakanyan on 4/3/16.
//  Copyright © 2016 u0655487. All rights reserved.
//

import Foundation

class Network {
    let scheme:String = "http"
    let host:String = "battleship.pixio.com"
    let gameListPath:String = "/api/games"
    weak var delegate: NSURLSessionDataDelegate? = nil
    
    init() {
        
    }
    
    func requestGameList() {
        let gameListComponents:NSURLComponents = NSURLComponents()
        gameListComponents.scheme = scheme
        gameListComponents.host = host
        gameListComponents.path = gameListPath
        let gamesListUrl:NSURL = gameListComponents.URL!
        let request = NSURLRequest(URL: gamesListUrl)
        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession(configuration: config, delegate: delegate, delegateQueue: nil)
        let task = session.dataTaskWithRequest(request)
        task.resume()
    }
}