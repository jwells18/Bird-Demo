//
//  Constants.swift
//  Bird
//
//  Created by Justin Wells on 6/4/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import UIKit
import MapKit

//View Dimensions
let screenBounds = UIScreen.main.bounds
let screenSize   = screenBounds.size
let w = screenSize.width
let h = screenSize.height

//Custom Colors
struct BRColor{
    static let primary = UIColorFromRGB(0x2F2F2F)
    static let secondary = UIColorFromRGB(0x784594)
    static let tertiary = UIColorFromRGB(0xC62446)
    static let quaternary = UIColorFromRGB(0x55DAF4)
    static let faintGray = UIColor(white: 0.95, alpha: 1)
}

public func UIColorFromRGB(_ rgbValue: UInt) -> UIColor {
    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: CGFloat(1.0)
    )
}

//Arrays
let leftMenuTitles = ["payment", "freeRides", "rideHistory", "howToRide", "safety", "help", "settings", "becomeACharger"]
let leftMenuImages = [UIImage(named: "payment"), UIImage(named: "freeRides"), UIImage(named: "rideHistory"), UIImage(named: "howToRide"), UIImage(named: "safety"), UIImage(named: "help"), UIImage(named: "settings"), UIImage(named: "becomeACharger")]
let paymentTitles = ["enterCreditCard", "snapCreditCard", "enterCode"]
let paymentImages = [UIImage(named: "enterCreditCard"), UIImage(named: "snapCreditCard"), UIImage(named: "enterCode")]
let howToRideTitles = ["findAndUnlock", "safeRiding", "startTheBird", "footPlacement", "whereToRide", "brakes", "parking", "endingYourRide", "localRules"]
let howToRideSubTitles = [["findAndUnlockSubTitle"], ["safeRidingSubTitle"], ["startTheBirdSubTitle1", "startTheBirdSubTitle2"], ["footPlacementSubTitle"], ["whereToRideSubTitle"], ["brakesSubTitle"], ["parkingSubTitle1", "parkingSubTitle2"], ["endingYourRideSubTitle"], ["localRulesSubTitle"]]
let howToRideImages = [[UIImage(named: "howToRide1")], [UIImage(named: "howToRide2")], [UIImage(named: "howToRide3"), UIImage(named: "howToRide6")], [UIImage(named: "howToRide4")], [UIImage(named: "howToRide5")], [UIImage(named: "howToRide6")], [UIImage(named: "howToRide7"), UIImage(named: "howToRide71")], [UIImage(named: "howToRide8")]]

//HireMe Label
func createHireMeBackgroundView() -> UIView{
    let hireMeLabel = UILabel(frame: CGRect(x: 0, y: 0, width: w, height: h-64))
    hireMeLabel.text = "Hire me to make more cool stuff \u{1F60E}"
    hireMeLabel.textColor = .lightGray
    hireMeLabel.backgroundColor = .white
    hireMeLabel.textAlignment = .center
    hireMeLabel.font = UIFont.boldSystemFont(ofSize: 30)
    hireMeLabel.numberOfLines = 0
    
    return hireMeLabel
}

//Feature Not Available
public func featureUnavailableAlert() -> UIAlertController{
    //Show Alert that this feature is not available
    let alert = UIAlertController(title: "sorry".localized(), message: "featureUnavailableMessage".localized(), preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "ok".localized(), style: .default, handler: nil))
    return alert
}
