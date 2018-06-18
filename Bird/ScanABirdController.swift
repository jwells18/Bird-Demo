//
//  ScanABirdController.swift
//  Bird
//
//  Created by Justin Wells on 6/14/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import UIKit
import AVFoundation

class ScanABirdController: UIViewController, UITextFieldDelegate {
    
    var captureSession = AVCaptureSession()
    var device = AVCaptureDevice()
    var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    var viewFinderLayer: BRViewFinderLayer!
    var scanABirdView: ScanABirdView!
    private var isQRCodeMode = true
    private var isFlashMode = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Setup NavigationBar
        self.setupNavigationBar()
        
        //Setup View
        self.setupView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        //Force Resign All Textfields
        self.view.endEditing(true)
    }
    
    func setupNavigationBar(){
        //Setup Navigation Items
        self.navigationItem.title = "scanABird".localized().uppercased()
        
        let cancelButton = BRBarButtonItem(image: UIImage(named: "cancel"), style: .plain, target: self, action: #selector(self.cancelButtonPressed))
        self.navigationItem.leftBarButtonItem = cancelButton
    }
    
    func setupView(){
        self.view.backgroundColor = .black
        
        //Configure Scanner
        self.configureScanner()
        
        //Setup ViewFinder Layer
        self.setupViewFinderLayer()
        
        //Setup ScanABird View
        self.setupScanABirdView()
        
        //Setup TapToResign GestureRecognizer
        self.setupTapToResignGestureRecognizer()
    }
    
    func configureScanner(){
        // Get the back-facing camera for capturing videos
        let deviceDiscoverySession = AVCaptureDeviceDiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: AVMediaTypeVideo, position: .back)
        let devices = deviceDiscoverySession?.devices
        if devices != nil{
            device = (devices?.first!)!
        }
        
        guard let captureDevice = deviceDiscoverySession?.devices.first else {
            print("Failed to get the camera device")
            return
        }
        
        do {
            // Get an instance of the AVCaptureDeviceInput class using the previous device object.
            let input = try AVCaptureDeviceInput(device: captureDevice)
            
            // Set the input device on the capture session.
            captureSession.addInput(input)
            
            // Initialize a AVCaptureMetadataOutput object and set it as the output device to the capture session.
            let captureMetadataOutput = AVCaptureMetadataOutput()
            captureSession.addOutput(captureMetadataOutput)
            
            // Set delegate and use the default dispatch queue to execute the call back
            captureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            captureMetadataOutput.metadataObjectTypes = [AVMetadataObjectTypeQRCode]
            
        } catch {
            // If any error occurs, simply print it out and don't continue any more.
            print(error)
            return
        }
        
        // Initialize the video preview layer and add it as a sublayer to the viewPreview view's layer.
        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        videoPreviewLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
        videoPreviewLayer?.frame = view.layer.frame
        self.view.layer.addSublayer(videoPreviewLayer!)
        
        // Start video capture.
        captureSession.startRunning()
    }
    
    func setupViewFinderLayer(){
        viewFinderLayer = BRViewFinderLayer()
        viewFinderLayer.frame = self.view.frame
        viewFinderLayer.setupLayer()
        self.view.layer.addSublayer(viewFinderLayer)
    }
    
    func setupScanABirdView(){
        scanABirdView = ScanABirdView(frame: self.view.frame)
        scanABirdView.flashButton.addTarget(self, action: #selector(flashButtonPressed), for: .touchUpInside)
        scanABirdView.enterCodeButton.addTarget(self, action: #selector(enterCodeButtonPressed), for: .touchUpInside)
        scanABirdView.enterCodeField.delegate = self
        self.view.addSubview(scanABirdView)
    }
    
    func setupTapToResignGestureRecognizer(){
        let tapToResignGestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(self.resignTextFields))
            tapToResignGestureRecognizer.numberOfTapsRequired = 1
        tapToResignGestureRecognizer.numberOfTouchesRequired = 1
        tapToResignGestureRecognizer.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tapToResignGestureRecognizer)
    }
    
    //BarButtonItem Delegates
    func cancelButtonPressed(){
        self.dismiss(animated: false, completion: nil)
    }
    
    //Button Delegates
    func flashButtonPressed(sender: UIButton){
        do{
            if (device.hasTorch){
                switch isFlashMode{
                case true:
                    try device.lockForConfiguration()
                    device.torchMode = .off
                    self.scanABirdView.flashButton.setImage(UIImage(named: "flashOff"), for: .normal)
                    isFlashMode = false
                    device.unlockForConfiguration()
                case false:
                    try device.lockForConfiguration()
                    device.torchMode = .on
                    try device.setTorchModeOnWithLevel(0.7)
                    self.scanABirdView.flashButton.setImage(UIImage(named: "flashOn"), for: .normal)
                    isFlashMode = true
                    device.unlockForConfiguration()
                }
            }
        }catch{
            print("Device Flash error");
        }
    }
    
    func enterCodeButtonPressed(sender: UIButton){
        switch isQRCodeMode{
        case true:
            isQRCodeMode = false
            viewFinderLayer.hideViewFinder()
            //Change Scooter Button
            scanABirdView.scooterCodeButton.setTitle("codeButtonTitle".localized().uppercased(), for: .normal)
            scanABirdView.scooterCodeButton.setImage(nil, for: .normal)
            scanABirdView.enterCodeField.isHidden = false
            scanABirdView.enterCodeField.becomeFirstResponder()
        case false:
            isQRCodeMode = true
            viewFinderLayer.showViewFinder()
            //Change Scooter Button
            scanABirdView.scooterCodeButton.setTitle(nil, for: .normal)
            scanABirdView.scooterCodeButton.setImage(UIImage(named: "qrCode"), for: .normal)
            scanABirdView.enterCodeField.isHidden = true
            scanABirdView.enterCodeField.resignFirstResponder()
        }
    }
    
    //Gesture Recognizer Delegates
    func resignTextFields(sender: UITapGestureRecognizer){
        if (sender.state == .ended){
            //Resign Code TextField
            scanABirdView.enterCodeField.resignFirstResponder()
        }
    }
    
    //TextField Delegate
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if(textField == scanABirdView.enterCodeField){
            guard let text = textField.text else { return true }
            let newLength = text.characters.count + string.characters.count - range.length
            return newLength <= 8
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension ScanABirdController: AVCaptureMetadataOutputObjectsDelegate {
    
    func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [Any]!, from connection: AVCaptureConnection!) {
        // Check if the metadataObjects array is not nil and it contains at least one object.
        if metadataObjects.count == 0 {
            let alert = UIAlertController(title: "No QR code is detected", message: nil, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "ok".localized(), style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        // Get the metadata object.
        let metadataObj = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
        
        if metadataObj.type == AVMetadataObjectTypeQRCode{
            if metadataObj.stringValue != nil {
                let alert = UIAlertController(title: "QR code detected: \(metadataObj.stringValue!)", message: nil, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "ok".localized(), style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
}
