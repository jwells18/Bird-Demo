//
//  LeftMenuController.swift
//  Bird
//
//  Created by Justin Wells on 6/4/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import UIKit

protocol LeftMenuDelegate {
    func didPressLeftMenuCell(indexPath: IndexPath)
    func didPressGiveARideButton(sender: UIButton)
}

class LeftMenuController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    var leftMenuDelegate: LeftMenuDelegate!
    private var leftMenuHeader: LeftMenuHeader!
    private let cellIdentifier = "cell"
    private var tableView: UITableView!
    private var giveARideButton = GiveARideButton()
    private var gradient = CAGradientLayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Setup View
        self.setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //Hide Navigation Bar
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func setupView(){
        //Set Gradient Background
        gradient.colors = [BRColor.tertiary.cgColor, BRColor.secondary.cgColor]
        self.view.layer.insertSublayer(gradient, at: 0)
        
        //Setup Left Menu Header
        self.setupLeftMenuHeader()
        
        //Setup TableView
        self.setupTableView()
        
        //Setup Give A Ride Button
        self.setupGiveARideButton()
        
        //Setup Constraints
        self.setupConstraints()
    }
    
    func setupLeftMenuHeader(){
        leftMenuHeader = LeftMenuHeader(frame: .zero)
        leftMenuHeader.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(leftMenuHeader)
    }
    
    func setupTableView(){
        tableView = UITableView(frame: .zero, style: .plain)
        tableView.backgroundColor = .clear
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = false
        tableView.showsVerticalScrollIndicator = false
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.register(LeftMenuCell.self, forCellReuseIdentifier: cellIdentifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(tableView)
    }
    
    func setupGiveARideButton(){
        giveARideButton.frame = .zero
        giveARideButton.addTarget(self, action: #selector(self.giveARideButtonPressed), for: .touchUpInside)
        giveARideButton.translatesAutoresizingMaskIntoConstraints = false
        giveARideButton.alpha = 0
        self.view.addSubview(giveARideButton)
        UIView.animate(withDuration: 1, delay: 1, options: UIViewAnimationOptions.init(rawValue: 0), animations: {
            self.giveARideButton.alpha = 1
        }, completion: nil)
    }
    
    func setupConstraints(){
        let viewDict = ["leftMenuHeader": leftMenuHeader, "tableView": tableView, "giveARideButton": giveARideButton] as [String : Any]
        //Width & Horizontal Alignment
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[leftMenuHeader]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[tableView]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.view.addConstraints([NSLayoutConstraint.init(item: giveARideButton, attribute: .width, relatedBy: .equal, toItem: self.view, attribute: .width, multiplier: 1, constant: -32)])
        self.view.addConstraints([NSLayoutConstraint.init(item: giveARideButton, attribute: .left, relatedBy: .equal, toItem: self.view, attribute: .left, multiplier: 1, constant: 16)])
        //Height & Vertical Alignment
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-64-[leftMenuHeader(55)]-10-[tableView]-127-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.view.addConstraints([NSLayoutConstraint.init(item: giveARideButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 95)])
        self.view.addConstraints([NSLayoutConstraint.init(item: giveARideButton, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1, constant: -16)])
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        gradient.frame = self.view.bounds
    }
    
    //UITableView DataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return leftMenuTitles.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! LeftMenuCell
        cell.configure(image: leftMenuImages[indexPath.row], title:leftMenuTitles[indexPath.row].localized().uppercased())
        return cell
    }
    
    //TableView Delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.dismiss(animated: true, completion: nil)
        leftMenuDelegate.didPressLeftMenuCell(indexPath: indexPath)
    }
    
    func giveARideButtonPressed(sender: UIButton){
        self.dismiss(animated: true, completion: nil)
        leftMenuDelegate.didPressGiveARideButton(sender: sender)
    }
}
