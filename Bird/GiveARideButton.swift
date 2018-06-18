//
//  GiveARideButton.swift
//  Bird
//
//  Created by Justin Wells on 6/5/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import UIKit

class GiveARideButton: UIButton{
    
    var giveARideLabel = UILabel()
    var giveARideImageView = UIImageView()
    
    public override init(frame: CGRect){
        super.init(frame: frame)
        //Setup View
        self.setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView(){
        self.backgroundColor = BRColor.primary
        self.layer.cornerRadius = 5
        
        //Setup Return Label
        self.setupGiveARideLabel()
        
        //Setup Return IconView
        self.setupGiveARideImageView()
        
        //Setup Constraints
        self.setupConstraints()
    }
    
    func setupGiveARideLabel(){
        giveARideLabel.text = "giveARideGetARide".localized().uppercased()
        giveARideLabel.textColor = .white
        giveARideLabel.font = UIFont.boldSystemFont(ofSize: 14)
        giveARideLabel.numberOfLines = 2
        giveARideLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(giveARideLabel)
    }
    
    func setupGiveARideImageView(){
        giveARideImageView.image = UIImage(named: "invite")
        giveARideImageView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(giveARideImageView)
    }
    
    func setupConstraints(){
        let viewDict = ["giveARideLabel": giveARideLabel, "giveARideImageView": giveARideImageView] as [String : Any]
        //Width & Horizontal Alignment
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-20-[giveARideLabel]-4-[giveARideImageView(50)]-20-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        //Height & Vertical Alignment
        self.addConstraints([NSLayoutConstraint.init(item: giveARideLabel, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0)])
        self.addConstraints([NSLayoutConstraint.init(item: giveARideImageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0)])
        self.addConstraints([NSLayoutConstraint.init(item: giveARideImageView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 50)])
    }
}

