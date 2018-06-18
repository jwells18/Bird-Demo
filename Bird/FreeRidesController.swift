//
//  FreeRidesController.swift
//  Bird
//
//  Created by Justin Wells on 6/4/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import UIKit

class FreeRidesController: UIViewController{
    
    private var headerView = FreeRideHeaderView()
    private var footerView = FreeRideFooterView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Setup NavigationBar
        self.setupNavigationBar()
        
        //Setup View
        self.setupView()
    }
    
    func setupNavigationBar(){
        //Setup Navigation Items
        self.navigationItem.title = "freeRides".localized().uppercased()
        
        let backButton = BRBarButtonItem(image: UIImage(named: "back"), style: .plain, target: self, action: #selector(self.backButtonPressed))
        self.navigationItem.leftBarButtonItem = backButton
        
        let shareButton = BRBarButtonItem(image: UIImage(named: "share"), style: .plain, target: self, action: #selector(self.shareButtonPressed))
        self.navigationItem.rightBarButtonItem = shareButton
    }
    
    func setupView(){
        self.view.backgroundColor = .white
        
        //Setup HeaderView
        self.setupHeaderView()
        
        //Setup FooterView
        self.setupFooterView()
        
        //Setup Constraints
        self.setupConstraints()
    }
    
    func setupHeaderView(){
        headerView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(headerView)
    }
    
    func setupFooterView(){
        footerView.translatesAutoresizingMaskIntoConstraints = false
        footerView.sendRidesButton.addTarget(self, action: #selector(sendRidesButton), for: .touchUpInside)
        self.view.addSubview(footerView)
    }
    
    func setupConstraints(){
        //Width & Horizontal Alignment
        self.view.addConstraints([NSLayoutConstraint.init(item: headerView, attribute: .width, relatedBy: .equal, toItem: self.view, attribute: .width, multiplier: 1, constant: 0)])
        self.view.addConstraints([NSLayoutConstraint.init(item: footerView, attribute: .width, relatedBy: .equal, toItem: self.view, attribute: .width, multiplier: 1, constant: 0)])
        //Height & Vertical Alignment
        self.view.addConstraints([NSLayoutConstraint.init(item: headerView, attribute: .height, relatedBy: .equal, toItem: self.view, attribute: .height, multiplier: 0.55, constant: 0)])
        self.view.addConstraints([NSLayoutConstraint.init(item: footerView, attribute: .height, relatedBy: .equal, toItem: self.view, attribute: .height, multiplier: 0.45, constant: 0)])
        self.view.addConstraints([NSLayoutConstraint.init(item: headerView, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1, constant: 0)])
        self.view.addConstraints([NSLayoutConstraint.init(item: footerView, attribute: .top, relatedBy: .equal, toItem: headerView, attribute: .bottom, multiplier: 1, constant: 0)])
    }
    
    //MARK: BarButtonItem Delegates
    func backButtonPressed(){
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    func shareButtonPressed(sender: UIButton){
        self.showActivityVC(sender: sender)
    }
    
    func sendRidesButton(sender: UIButton){
        self.showActivityVC(sender: sender)
    }
    
    func showActivityVC(sender: UIButton){
        let firstActivityItem = "sendFreeRideMessage".localized()
        let activityViewController : UIActivityViewController = UIActivityViewController(
            activityItems: [firstActivityItem], applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = sender
        activityViewController.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection.any
        activityViewController.popoverPresentationController?.sourceRect = CGRect(x: 0, y: 0, width: 1, height: 1)
        self.present(activityViewController, animated: true, completion: nil)
    }
}
