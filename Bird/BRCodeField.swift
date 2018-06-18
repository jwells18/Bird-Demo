//
//  BRCodeField.swift
//  Bird
//
//  Created by Justin Wells on 6/15/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import UIKit

class BRCodeField: UITextField{
    
    private var bottomLine = CALayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //Customize TextField
        self.textColor = .darkGray
        self.textAlignment = .center
        self.font = UIFont.boldSystemFont(ofSize: 18)
        self.tintColor = BRColor.secondary
        self.font = UIFont.systemFont(ofSize: 16)
        self.autocorrectionType = .no
        self.placeholder = "code".localized()
        self.backgroundColor = .white
        self.layer.cornerRadius = 10
        self.returnKeyType = .done
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.bottomLine.frame = CGRect(x: 0, y: self.frame.height, width: self.frame.width, height: 1)
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 10, dy: 10)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 10, dy: 10)
    }
}
