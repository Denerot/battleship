//
//  GameCell.swift
//  battleship
//
//  Created by Tigran Mnatsakanyan on 3/21/16.
//  Copyright © 2016 u0655487. All rights reserved.
//

import UIKit

class GameCell:UICollectionViewCell {
    var cellState:GridState = GridState.NONE {
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
        case .NONE:
            backgroundColor = UIColor.blueColor()
        case .HIT:
            backgroundColor = UIColor.redColor()
        case .MISS:
            backgroundColor = UIColor.yellowColor()
        case .SHIP:
            backgroundColor = UIColor.grayColor()
        }
    }
}