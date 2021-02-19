//
//  Extensions.swift
//  InstagramClone
//
//  Created by Jaidyn Belbin on 19/2/21.
//

import UIKit

// Extension properties for UIView instances to easily compute common distances
extension UIView {
    
    public var width: CGFloat {
        frame.size.width
    }
    
    public var height: CGFloat {
        frame.size.height
    }
    
    // Origin is at top-left corner of View
    public var top: CGFloat {
        frame.origin.y
    }
    
    public var left: CGFloat {
        frame.origin.x
    }
    
    public var bottom: CGFloat {
        frame.origin.y + frame.size.height
    }
    
    public var right: CGFloat {
        frame.origin.x + frame.size.width
    }
}
