//
//  RideHistoryController.swift
//  Bird
//
//  Created by Justin Wells on 6/4/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import UIKit

class RideHistoryController: UIViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Setup NavigationBar
        self.setupNavigationBar()
        
        //Setup View
        self.setupView()
    }
    
    func setupNavigationBar(){
        //Setup Navigation Items
        self.navigationItem.title = "rideHistory".localized().uppercased()
        
        let backButton = BRBarButtonItem(image: UIImage(named: "back"), style: .plain, target: self, action: #selector(self.backButtonPressed))
        self.navigationItem.leftBarButtonItem = backButton
    }
    
    func setupView(){
        self.view.backgroundColor = .white
        
        //Set Hire Me Label
        self.view = createHireMeBackgroundView()
    }
    
    //MARK: BarButtonItem Delegates
    func backButtonPressed(){
        _ = self.navigationController?.popViewController(animated: true)
    }
}
