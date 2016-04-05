//
//  GameDetailViewController.swift
//  battleship
//
//  Created by Tigran Mnatsakanyan on 4/5/16.
//  Copyright © 2016 u0655487. All rights reserved.
//

import UIKit

class GameDetailViewController:UIViewController {
    let gameDetailView:GameDetailView
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        gameDetailView = GameDetailView()
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
        view = gameDetailView
    }
}