//
//  BRTextField.swift
//  Bird
//
//  Created by Justin Wells on 6/14/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import UIKit

class BRTextField: UITextField{
    
    private var bottomLine = CALayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //Customize TextField
        self.textColor = .darkGray
        self.tintColor = BRColor.secondary
        self.font = UIFont.systemFont(ofSize: 16)
        self.autocorrectionType = .no
        //Setup Bottom Line
        bottomLine.backgroundColor = BRColor.faintGray.cgColor
        self.layer.addSublayer(bottomLine)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.bottomLine.frame = CGRect(x: 0, y: self.frame.height, width: self.frame.width, height: 1)
    }
}
