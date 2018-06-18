//
//  ScanABirdView.swift
//  Bird
//
//  Created by Justin Wells on 6/15/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import UIKit

class ScanABirdView: UIView{
    
    var scooterImageView: UIImageView!
    var scooterCodeButton: UIButton!
    var enterCodeButton: UIButton!
    var flashButton: UIButton!
    var enterCodeField: BRCodeField!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //Setup View
        self.setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView(){
        //Setup Scooter ImageView
        self.setupScooterImageView()
        
        //Setup Scooter Code Button
        self.setupScooterCodeButton()
        
        //Setup Flash Button
        self.setupFlashButton()
        
        //Setup Previous Button
        self.setupEnterCodeButton()
        
        //Setup EnterCode TextField
        self.setupEnterCodeField()
        
        //Setup Constraints
        self.setupConstraints()
    }
    
    func setupScooterImageView(){
        scooterImageView = UIImageView(image: UIImage(named: "scooter"))
        scooterImageView.clipsToBounds = true
        scooterImageView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(scooterImageView)
    }
    
    func setupScooterCodeButton(){
        scooterCodeButton = UIButton(frame: .zero)
        scooterCodeButton.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        scooterCodeButton.setImage(UIImage(named: "qrCode"), for: .normal)
        scooterCodeButton.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        scooterCodeButton.imageEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        scooterCodeButton.clipsToBounds = true
        scooterCodeButton.layer.borderWidth = 2
        scooterCodeButton.layer.borderColor = BRColor.quaternary.cgColor
        scooterCodeButton.layer.cornerRadius = 40/2
        scooterCodeButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(scooterCodeButton)
    }
    
    func setupEnterCodeButton(){
        enterCodeButton = UIButton(frame: .zero)
        enterCodeButton.setTitle("codeButtonTitle".localized().uppercased(), for: .normal)
        enterCodeButton.setTitleColor(.darkGray, for: .normal)
        enterCodeButton.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        enterCodeButton.backgroundColor = .white
        enterCodeButton.clipsToBounds = true
        enterCodeButton.layer.cornerRadius = 50/2
        enterCodeButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(enterCodeButton)
    }
    
    func setupFlashButton(){
        flashButton = UIButton(frame: .zero)
        flashButton.setImage(UIImage(named: "flashOff"), for: .normal)
        flashButton.backgroundColor = .white
        flashButton.clipsToBounds = true
        flashButton.layer.cornerRadius = 50/2
        flashButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(flashButton)
    }
    
    func setupEnterCodeField(){
        enterCodeField = BRCodeField(frame: .zero)
        enterCodeField.isHidden = true
        enterCodeField.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(enterCodeField)
    }
    
    func setupConstraints(){
        //Width & Horizontal Alignment
        self.addConstraint(NSLayoutConstraint.init(item: scooterImageView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 100))
        self.addConstraint(NSLayoutConstraint.init(item: scooterImageView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint.init(item: scooterCodeButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 40))
        self.addConstraint(NSLayoutConstraint.init(item: scooterCodeButton, attribute: .centerX, relatedBy: .equal, toItem: self.scooterImageView, attribute: .centerX, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint.init(item: enterCodeButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 50))
        self.addConstraint(NSLayoutConstraint.init(item: enterCodeButton, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: -50))
        self.addConstraint(NSLayoutConstraint.init(item: flashButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 50))
        self.addConstraint(NSLayoutConstraint.init(item: flashButton, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 50))
        self.addConstraint(NSLayoutConstraint.init(item: enterCodeField, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 0.5, constant: 0))
        self.addConstraint(NSLayoutConstraint.init(item: enterCodeField, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
        //Height & Vertical Alignment
        self.addConstraint(NSLayoutConstraint.init(item: scooterImageView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 100))
        self.addConstraint(NSLayoutConstraint.init(item: scooterImageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 0.75, constant: -150))
        self.addConstraint(NSLayoutConstraint.init(item: scooterCodeButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 40))
        self.addConstraint(NSLayoutConstraint.init(item: scooterCodeButton, attribute: .top, relatedBy: .equal, toItem: self.scooterImageView, attribute: .top, multiplier: 1, constant: -20))
        self.addConstraint(NSLayoutConstraint.init(item: enterCodeButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 50))
        self.addConstraint(NSLayoutConstraint.init(item: enterCodeButton, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1.25, constant: 50))
        self.addConstraint(NSLayoutConstraint.init(item: flashButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 50))
        self.addConstraint(NSLayoutConstraint.init(item: flashButton, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1.25, constant: 50))
        self.addConstraint(NSLayoutConstraint.init(item: enterCodeField, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 60))
        self.addConstraint(NSLayoutConstraint.init(item: enterCodeField, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
    }
}
