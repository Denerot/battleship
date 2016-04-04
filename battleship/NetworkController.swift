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

class NetworkController:NSObject,NSURLSessionDataDelegate {
    let network:Network = Network()
    weak var networkDelegate:NetworkDelegate? = nil
    
    override init() {
        super.init()
        network.delegate = self
        network.requestGameList()
    }
    
    func URLSession(session: NSURLSession, dataTask: NSURLSessionDataTask, didReceiveResponse response: NSURLResponse, completionHandler: (NSURLSessionResponseDisposition) -> Void) {
        completionHandler(NSURLSessionResponseDisposition.Allow)
        dataTask.resume()
    }
    func URLSession(session: NSURLSession, dataTask: NSURLSessionDataTask, didBecomeDownloadTask downloadTask: NSURLSessionDownloadTask) {
        //
    }
    func URLSession(session: NSURLSession, dataTask: NSURLSessionDataTask, didBecomeStreamTask streamTask: NSURLSessionStreamTask) {
        //
    }
    func URLSession(session: NSURLSession, dataTask: NSURLSessionDataTask, didReceiveData data: NSData) {
        networkDelegate?.updateGameList(data)
        dataTask.resume()
    }
    func URLSession(session: NSURLSession, dataTask: NSURLSessionDataTask, willCacheResponse proposedResponse: NSCachedURLResponse, completionHandler: (NSCachedURLResponse?) -> Void) {
        //
    }
}