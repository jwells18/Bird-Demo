//
//  NearbyBirdsController.swift
//  Bird
//
//  Created by Justin Wells on 6/4/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import UIKit
import MapKit
import SideMenu

class NearbyBirdsController: UIViewController, MKMapViewDelegate, LeftMenuDelegate, CLLocationManagerDelegate{
    
    private var mapView: MKMapView!
    private var mapReCenterButton = UIButton()
    private var locationManager:CLLocationManager!
    private var currentUserLocation: CLLocation!
    private var howToRideButton = UIButton()
    private let annotationIdentifier = "annotationIdentifier"
    private var rideButton = RideButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Setup NavigationBar
        self.setupNavigationBar()
        
        //Setup Side Menu
        self.setupSideMenu()
        
        //Setup View
        self.setupView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //Determine User Current Location
        determineCurrentLocation()
    }
    
    func setupNavigationBar(){
        //Setup Navigation Items
        self.navigationItem.title = "nearbyBirds".localized().uppercased()
        
        let menuButton = BRBarButtonItem(image: UIImage(named: "menu"), style: .plain, target: self, action: #selector(self.menuButtonPressed))
        self.navigationItem.leftBarButtonItem = menuButton
        
        let qrCodeButton = BRBarButtonItem(image: UIImage(named: "qrCode"), style: .plain, target: self, action: #selector(self.qrCodeButtonPressed))
        self.navigationItem.rightBarButtonItem = qrCodeButton
    }
    
    func setupSideMenu(){
        let leftMenuVC = LeftMenuController()
        leftMenuVC.leftMenuDelegate = self
        let sideMenuVC = UISideMenuNavigationController(rootViewController: leftMenuVC)
        SideMenuManager.menuLeftNavigationController = sideMenuVC
        SideMenuManager.menuShadowOpacity = 0
        SideMenuManager.menuFadeStatusBar = false
    }
    
    func setupView(){
        self.view.backgroundColor = .white
        
        //Setup Ride Button
        self.setupHowToRideButton()
        
        //Setup MapView
        self.setupMapView()
        
        //Setup Ride Button
        self.setupRideButton()
        
        //Setup Constraints
        self.setupConstraints()
    }
    
    func setupHowToRideButton(){
        howToRideButton.backgroundColor = BRColor.secondary
        howToRideButton.setTitle("howToRide".localized().uppercased(), for: .normal)
        howToRideButton.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: UIFontWeightThin)
        howToRideButton.addTarget(self, action: #selector(self.howToRideButtonPressed), for: .touchUpInside)
        howToRideButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(howToRideButton)
    }
    
    func setupMapView(){
        //Setup MapView
        mapView = MKMapView(frame: CGRect.zero)
        mapView.delegate = self
        mapView.showsUserLocation = true
        mapView.tintColor = BRColor.secondary
        mapView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(mapView)
        
        //Setup Map ReCenter Button
        mapReCenterButton.setImage(UIImage(named: "target"), for: .normal)
        mapReCenterButton.addTarget(self, action: #selector(self.mapReCenterButtonPressed), for: .touchUpInside)
        mapReCenterButton.backgroundColor = UIColor.white.withAlphaComponent(0.8)
        mapReCenterButton.translatesAutoresizingMaskIntoConstraints = false
        mapReCenterButton.isHidden = true
        mapView.addSubview(mapReCenterButton)
    }
    
    func determineCurrentLocation(){
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
        }
    }
    
    func setupRideButton(){
        rideButton.addTarget(self, action: #selector(rideButtonPressed), for: .touchUpInside)
        rideButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(rideButton)
    }
    
    func setupConstraints(){
        let viewDict = ["howToRideButton": howToRideButton, "mapView": mapView, "mapReCenterButton": mapReCenterButton, "rideButton": rideButton] as [String : Any]
        //Width & Horizontal Alignment
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[howToRideButton]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[mapView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.mapView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-20-[mapReCenterButton(30)]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.view.addConstraint(NSLayoutConstraint.init(item: rideButton, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1, constant: 0))
        self.view.addConstraint(NSLayoutConstraint.init(item: rideButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 90))
        //Height & Vertical Alignment
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[howToRideButton(45)][mapView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.mapView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[mapReCenterButton(30)]-20-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.view.addConstraint(NSLayoutConstraint.init(item: rideButton, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1, constant: -10))
        self.view.addConstraint(NSLayoutConstraint.init(item: rideButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 90))
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        mapReCenterButton.layer.cornerRadius = mapReCenterButton.frame.width/2
    }
    
    //Location Manager Delegate
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation:CLLocation = locations[0] as CLLocation
        
        if currentUserLocation == nil{
            self.centerMap(location: userLocation)
        }
        //Set Current User Location
        currentUserLocation = userLocation
    }
    
    //MapView Delegate
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        if currentUserLocation != nil{
            if(MKMapRectContainsPoint(mapView.visibleMapRect, MKMapPointForCoordinate(currentUserLocation.coordinate))){
                mapReCenterButton.isHidden = true
            }
            else{
                mapReCenterButton.isHidden = false
            }
        }
    }
    
    func centerMap(location: CLLocation){
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        mapView.setRegion(region, animated: true)
    }
    
    //Button Delegates
    func menuButtonPressed(){
        self.present(SideMenuManager.menuLeftNavigationController!, animated: true, completion: nil)
    }
    
    func qrCodeButtonPressed(){
        let scanABirdVC = ScanABirdController()
        let navVC = NavigationController(rootViewController: scanABirdVC)
        self.present(navVC, animated: false, completion: nil)
    }
    
    func rideButtonPressed(){
        let scanABirdVC = ScanABirdController()
        let navVC = NavigationController(rootViewController: scanABirdVC)
        self.present(navVC, animated: false, completion: nil)
    }
    
    func howToRideButtonPressed(){
        let howToRideVC = HowToRideController()
        self.navigationController?.pushViewController(howToRideVC, animated: true)
    }
    
    func mapReCenterButtonPressed(){
        self.centerMap(location: currentUserLocation)
        mapReCenterButton.isHidden = true
    }
    
    //Left Menu Delegate
    func didPressLeftMenuCell(indexPath: IndexPath){
        switch indexPath.row {
        case 0:
            let paymentVC = PaymentController()
            self.navigationController?.pushViewController(paymentVC, animated: true)
        case 1:
            let freeRidesVC = FreeRidesController()
            self.navigationController?.pushViewController(freeRidesVC, animated: true)
        case 2:
            let rideHistoryVC = RideHistoryController()
            self.navigationController?.pushViewController(rideHistoryVC, animated: true)
        case 3:
            let howToRideVC = HowToRideController()
            self.navigationController?.pushViewController(howToRideVC, animated: true)
        case 4:
            let url = URL(string: "safetyURL".localized())!
            let safetyVC = BRWebController(url: url)
            self.navigationController?.pushViewController(safetyVC, animated: true)
        case 5:
            let helpVC = HelpController()
            self.navigationController?.pushViewController(helpVC, animated: true)
        case 6:
            let settingsVC = SettingsController()
            self.navigationController?.pushViewController(settingsVC, animated: true)
        case 7:
            let becomeAChargerVC = BecomeAChargerController()
            let navVC = NavigationController(rootViewController: becomeAChargerVC)
            self.present(navVC, animated: true, completion: nil)
        default:
            break
        }
    }
    
    func didPressGiveARideButton(sender: UIButton){
        let freeRidesVC = FreeRidesController()
        self.navigationController?.pushViewController(freeRidesVC, animated: true)
    }
}
