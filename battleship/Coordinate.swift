//
//  Coordinate.swift
//  battleship
//
//  Created by Tigran Mnatsakanyan on 3/19/16.
//  Copyright © 2016 u0655487. All rights reserved.
//

import Foundation

struct Coordinate:Hashable {
    var x:Int
    var y:Int
    
    init(x:Int, y:Int) {
        self.x = x;
        self.y = y;
    }
    var hashValue : Int {
        get {
            return "\(self.x),\(self.y)".hashValue
        }
    }
}
// to be hashable, I guess you have to be equatable as well, http://www.swiftcoder.info/dev/codefellows/2014/8/2/how-to-implement-hashable-for-your-custom-class
func ==(lhs: Coordinate, rhs: Coordinate) -> Bool {
    return lhs.hashValue == rhs.hashValue
}