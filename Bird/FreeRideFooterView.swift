//
//  FreeRideFooterView.swift
//  Bird
//
//  Created by Justin Wells on 6/6/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import UIKit

class FreeRideFooterView: UIView{
    
    var descriptionLabel = UILabel()
    var sendRidesButton = FreeRideButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //Setup View
        self.setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView(){
        self.backgroundColor = .white
        
        //Setup Main Label
        self.setupDescriptionLabel()
        
        //Setup Main Button
        self.setupSendRidesButton()
        
        //Setup Constraints
        self.setupConstraints()
    }
    
    func setupDescriptionLabel(){
        descriptionLabel.text = "freeRideDescriptionLabel".localized()
        descriptionLabel.textColor = .darkGray
        descriptionLabel.textAlignment = .center
        descriptionLabel.font = UIFont.systemFont(ofSize: 20)
        descriptionLabel.numberOfLines = 0
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(descriptionLabel)
    }
    
    func setupSendRidesButton(){
        sendRidesButton.setTitle("sendFreeRides".localized().uppercased(), for: .normal)
        sendRidesButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(sendRidesButton)
    }
    
    func setupConstraints(){
        let viewDict = ["descriptionLabel": descriptionLabel, "sendRidesButton": sendRidesButton] as [String : Any]
        //Width & Horizontal Alignment
        self.addConstraints([NSLayoutConstraint.init(item: descriptionLabel, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 0.7, constant: 0)])
        self.addConstraints([NSLayoutConstraint.init(item: descriptionLabel, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0)])
        self.addConstraints([NSLayoutConstraint.init(item: sendRidesButton, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 0.8, constant: 0)])
        self.addConstraints([NSLayoutConstraint.init(item: sendRidesButton, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0)])
        //Height & Vertical Alignment
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-20-[descriptionLabel]-20-[sendRidesButton(60)]-20-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
    }
}
