//
//  FreeRideButton.swift
//  Bird
//
//  Created by Justin Wells on 6/6/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import UIKit

class FreeRideButton: UIButton{
    
    private var gradient = CAGradientLayer()
    
    public override init(frame: CGRect){
        super.init(frame: frame)
        //Setup View
        self.setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView(){
        //Setup Outer Button
        self.backgroundColor = .white
        self.clipsToBounds = true
        self.layer.cornerRadius = 5
        gradient.colors = [BRColor.tertiary.cgColor, BRColor.secondary.cgColor]
        self.layer.insertSublayer(gradient, at: 0)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //Set Frames
        gradient.frame = self.bounds
    }
}
