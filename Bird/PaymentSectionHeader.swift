//
//  PaymentSectionHeader.swift
//  Bird
//
//  Created by Justin Wells on 6/6/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import UIKit

class PaymentSectionHeader: UIView{
    
    var titleLabel = UILabel()
    var bottomBorderLine = UIView()
    
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
        
        //Setup Title Label
        self.setupTitleLabel()
        
        //Setup bottomBorderLine
        self.setupBottomBorderLine()
        
        //Setup Constraints
        self.setupConstraints()
    }
    
    func setupTitleLabel(){
        self.titleLabel.textColor = .lightGray
        self.titleLabel.textAlignment = .center
        self.titleLabel.font = UIFont.boldSystemFont(ofSize: 12)
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(titleLabel)
    }
    
    func setupBottomBorderLine(){
        self.bottomBorderLine.backgroundColor = .lightGray
        self.bottomBorderLine.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(bottomBorderLine)
    }
    
    func setupConstraints(){
        let viewDict = ["titleLabel": titleLabel, "bottomBorderLine": bottomBorderLine] as [String : Any]
        //Width & Horizontal Alignment
        self.addConstraints([NSLayoutConstraint.init(item: titleLabel, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 1, constant: 0)])
        self.addConstraints([NSLayoutConstraint.init(item: bottomBorderLine, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 1, constant: 0)])
        //Height & Vertical Alignment
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[titleLabel][bottomBorderLine(0.5)]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
    }
    
    func configure(title: String){
        self.titleLabel.text = title.localized().uppercased()
    }
}
