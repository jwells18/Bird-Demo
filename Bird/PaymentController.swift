//
//  PaymentController.swift
//  Bird
//
//  Created by Justin Wells on 6/4/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import UIKit

class PaymentController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    private var paymentHeader: PaymentHeader!
    private let cellIdentifier = "cell"
    private var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Setup NavigationBar
        self.setupNavigationBar()
        
        //Setup View
        self.setupView()
    }
    
    func setupNavigationBar(){
        //Setup Navigation Items
        self.navigationItem.title = "payment".localized().uppercased()
        
        let backButton = BRBarButtonItem(image: UIImage(named: "back"), style: .plain, target: self, action: #selector(self.backButtonPressed))
        self.navigationItem.leftBarButtonItem = backButton
        
        let doneButton = BRBarButtonItem(title: "done".localized().uppercased(), style: .plain, target: self, action: #selector(self.doneButtonPressed))
        self.navigationItem.rightBarButtonItem = doneButton
    }
    
    func setupView(){
        self.view.backgroundColor = .white
        
        //Setup Payment header
        self.setupPaymentHeader()
        
        //Setup TableView
        self.setupTableView()
        
        //Setup Constraints
        self.setupConstraints()
    }
    
    func setupPaymentHeader(){
        paymentHeader = PaymentHeader(frame: .zero)
        paymentHeader.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(paymentHeader)
    }
    
    func setupTableView(){
        tableView = UITableView(frame: .zero, style: .plain)
        tableView.backgroundColor = .clear
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorInset = .zero
        tableView.separatorColor = .lightGray
        tableView.isScrollEnabled = false
        tableView.showsVerticalScrollIndicator = false
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.register(PaymentCell.self, forCellReuseIdentifier: cellIdentifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(tableView)
    }
    
    func setupConstraints(){
        let viewDict = ["paymentHeader": paymentHeader, "tableView": tableView] as [String : Any]
        //Width & Horizontal Alignment
        self.view.addConstraints([NSLayoutConstraint.init(item: paymentHeader, attribute: .width, relatedBy: .equal, toItem: self.view, attribute: .width, multiplier: 1, constant: 0)])
        self.view.addConstraints([NSLayoutConstraint.init(item: paymentHeader, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1, constant: 0)])
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[tableView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        //Height & Vertical Alignment
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-16-[paymentHeader]-50-[tableView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
    }
    
    //UITableView DataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return paymentTitles.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 45
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let paymentSectionHeader = PaymentSectionHeader(frame: .zero)
        paymentSectionHeader.configure(title: "addPaymentMethod")
        return paymentSectionHeader
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! PaymentCell
        cell.configure(image: paymentImages[indexPath.row], title:paymentTitles[indexPath.row].localized().uppercased())
        return cell
    }
    
    //TableView Delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.dismiss(animated: true, completion: nil)
        switch indexPath.row {
        case 0:
            let addCardVC = AddCardController()
            self.navigationController?.pushViewController(addCardVC, animated: true)
            break
        case 1:
            //Show Feature Unavailable
            self.present(featureUnavailableAlert(), animated: true, completion: nil)
            break
        case 2:
            //Show Reset Alert Controller
            let alert = UIAlertController(title: "enterPromoCode".localized(), message: nil, preferredStyle: .alert)
            var promoCodeTextField: UITextField!
            alert.addTextField { (textField : UITextField!) -> Void in
                promoCodeTextField = textField
                textField.placeholder = "promoCode".localized()
            }
            let sendAction = UIAlertAction(title: "enter".localized(), style: .default, handler: { alert -> Void in
                let promoString = promoCodeTextField.text
                print("code: \(promoString)")
            })
            alert.addAction(sendAction)
            alert.addAction(UIAlertAction(title: "cancel".localized(), style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            break
        default:
            break
        }
    }
    
    //MARK: BarButtonItem Delegates
    func backButtonPressed(){
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    func doneButtonPressed(){
        _ = self.navigationController?.popViewController(animated: true)
    }
}
