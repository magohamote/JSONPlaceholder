//
//  RefreshControl.swift
//  JSONPlaceholder
//
//  Created by Cédric Rolland on 17.11.17.
//  Copyright © 2017 Rolland Cédric. All rights reserved.
//

import Foundation
import UIKit

class RefreshControl: UIRefreshControl {
    
    required override public init() {
        super.init()
        self.tintColor = UIColor(rgb: 0x25ac72)
        self.backgroundColor = .white
    }
    
    required public init(coder aDecoder: NSCoder) {
        fatalError("use init(frame:) instead")
    }
}
