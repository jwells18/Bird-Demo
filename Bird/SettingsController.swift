//
//  SettingsController.swift
//  Bird
//
//  Created by Justin Wells on 6/4/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import UIKit

class SettingsController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, BRImagePickerControllerDelegate {
    
    private var imagePicker: BRImagePickerController!
    private var settingsView: SettingsView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Setup NavigationBar
        self.setupNavigationBar()
        
        //Setup View
        self.setupView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        //Force Resign All TextFields
        self.view.endEditing(true)
    }
    
    func setupNavigationBar(){
        //Setup Navigation Items
        self.navigationItem.title = "settings".localized().uppercased()
        
        let backButton = BRBarButtonItem(image: UIImage(named: "back"), style: .plain, target: self, action: #selector(self.backButtonPressed))
        self.navigationItem.leftBarButtonItem = backButton
        
        let saveButton = BRBarButtonItem(title: "save".localized().uppercased(), style: .plain, target: self, action: #selector(self.saveButtonPressed))
        self.navigationItem.rightBarButtonItem = saveButton
    }
    
    func setupView(){
        self.view.backgroundColor = .white
        
        //Setup Settings View
        settingsView = SettingsView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height-64))
        settingsView.photoButton.addTarget(self, action: #selector(changePhotoButtonPressed), for: .touchUpInside)
        settingsView.changePhotoButton.addTarget(self, action: #selector(changePhotoButtonPressed), for: .touchUpInside)
        settingsView.verifyEmailButton.addTarget(self, action: #selector(verifyEmailButtonPressed), for: .touchUpInside)
        settingsView.logoutButton.addTarget(self, action: #selector(logoutButtonPressed), for: .touchUpInside)
        self.view.addSubview(settingsView)
        
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
    
    func changePhotoButtonPressed(){
        //Present BRImagePickerController
        imagePicker = BRImagePickerController()
        imagePicker.imagePickerControllerDelegate = self
        let navVC = NavigationController(rootViewController: imagePicker)
        self.present(navVC, animated: true, completion: nil)
        
        //Present an ImagePickerController
        /*
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate =  self
        imagePicker.navigationBar.isTranslucent = false
        imagePicker.navigationBar.barTintColor = BRColor.primary
        imagePicker.navigationBar.tintColor = .white
        imagePicker.navigationBar.backgroundColor = .white
        self.present(imagePicker, animated: true, completion: nil)*/
    }
    
    //Button Delegates
    func didChoosePhoto(picker: BRImagePickerController, image: UIImage) {
        picker.dismiss(animated: true, completion: nil)
        settingsView.photoButton.setImage(image, for: .normal)
    }
    
    func verifyEmailButtonPressed(){
        //Show Feature Unavailable
        self.present(featureUnavailableAlert(), animated: true, completion: nil)
    }
    
    func logoutButtonPressed(){
        //Show Feature Unavailable
        self.present(featureUnavailableAlert(), animated: true, completion: nil)
    }
    
    //MARK: BarButtonItem Delegates
    func backButtonPressed(){
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    func saveButtonPressed(){
        _ = self.navigationController?.popViewController(animated: true)
    }
}
