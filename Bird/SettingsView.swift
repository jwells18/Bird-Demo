//
//  SettingsView.swift
//  Bird
//
//  Created by Justin Wells on 6/14/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import UIKit

class SettingsView: UIView{
    
    var photoButton = UIButton()
    var changePhotoButton = UIButton()
    var nameField = BRTextField()
    var emailField = BRTextField()
    var verifyEmailButton = UIButton()
    var phoneField = BRTextField()
    var logoutButton = UIButton()
    var versionLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //Setup View
        self.setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView(){
        self.clipsToBounds = true
        
        //Setup Photo Button
        self.setupPhotoButton()
        
        //Setup Change Photo Button
        self.setupChangePhotoButton()
        
        //Setup Name Field
        self.setupNameField()
        
        //Setup Email Field
        self.setupEmailField()
        
        //Setup Verify Email Button
        self.setupVerifyEmailButton()
        
        //Setup Phone Field
        self.setupPhoneField()
        
        //Setup Logout Button
        self.setupLogoutButton()
        
        //Setup Version Label
        self.setupVersionLabel()
        
        //Setup Constraints
        self.setupConstraints()
    }
    
    func setupPhotoButton(){
        photoButton.backgroundColor = BRColor.faintGray
        photoButton.setImage(UIImage(named: "picturePlaceholder"), for: .normal)
        photoButton.clipsToBounds = true
        photoButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(photoButton)
    }
    
    func setupChangePhotoButton(){
        changePhotoButton.backgroundColor = BRColor.secondary
        changePhotoButton.clipsToBounds = true
        changePhotoButton.setImage(UIImage(named: "camera"), for: .normal)
        changePhotoButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(changePhotoButton)
    }
    
    func setupNameField(){
        nameField.placeholder = "name".localized()
        nameField.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(nameField)
    }
    
    func setupEmailField(){
        emailField.keyboardType = .emailAddress
        emailField.placeholder = "email".localized()
        emailField.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(emailField)
    }
    
    func setupVerifyEmailButton(){
        verifyEmailButton.setTitle("verifyEmail".localized().uppercased(), for: .normal)
        verifyEmailButton.setTitleColor(.red, for: .normal)
        verifyEmailButton.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        verifyEmailButton.contentEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 20)
        verifyEmailButton.layer.cornerRadius = 5
        verifyEmailButton.layer.borderColor = UIColor.red.cgColor
        verifyEmailButton.layer.borderWidth = 1
        verifyEmailButton.clipsToBounds = true
        verifyEmailButton.translatesAutoresizingMaskIntoConstraints = false
        self.emailField.addSubview(verifyEmailButton)
    }
    
    func setupPhoneField(){
        phoneField.keyboardType = .phonePad
        phoneField.placeholder = "phone".localized()
        phoneField.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(phoneField)
    }
    
    func setupLogoutButton(){
        logoutButton.backgroundColor = BRColor.secondary
        logoutButton.layer.cornerRadius = 5
        logoutButton.setTitle("logout".localized().uppercased(), for: .normal)
        logoutButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(logoutButton)
    }
    
    func setupVersionLabel(){
        let versionNumber = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
        versionLabel.text = String(format:"Version %@", versionNumber)
        versionLabel.textColor = .lightGray
        versionLabel.textAlignment = .center
        versionLabel.font = UIFont.systemFont(ofSize: 12)
        versionLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(versionLabel)
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
        
        let viewDict = ["photoButton": photoButton, "changePhotoButton": changePhotoButton, "nameField":nameField, "emailField": emailField, "phoneField": phoneField, "verifyEmailButton": verifyEmailButton, "logoutButton": logoutButton, "versionLabel": versionLabel, "spacerViewTop": spacerViewTop, "spacerViewBottom": spacerViewBottom] as [String : Any]
        //Width & Horizontal Alignment
        self.addConstraint(NSLayoutConstraint.init(item: photoButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 100))
        self.addConstraint(NSLayoutConstraint.init(item: photoButton, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint.init(item: changePhotoButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 25))
        self.addConstraint(NSLayoutConstraint.init(item: changePhotoButton, attribute: .right, relatedBy: .equal, toItem: self.photoButton, attribute: .right, multiplier: 1, constant: 0))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-30-[nameField]-30-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.addConstraint(NSLayoutConstraint.init(item: nameField, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-30-[emailField]-30-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.addConstraint(NSLayoutConstraint.init(item: emailField, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-30-[phoneField]-30-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.addConstraint(NSLayoutConstraint.init(item: phoneField, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint.init(item: logoutButton, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 0.3, constant: 0))
        self.addConstraint(NSLayoutConstraint.init(item: logoutButton, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-30-[versionLabel]-30-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.addConstraint(NSLayoutConstraint.init(item: versionLabel, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
        self.emailField.addConstraint(NSLayoutConstraint.init(item: verifyEmailButton, attribute: .right, relatedBy: .equal, toItem: self.emailField, attribute: .right, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint.init(item: spacerViewTop, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint.init(item: spacerViewTop, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint.init(item: spacerViewBottom, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint.init(item: spacerViewBottom, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 0))
        //Height & Vertical Alignment
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-50-[photoButton(100)]-50-[nameField(50)]-[emailField(50)]-[phoneField(50)][spacerViewTop(==spacerViewBottom)][logoutButton(40)][spacerViewBottom(==spacerViewTop)][versionLabel(20)]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.addConstraint(NSLayoutConstraint.init(item: changePhotoButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 25))
        self.addConstraint(NSLayoutConstraint.init(item: changePhotoButton, attribute: .top, relatedBy: .equal, toItem: self.photoButton, attribute: .top, multiplier: 1, constant: 0))
        self.emailField.addConstraint(NSLayoutConstraint.init(item: verifyEmailButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 40))
        self.emailField.addConstraint(NSLayoutConstraint.init(item: verifyEmailButton, attribute: .centerY, relatedBy: .equal, toItem: self.emailField, attribute: .centerY, multiplier: 1, constant: 0))
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        photoButton.layer.cornerRadius = photoButton.frame.width/2
        changePhotoButton.layer.cornerRadius = changePhotoButton.frame.width/2
    }
}

