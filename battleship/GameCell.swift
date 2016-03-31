//
//  GameCell.swift
//  battleship
//
//  Created by Tigran Mnatsakanyan on 3/21/16.
//  Copyright © 2016 u0655487. All rights reserved.
//

import UIKit

class GameCell:UICollectionViewCell {
    var cellState:GridState = GridState.Empty {
        didSet {
            updateLabel()
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        updateLabel()
        layer.borderWidth = 0.5
        layer.borderColor = UIColor.blackColor().CGColor
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateLabel() {
        switch cellState {
        case .Empty:
            backgroundColor = UIColor.blueColor()
        case .Hit:
            backgroundColor = UIColor.orangeColor()
        case .Miss:
            backgroundColor = UIColor.yellowColor()
        case .Ship:
            backgroundColor = UIColor.grayColor()
        case .Sunk:
            backgroundColor = UIColor.redColor()
        }
    }
}