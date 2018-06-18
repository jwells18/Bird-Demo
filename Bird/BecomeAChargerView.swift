//
//  BecomeAChargerView.swift
//  Bird
//
//  Created by Justin Wells on 6/14/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import UIKit

class BecomeAChargerView: UIView{
    
    var titleLabel = UILabel()
    var subTitleLabel = UILabel()
    var firstNameField = BRTextField()
    var lastNameField = BRTextField()
    var phoneField = BRTextField()
    var addressField = BRTextField()
    var aptNumberField = BRTextField()
    var cityField = BRTextField()
    var stateField = BRTextField()
    var zipCodeField = BRTextField()
    
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
        
        //Setup Title Label
        self.setupTitleLabel()
        
        //Setup SubTitle Label
        self.setupSubTitleLabel()
        
        //Setup First Name Label
        self.setupFirstNameField()
        
        //Setup Last Name Label
        self.setupLastNameField()
        
        //Setup Phone Field
        self.setupPhoneField()
        
        //Setup Address Field
        self.setupAddressField()
        
        //Setup Apartment Number Field
        self.setupAptNumberField()
        
        //Setup City Field
        self.setupCityField()
        
        //Setup State Field
        self.setupStateField()
        
        //Setup Zip Code Field
        self.setupZipCodeField()
        
        //Setup Constraints
        self.setupConstraints()
    }
    
    func setupTitleLabel(){
        titleLabel.text = "shippingAddressTitle".localized()
        titleLabel.textColor = .darkGray
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(titleLabel)
    }
    
    func setupSubTitleLabel(){
        subTitleLabel.text = "shippingAddressSubTitle".localized()
        subTitleLabel.textColor = .darkGray
        subTitleLabel.textAlignment = .center
        subTitleLabel.font = UIFont.systemFont(ofSize: 16)
        subTitleLabel.numberOfLines = 0
        subTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(subTitleLabel)
    }
    
    func setupFirstNameField(){
        firstNameField.placeholder = "firstName".localized()
        firstNameField.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(firstNameField)
    }
    
    func setupLastNameField(){
        lastNameField.placeholder = "lastName".localized()
        lastNameField.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(lastNameField)
    }
    
    func setupPhoneField(){
        phoneField.keyboardType = .phonePad
        phoneField.placeholder = "phone".localized()
        phoneField.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(phoneField)
    }
    
    func setupAddressField(){
        addressField.placeholder = "address".localized()
        addressField.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(addressField)
    }
    
    func setupAptNumberField(){
        aptNumberField.placeholder = "aptNumber".localized()
        aptNumberField.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(aptNumberField)
    }
    
    func setupCityField(){
        cityField.placeholder = "city".localized()
        cityField.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(cityField)
    }
    
    func setupStateField(){
        stateField.placeholder = "state".localized()
        stateField.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(stateField)
    }
    
    func setupZipCodeField(){
        zipCodeField.placeholder = "zipCode".localized()
        zipCodeField.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(zipCodeField)
    }
    
    func setupConstraints(){
        
        let viewDict = ["titleLabel": titleLabel, "subTitleLabel": subTitleLabel, "firstNameField": firstNameField, "lastNameField": lastNameField, "phoneField": phoneField, "addressField": addressField, "aptNumberField": aptNumberField, "cityField": cityField, "stateField": stateField, "zipCodeField": zipCodeField] as [String : Any]
        //Width & Horizontal Alignment
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-30-[titleLabel]-30-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.addConstraint(NSLayoutConstraint.init(item: titleLabel, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-30-[subTitleLabel]-30-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.addConstraint(NSLayoutConstraint.init(item: subTitleLabel, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-30-[firstNameField][lastNameField]-30-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.addConstraint(NSLayoutConstraint.init(item: lastNameField, attribute: .width, relatedBy: .equal, toItem: self.firstNameField, attribute: .width, multiplier: 0.5, constant: 0))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-30-[phoneField]-30-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-30-[addressField][aptNumberField]-30-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.addConstraint(NSLayoutConstraint.init(item: aptNumberField, attribute: .width, relatedBy: .equal, toItem: self.addressField, attribute: .width, multiplier: 0.25, constant: 0))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-30-[cityField(==stateField)][stateField(==zipCodeField)][zipCodeField(==cityField)]-30-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        //Height & Vertical Alignment
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-30-[titleLabel]-16-[subTitleLabel]-50-[firstNameField(50)][phoneField(50)][addressField(50)][cityField(50)]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.addConstraint(NSLayoutConstraint.init(item: lastNameField, attribute: .height, relatedBy: .equal, toItem: self.firstNameField, attribute: .height, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint.init(item: lastNameField, attribute: .top, relatedBy: .equal, toItem: self.firstNameField, attribute: .top, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint.init(item: aptNumberField, attribute: .height, relatedBy: .equal, toItem: self.addressField, attribute: .height, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint.init(item: aptNumberField, attribute: .top, relatedBy: .equal, toItem: self.addressField, attribute: .top, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint.init(item: stateField, attribute: .height, relatedBy: .equal, toItem: self.cityField, attribute: .height, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint.init(item: stateField, attribute: .top, relatedBy: .equal, toItem: self.cityField, attribute: .top, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint.init(item: zipCodeField, attribute: .height, relatedBy: .equal, toItem: self.cityField, attribute: .height, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint.init(item: zipCodeField, attribute: .top, relatedBy: .equal, toItem: self.cityField, attribute: .top, multiplier: 1, constant: 0))
    }
}
