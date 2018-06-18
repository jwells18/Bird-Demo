//
//  BRBarButtonItem.swift
//  Bird
//
//  Created by Justin Wells on 6/5/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import UIKit

class BRBarButtonItem: UIBarButtonItem{
    
    private override init() {
        super.init()
        //Add Inset to Button Image
        self.imageInsets = UIEdgeInsetsMake(4, 4, 4, 4)
        self.setTitleTextAttributes([NSFontAttributeName: UIFont.boldSystemFont(ofSize: 12), NSForegroundColorAttributeName: UIColor.white], for: .normal)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
