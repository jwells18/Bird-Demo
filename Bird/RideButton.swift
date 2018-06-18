//
//  RideButton.swift
//  Bird
//
//  Created by Justin Wells on 6/5/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import UIKit

class RideButton: UIButton{
    
    private var innerButton = UIButton()
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
        gradient.colors = [BRColor.tertiary.cgColor, BRColor.secondary.cgColor]
        self.layer.insertSublayer(gradient, at: 0)
        
        //Setup Inner Button
        self.innerButton.backgroundColor = .white
        self.innerButton.setTitle("ride".localized().uppercased(), for: .normal)
        self.innerButton.setTitleColor(UIColor.darkGray, for: .normal)
        self.innerButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        self.innerButton.clipsToBounds = true
        self.innerButton.isUserInteractionEnabled = false
        self.addSubview(innerButton)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //Set Frames
        gradient.frame = self.bounds
        self.layer.cornerRadius = frame.width/2
        self.innerButton.frame = CGRect(x: 5, y: 5, width: self.frame.width-10, height: self.frame.height-10)
        self.innerButton.layer.cornerRadius = self.innerButton.frame.width/2
    }
}


