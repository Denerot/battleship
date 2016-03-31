//
//  NotificationView.swift
//  battleship
//
//  Created by Tigran Mnatsakanyan on 3/24/16.
//  Copyright © 2016 u0655487. All rights reserved.
//

import UIKit

class NotificationView:UIView {
    private var messageLabel:UILabel = UILabel()
    private var cellStateHelp:UILabel = UILabel()
    private var stateDescriptions:String = "Blue = Empty, Hit = Orange, Miss = Yellow, Ship = Gray, Sunk = Red. Your ships are on the bottom grid. Launch missiles by clicking a spot on the top grid."
    var message:String = "" {
        didSet {
            messageLabel.text = message
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.whiteColor()
        cellStateHelp.text = stateDescriptions
        cellStateHelp.numberOfLines = 0
        
        
        cellStateHelp.lineBreakMode = NSLineBreakMode.ByWordWrapping
        
        cellStateHelp.sizeToFit()
        addSubview(messageLabel)
        addSubview(cellStateHelp)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        var windowRect:CGRect = bounds
        
        let orientation:UIInterfaceOrientation = UIApplication.sharedApplication().statusBarOrientation
        
        if orientation == .Portrait || orientation == .PortraitUpsideDown {
            // shave a little off of the top for the carrier/time/battery section
            (_, windowRect) = windowRect.divide(windowRect.height * 0.04, fromEdge: .MinYEdge)
            (messageLabel.frame, windowRect) = windowRect.divide(windowRect.height * 0.4, fromEdge: CGRectEdge.MinYEdge)
            // little space between message and help
            (_, windowRect) = windowRect.divide(windowRect.height * 0.01, fromEdge: .MinYEdge)
            (cellStateHelp.frame, windowRect) = windowRect.divide(windowRect.height, fromEdge: .MinYEdge)
        }
        else if orientation == .LandscapeLeft || orientation == .LandscapeRight {
            (messageLabel.frame, windowRect) = windowRect.divide(windowRect.width * 0.4, fromEdge: CGRectEdge.MinXEdge)
            (_, windowRect) = windowRect.divide(windowRect.width * 0.01, fromEdge: .MinXEdge)
            (cellStateHelp.frame, windowRect) = windowRect.divide(windowRect.width, fromEdge: .MinXEdge)
        }
    }
}
