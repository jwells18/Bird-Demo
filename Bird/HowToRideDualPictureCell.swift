//
//  HowToRideDualPictureCell.swift
//  Bird
//
//  Created by Justin Wells on 6/6/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import UIKit

class HowToRideDualPictureCell: UICollectionViewCell{
    
    var titleLabel = UILabel()
    var imageView1 = UIImageView()
    var imageView2 = UIImageView()
    var subTitleLabel1 = UILabel()
    var subTitleLabel2 = UILabel()
    
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
        
        //Setup ImageView1
        self.imageView1.contentMode = .center
        self.imageView1.clipsToBounds = true
        self.imageView1.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(imageView1)
        
        //Setup ImageView2
        self.imageView2.contentMode = .center
        self.imageView2.clipsToBounds = true
        self.imageView2.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(imageView2)
        
        //Setup Title Label
        self.titleLabel.textColor = .white
        self.titleLabel.font = UIFont.boldSystemFont(ofSize: 36)
        self.titleLabel.textAlignment = .center
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(titleLabel)
        
        //Setup SubTitle Label1
        self.subTitleLabel1.textColor = .white
        self.subTitleLabel1.font = UIFont.boldSystemFont(ofSize: 18)
        self.subTitleLabel1.textAlignment = .center
        self.subTitleLabel1.numberOfLines = 0
        self.subTitleLabel1.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(subTitleLabel1)
        
        //Setup SubTitle Label2
        self.subTitleLabel2.textColor = .white
        self.subTitleLabel2.font = UIFont.boldSystemFont(ofSize: 18)
        self.subTitleLabel2.textAlignment = .center
        self.subTitleLabel2.numberOfLines = 0
        self.subTitleLabel2.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(subTitleLabel2)
        
        //Setup Constraints
        self.setupConstraints()
    }
    
    func setupConstraints(){
        let spacerViewTop = UIView()
        spacerViewTop.isUserInteractionEnabled = false
        spacerViewTop.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(spacerViewTop)
        let spacerViewBottom = UIView()
        spacerViewBottom.isUserInteractionEnabled = false
        spacerViewBottom.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(spacerViewBottom)
        
        let viewDict = ["imageView1": imageView1, "imageView2": imageView2, "titleLabel": titleLabel, "subTitleLabel1": subTitleLabel1, "subTitleLabel2": subTitleLabel2, "spacerViewTop": spacerViewTop, "spacerViewBottom": spacerViewBottom] as [String : Any]
        //Width & Horizontal Alignment
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-20-[titleLabel]-20-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-20-[imageView1]-20-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-20-[imageView2]-20-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-20-[subTitleLabel1]-20-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-20-[subTitleLabel2]-20-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-20-[spacerViewTop]-20-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-20-[spacerViewBottom]-20-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        //Height & Vertical Alignment
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-20-[titleLabel(40)][spacerViewTop(==spacerViewBottom)][imageView1(==imageView2)]-[subTitleLabel1][spacerViewBottom(==spacerViewBottom)][imageView2(==imageView1)]-[subTitleLabel2]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
    }
    
    func configure(image: [UIImage?], title: String, subTitle: [String]){
        if image[0] != nil{
            imageView1.image = (image[0])!
        }
        else{
            imageView1.image = nil
        }
        if image[1] != nil{
            imageView2.image = (image[1])!
        }
        else{
            imageView2.image = nil
        }
        titleLabel.text = title.localized()
        subTitleLabel1.text = subTitle[0].localized()
        subTitleLabel2.text = subTitle[1].localized()
    }
}
