//
//  AddCardController.swift
//  Bird
//
//  Created by Justin Wells on 6/6/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import UIKit

class AddCardController: UIViewController, UITextFieldDelegate{
    
    private var imageView = UIImageView()
    private var addCardInputView = AddCardInputView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Setup NavigationBar
        self.setupNavigationBar()
        
        //Setup View
        self.setupView()
    }
    
    func setupNavigationBar(){
        //Setup Navigation Items
        self.navigationItem.title = "addCard".localized().uppercased()
        
        let backButton = BRBarButtonItem(image: UIImage(named: "back"), style: .plain, target: self, action: #selector(self.backButtonPressed))
        self.navigationItem.leftBarButtonItem = backButton
        
        let doneButton = BRBarButtonItem(title: "done".localized().uppercased(), style: .plain, target: self, action: #selector(self.doneButtonPressed))
        self.navigationItem.rightBarButtonItem?.isEnabled = false
        self.navigationItem.rightBarButtonItem = doneButton
    }
    
    func setupView(){
        self.view.backgroundColor = .white
        
        //Setup ImageView
        self.setupImageView()
        
        //Setup Add Card InputView
        self.setupAddCardInputView()
        
        //Setup Constraints
        self.setupConstraints()
    }
    
    func setupImageView(){
        self.imageView.image = UIImage(named: "creditCardPurple")
        self.imageView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.imageView)
    }
    
    func setupAddCardInputView(){
        self.addCardInputView.textField.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: .editingChanged)
        self.addCardInputView.textField.delegate = self
        self.addCardInputView.textField.becomeFirstResponder()
        self.addCardInputView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.addCardInputView)
    }
    
    func setupConstraints(){
        let viewDict = ["imageView": imageView, "addCardInputView": addCardInputView] as [String : Any]
        //Width & Horizontal Alignment
        self.view.addConstraints([NSLayoutConstraint.init(item: imageView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 100)])
        self.view.addConstraints([NSLayoutConstraint.init(item: imageView, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1, constant: 0)])
        self.view.addConstraints([NSLayoutConstraint.init(item: addCardInputView, attribute: .width, relatedBy: .equal, toItem: self.view, attribute: .width, multiplier: 0.8, constant: 0)])
        self.view.addConstraints([NSLayoutConstraint.init(item: addCardInputView, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1, constant: 0)])
        //Height & Vertical Alignment
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-30-[imageView(100)]-50-[addCardInputView(50)]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
    }
    
    //TextField Delegate
    func textFieldDidChange(textField: UITextField) {
        if(textField == addCardInputView.textField){
            switch CardState(fromPrefix: textField.text!) {
            case .identified(let card):
                addCardInputView.textField.textColor = .darkGray
                switch card{
                case .visa:
                    addCardInputView.imageView.image = UIImage(named: "visaCreditCard")
                case .masterCard:
                    addCardInputView.imageView.image = UIImage(named: "masterCardCreditCard")
                case .amex:
                    addCardInputView.imageView.image = UIImage(named: "amexCreditCard")
                case .discover:
                    addCardInputView.imageView.image = UIImage(named: "discoverCreditCard")
                default:
                    addCardInputView.imageView.image = UIImage(named: "creditCardPlaceholder")
                }
            case .indeterminate:
                addCardInputView.imageView.image = UIImage(named: "creditCardPlaceholder")
                addCardInputView.textField.textColor = .darkGray
            case .invalid:
                addCardInputView.imageView.image = UIImage(named: "invalidCreditCard")
                addCardInputView.textField.textColor = .red
            }
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if(textField == addCardInputView.textField){
            guard let text = textField.text else { return true }
            let newLength = text.characters.count + string.characters.count - range.length
            return newLength <= 19 //19 characters is the max length for a credit card number
        }
        return true
    }
    
    //MARK: BarButtonItem Delegates
    func backButtonPressed(){
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    func doneButtonPressed(){
        _ = self.navigationController?.popViewController(animated: true)
    }
}
