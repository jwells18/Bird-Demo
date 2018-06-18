//
//  BecomeAChargerController.swift
//  Bird
//
//  Created by Justin Wells on 6/4/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import UIKit

class BecomeAChargerController: UIViewController{
    
    private var becomeAChargerView = BecomeAChargerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Setup NavigationBar
        self.setupNavigationBar()
        
        //Setup View
        self.setupView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        becomeAChargerView.firstNameField.becomeFirstResponder()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        //Force Resign All Textfields
        self.view.endEditing(true)
    }
    
    func setupNavigationBar(){
        //Setup Navigation Items
        self.navigationItem.title = "step1of6".localized().uppercased()
        
        let cancelButton = BRBarButtonItem(image: UIImage(named: "cancel"), style: .plain, target: self, action: #selector(self.cancelButtonPressed))
        self.navigationItem.leftBarButtonItem = cancelButton
        
        let nextButton = BRBarButtonItem(title: "next".localized().uppercased(), style: .plain, target: self, action: #selector(self.nextButtonPressed))
        self.navigationItem.rightBarButtonItem?.isEnabled = false
        self.navigationItem.rightBarButtonItem = nextButton
    }
    
    func setupView(){
        self.view.backgroundColor = .white
        
        //Setup Settings View
        becomeAChargerView.frame = self.view.frame
        self.view.addSubview(becomeAChargerView)
        
        //Setup TapToResign Gesture Recognizer
        self.setupTapToResignGestureRecognizer()
    }
    
    //Button Delegates
    func setupTapToResignGestureRecognizer(){
        let tapToResignGestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(self.resignTextFields))
        tapToResignGestureRecognizer.numberOfTapsRequired = 1
        tapToResignGestureRecognizer.numberOfTouchesRequired = 1
        tapToResignGestureRecognizer.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tapToResignGestureRecognizer)
    }
    
    //Gesture Recognizer Delegates
    func resignTextFields(sender: UITapGestureRecognizer){
        if (sender.state == .ended){
            //Resign all textFields
            self.view.endEditing(true)
        }
    }
    
    //MARK: BarButtonItem Delegates
    func cancelButtonPressed(){
        self.dismiss(animated: true, completion: nil)
    }
    
    func nextButtonPressed(){
        //Show Feature Unavailable
        self.present(featureUnavailableAlert(), animated: true, completion: nil)
    }
}
