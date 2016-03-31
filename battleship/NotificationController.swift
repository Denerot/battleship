//
//  NotificationController.swift
//  battleship
//
//  Created by Tigran Mnatsakanyan on 3/24/16.
//  Copyright © 2016 u0655487. All rights reserved.
//

import UIKit

protocol NotificationDelegate: class {
    func dismissNotification()
}

class NotificationController:UIViewController {
    var notificationView:NotificationView
    weak var delegate:NotificationDelegate? = nil
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        notificationView = NotificationView()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        view = notificationView
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        delegate?.dismissNotification()
    }
}
