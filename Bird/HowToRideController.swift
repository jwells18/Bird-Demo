//
//  HowToRideController.swift
//  Bird
//
//  Created by Justin Wells on 6/4/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import UIKit

class HowToRideController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    private var page = Int()
    private var pageControl = UIPageControl()
    private var gradient = CAGradientLayer()
    private var nextButton = UIButton()
    private let defaultCellIdentifier = "defaultCell"
    private let dualPictureCellIdentifier = "dualPictureCell"
    private let localRulesCellIdentifier = "localRulesCell"
    lazy var collectionView: UICollectionView = {
        //Setup CollectionView Flow Layout
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = .zero
        
        //Setup CollectionView
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .clear
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Setup NavigationBar
        self.setupNavigationBar()
        
        //Setup View
        self.setupView()
    }
    
    func setupNavigationBar(){
        //Setup Navigation Items
        self.navigationItem.title = "howToRide".localized().uppercased()
        
        let backButton = BRBarButtonItem(image: UIImage(named: "back"), style: .plain, target: self, action: #selector(self.backButtonPressed))
        self.navigationItem.leftBarButtonItem = backButton
    }
    
    func setupView(){
        //Set Gradient Background
        gradient.colors = [BRColor.tertiary.cgColor, BRColor.secondary.cgColor]
        self.view.layer.insertSublayer(gradient, at: 0)
        
        //Setup CollectionView
        self.setupCollectionView()
        
        //Setup Page Control
        self.setupPageControl()
        
        //Setup Next Button
        self.setupNextButton()
        
        //Setup Constraints
        self.setupConstraints()
    }
    
    func setupCollectionView(){
        collectionView.register(HowToRideDefaultCell.self, forCellWithReuseIdentifier: defaultCellIdentifier)
        collectionView.register(HowToRideDualPictureCell.self, forCellWithReuseIdentifier: dualPictureCellIdentifier)
        collectionView.register(HowToRideLocalRulesCell.self, forCellWithReuseIdentifier: localRulesCellIdentifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(collectionView)
    }
    
    func setupPageControl(){
        pageControl.frame = .zero
        pageControl.currentPageIndicatorTintColor = .white
        pageControl.backgroundColor = UIColor.clear
        pageControl.numberOfPages = howToRideTitles.count
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(pageControl)
    }
    
    func setupNextButton(){
        nextButton = UIButton(frame: .zero)
        nextButton.backgroundColor = .white
        nextButton.setTitle("next".localized().uppercased(), for: .normal)
        nextButton.setTitleColor(.darkGray, for: .normal)
        nextButton.layer.cornerRadius = 5
        nextButton.addTarget(self, action: #selector(self.nextButtonPressed), for: .touchUpInside)
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(nextButton)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        gradient.frame = self.view.bounds
    }
    
    func setupConstraints(){
        let viewDict = ["collectionView": collectionView, "pageControl": pageControl, "nextButton": nextButton] as [String : Any]
        //Width & Horizontal Alignment
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[collectionView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[pageControl]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.view.addConstraint(NSLayoutConstraint.init(item: nextButton, attribute: .width, relatedBy: .equal, toItem: self.view, attribute: .width, multiplier: 0.8, constant: 0))
        self.view.addConstraint(NSLayoutConstraint.init(item: nextButton, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1, constant: 0))
        //Height & Vertical Alignment
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[collectionView]-10-[pageControl]-10-[nextButton(50)]-25-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
    }
    
    //CollectionView DataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return howToRideTitles.count
    }
    
    func collectionView (_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = indexPath.item
        switch item{
        case _ where item < 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: defaultCellIdentifier, for: indexPath) as! HowToRideDefaultCell
            cell.configure(image: howToRideImages[indexPath.item], title: howToRideTitles[indexPath.row], subTitle: howToRideSubTitles[indexPath.row])
            return cell
        case _ where item == 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: dualPictureCellIdentifier, for: indexPath) as! HowToRideDualPictureCell
            cell.configure(image: howToRideImages[indexPath.item], title: howToRideTitles[indexPath.row], subTitle: howToRideSubTitles[indexPath.row])
            return cell
        case _ where item > 2 && item < 6:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: defaultCellIdentifier, for: indexPath) as! HowToRideDefaultCell
            cell.configure(image: howToRideImages[indexPath.item], title: howToRideTitles[indexPath.row], subTitle: howToRideSubTitles[indexPath.row])
            return cell
        case _ where item == 6:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: dualPictureCellIdentifier, for: indexPath) as! HowToRideDualPictureCell
            cell.configure(image: howToRideImages[indexPath.item], title: howToRideTitles[indexPath.row], subTitle: howToRideSubTitles[indexPath.row])
            return cell
        case _ where item == 7:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: defaultCellIdentifier, for: indexPath) as! HowToRideDefaultCell
            cell.configure(image: howToRideImages[indexPath.item], title: howToRideTitles[indexPath.row], subTitle: howToRideSubTitles[indexPath.row])
            return cell
        case _ where item == howToRideTitles.count-1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: localRulesCellIdentifier, for: indexPath) as! HowToRideLocalRulesCell
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: defaultCellIdentifier, for: indexPath) as! HowToRideDefaultCell
            return cell
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //Determine current index for pageControl
        let fractionalPage = scrollView.contentOffset.x / collectionView.frame.width
        page = lround(Double(fractionalPage))
        pageControl.currentPage = page
        
        //Determine Next Button Title
        if(page == howToRideTitles.count-1){
            nextButton.setTitle("readyToGo".localized().uppercased(), for: .normal)
        }
        else{
            nextButton.setTitle("next".localized().uppercased(), for: .normal)
        }
    }
    
    //MARK: BarButtonItem Delegates
    func backButtonPressed(){
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    //Button Delegate
    func nextButtonPressed(){
        //Scroll to next item or pop ViewController
        if(page == howToRideTitles.count-1){
            _ = self.navigationController?.popViewController(animated: true)
        }
        else{
            let nextIndexPath = IndexPath(item: page+1, section: 0)
            self.collectionView.scrollToItem(at: nextIndexPath, at: .centeredHorizontally, animated: true)
        }
    }
}
