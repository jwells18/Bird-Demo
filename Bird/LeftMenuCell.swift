//
//  LeftMenuCell.swift
//  Bird
//
//  Created by Justin Wells on 6/5/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import UIKit

class LeftMenuCell: UITableViewCell{
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        //Setup View
        self.setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView(){
        self.selectionStyle = .none
        self.backgroundColor = .clear
        self.layer.backgroundColor = UIColor.clear.cgColor
        self.textLabel?.textColor = .white
        self.textLabel?.font = UIFont.systemFont(ofSize: 12)
    }
    
    func configure(image: UIImage?, title: String?){
        self.textLabel?.text = title
        self.imageView?.image = image
    }
}
