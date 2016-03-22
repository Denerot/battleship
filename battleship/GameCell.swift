//
//  GameCell.swift
//  battleship
//
//  Created by Tigran Mnatsakanyan on 3/21/16.
//  Copyright © 2016 u0655487. All rights reserved.
//

import UIKit

class GameCell:UICollectionViewCell {
    private var label:UILabel
    var cellState:GridState = GridState.Empty
    override init(frame: CGRect) {
        label = UILabel(frame: frame)
        super.init(frame: frame)
        sizeToFit()
        
        updateLabel()
        label.font = label.font.fontWithSize(9)
        layer.borderWidth = 0.5
        layer.borderColor = UIColor.blackColor().CGColor
        contentView.addSubview(label)
        setNeedsDisplay()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func prepareForReuse() {
        updateLabel()
        setNeedsDisplay()
    }
    
    func updateLabel() {
        switch cellState {
        case .Empty:
            label.text = ""
        case .Hit:
            label.text = "Hit"
        case .Miss:
            label.text = "Miss"
        case .Ship:
            label.text = "Ship"
        case .Sunk:
            label.text = "Sunk"
        }
    }
}