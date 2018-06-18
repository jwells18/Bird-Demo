//
//  HowToRideLocalRulesCell.swift
//  Bird
//
//  Created by Justin Wells on 6/6/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import UIKit

class HowToRideLocalRulesCell: UICollectionViewCell{
    
    var titleLabel = UILabel()
    var textView = UITextView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //Setup View
        self.setupView()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    func setupView(){
        self.backgroundColor = .clear
        
        //Setup Title Label
        self.titleLabel.text = "localRules".localized()
        self.titleLabel.textColor = .white
        self.titleLabel.font = UIFont.boldSystemFont(ofSize: 36)
        self.titleLabel.textAlignment = .center
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(titleLabel)
        
        //Setup SubTitle Label
        self.textView.text = "localRulesSubTitle".localized()
        self.textView.backgroundColor = .clear
        self.textView.textColor = .white
        self.textView.font = UIFont.boldSystemFont(ofSize: 18)
        self.textView.isUserInteractionEnabled = false
        self.textView.showsVerticalScrollIndicator = false
        self.textView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(textView)
        
        //Setup Constraints
        self.setupConstraints()
    }
    
    func setupConstraints(){
        let viewDict = ["titleLabel": titleLabel, "textView": textView] as [String : Any]
        //Width & Horizontal Alignment
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-20-[titleLabel]-20-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-20-[textView]-20-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        //Height & Vertical Alignment
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-20-[titleLabel(40)]-20-[textView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
    }
}
