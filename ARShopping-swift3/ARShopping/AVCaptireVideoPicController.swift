//
//  AVCaptireVideoPicController.swift
//  ARshop
//
//  Created by Chenggang Xu on 10/26/2016.
//  Copyright © 2016 Chenggang. All rights reserved.
//

import UIKit
import AVFoundation

class AVCaptireVideoPicController: UIViewController,AVCaptureVideoDataOutputSampleBufferDelegate {
    
    var callBack :((_ face: UIImage) ->())?
    let captureSession = AVCaptureSession()
    var captureDevice : AVCaptureDevice?
    var previewLayer : AVCaptureVideoPreviewLayer?
    var pickUIImager : UIImageView = UIImageView(image: UIImage(named: "pick_bg"))
    var line : UIImageView = UIImageView(image: UIImage(named: "line"))
    var timer : Timer!
    var upOrdown = true
    var isStart = false
    var imageView:UIImageView?
    var imageUrl:String?
    var videoDeviceInput: AVCaptureDeviceInput!
    let cameraOutput = AVCaptureStillImageOutput()
    private let sessionQueue = DispatchQueue(label: "session queue", attributes: [], target: nil) // Communicate with the session and other session objects on this queue.
    private let videoDeviceDiscoverySession = AVCaptureDeviceDiscoverySession(deviceTypes: [.builtInWideAngleCamera, .builtInDuoCamera], mediaType: AVMediaTypeVideo, position: .unspecified)!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        captureSession.sessionPreset = AVCaptureSessionPresetHigh
        let devices = AVCaptureDevice.devices()
        for device in devices! {
            if ((device as AnyObject).hasMediaType(AVMediaTypeVideo)) {
                if ((device as AnyObject).position == AVCaptureDevicePosition.front) {
                    captureDevice = device as?AVCaptureDevice
                    if captureDevice != nil {
                        print("Capture Device found")
                        beginSession()
                    }
                }
            }
        }
        
        let textButton = UIButton(frame:CGRect(x: 50, y: 50, width: 50,height: 50))
        
        let imageRetun = "return.png"
        let imageR = UIImage(named: imageRetun)
        textButton.setImage(imageR, for: UIControlState())
        textButton.addTarget(self,action: #selector(cancelCamera(_:)),for:UIControlEvents.touchUpInside)
        
        self.view.addSubview(textButton)
        
        let switchButton = UIButton(frame:CGRect(x: self.view.bounds.width - 100, y: 50, width: 50,height: 50))

        let imageSwitch = "cam_switch.png"
        let imageS = UIImage(named: imageSwitch)
        switchButton.setImage(imageS, for: UIControlState())
        
        switchButton.addTarget(self,action: #selector(switchCamera(_:)),for:UIControlEvents.touchUpInside)
        
        self.view.addSubview(switchButton)
        
        let captureButton = UIButton(frame:CGRect(x: self.view.bounds.width / 2 - 25, y: 50, width: 50,height: 50))
        let imageCapture = "circle-filled.png"
        let imageC = UIImage(named: imageCapture)
        captureButton.setImage(imageC, for: UIControlState())
        
        captureButton.addTarget(self,action: #selector(saveToCamera(_:)),for:UIControlEvents.touchUpInside)
        
        self.view.addSubview(captureButton)
        
        imageView = UIImageView(frame: CGRect(x: 20, y: 180,  width: 90, height: 90))
        imageView?.downloadedFrom(link: imageUrl!)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let image = imageView?.image
        imageView = RotateZoomImageView(image: image)
        self.view.addSubview(imageView!)
    }
    
    func cancelCamera(_ cancelCamera: UIButton!) {
        self.dismiss(animated: true, completion: nil)
        print("cancel")
        
    }
    
    func switchCamera(_ switchCamera: UIButton!) {
        
        print("switch")
        
            //let currentVideoDevice = self.videoDeviceInput.device
            let currentPosition = captureDevice!.position
            
            let preferredPosition: AVCaptureDevicePosition
            let preferredDeviceType: AVCaptureDeviceType
            
            switch currentPosition {
            case .unspecified, .front:
                preferredPosition = .back
                preferredDeviceType = .builtInDuoCamera
                
            case .back:
                preferredPosition = .front
                preferredDeviceType = .builtInWideAngleCamera
            }
            
            let devices = self.videoDeviceDiscoverySession.devices!
            var newVideoDevice: AVCaptureDevice? = nil
            
            // First, look for a device with both the preferred position and device type. Otherwise, look for a device with only the preferred position.
            if let device = devices.filter({ $0.position == preferredPosition && $0.deviceType == preferredDeviceType }).first {
                newVideoDevice = device
            }
            else if let device = devices.filter({ $0.position == preferredPosition }).first {
                newVideoDevice = device
            }
        
        self.captureDevice = newVideoDevice
        //self.captureSession.removeInput(self.videoDeviceInput)
        do {
            if let inputs = captureSession.inputs as? [AVCaptureDeviceInput] {
                for input in inputs {
                    captureSession.removeInput(input)
                }
            }
            if captureSession.inputs.isEmpty {
                try captureSession.addInput(AVCaptureDeviceInput(device: self.captureDevice))
            }
        }catch{
            
        }
        
    }
    
    func isStartTrue(){
        self.isStart = true
    }
    
    func subjectAreaDidChange(notification: NSNotification) {
        let devicePoint = CGPoint(x: 0.5, y: 0.5)
        focus(with: .autoFocus, exposureMode: .continuousAutoExposure, at: devicePoint, monitorSubjectAreaChange: false)
    }
    
    func focus(with focusMode: AVCaptureFocusMode, exposureMode: AVCaptureExposureMode, at devicePoint: CGPoint, monitorSubjectAreaChange: Bool) {
        sessionQueue.async { [unowned self] in
            if let device = self.videoDeviceInput.device {
                do {
                    try device.lockForConfiguration()
                    
                    /*
                     Setting (focus/exposure)PointOfInterest alone does not initiate a (focus/exposure) operation.
                     Call set(Focus/Exposure)Mode() to apply the new point of interest.
                     */
                    if device.isFocusPointOfInterestSupported && device.isFocusModeSupported(focusMode) {
                        device.focusPointOfInterest = devicePoint
                        device.focusMode = focusMode
                    }
                    
                    if device.isExposurePointOfInterestSupported && device.isExposureModeSupported(exposureMode) {
                        device.exposurePointOfInterest = devicePoint
                        device.exposureMode = exposureMode
                    }
                    
                    device.isSubjectAreaChangeMonitoringEnabled = monitorSubjectAreaChange
                    device.unlockForConfiguration()
                }
                catch {
                    print("Could not lock device for configuration: \(error)")
                }
            }
        }
    }
    
    
    override func didReceiveMemoryWarning(){
        super.didReceiveMemoryWarning()
        captureSession.stopRunning()
        
    }
    
    
    
    func beginSession() {
        let err : NSError? = nil
        do {
            if let inputs = captureSession.inputs as? [AVCaptureDeviceInput] {
                for input in inputs {
                    captureSession.removeInput(input)
                }
            }
            if captureSession.inputs.isEmpty {
                try captureSession.addInput(AVCaptureDeviceInput(device: self.captureDevice))
            }
        }catch{
            
        }
        let output = AVCaptureVideoDataOutput()
        
        let cameraQueue = DispatchQueue(label: "cameraQueue", attributes: [])
        output.setSampleBufferDelegate(self, queue: cameraQueue)
        output.videoSettings = [kCVPixelBufferPixelFormatTypeKey as String : Int(kCVPixelFormatType_32BGRA)]
        captureSession.addOutput(output)
        
        
        cameraOutput.outputSettings = [AVVideoCodecKey: AVVideoCodecJPEG]

        if captureSession.canAddOutput(cameraOutput)
        {
            captureSession.addOutput(cameraOutput)
        }
        
        
        if err != nil {
            print("error: \(err?.localizedDescription)")
        }
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer?.videoGravity = "AVLayerVideoGravityResizeAspect"
        previewLayer?.frame = self.view.bounds
        self.view.layer.addSublayer(previewLayer!)
        
        captureSession.startRunning()
    }
    
    
    func saveToCamera(_ saveToCamera: UIButton!) {
        var capturedImage: UIImage!
        
        let videoConnection = cameraOutput.connection(withMediaType: AVMediaTypeVideo)
        
        if videoConnection != nil {
            cameraOutput.captureStillImageAsynchronously(from: cameraOutput.connection(withMediaType: AVMediaTypeVideo))
            { (imageDataSampleBuffer, error) -> Void in
                capturedImage = UIImage(data: AVCaptureStillImageOutput.jpegStillImageNSDataRepresentation(imageDataSampleBuffer))
                self.savePhoto(img: capturedImage)
            }}

//        let videoPreviewLayerOrientation = self.previewLayer?.connection.videoOrientation
//        
//        var inProgressPhotoCaptureDelegates = [Int64 : PhotoCaptureDelegate]()
//        //cameraOutput.outputSettings = [AVVideoCodecKey: AVVideoCodecJPEG]
//        
//        
//        let photoOutputConnection = cameraOutput.connection(withMediaType: AVMediaTypeVideo)
//        photoOutputConnection?.videoOrientation = videoPreviewLayerOrientation!
//
//        let settings = AVCapturePhotoSettings()
//        let previewPixelType = settings.availablePreviewPhotoPixelFormatTypes.first!
//        let previewFormat = [kCVPixelBufferPixelFormatTypeKey as String: previewPixelType,
//                             kCVPixelBufferWidthKey as String: 160,
//                             kCVPixelBufferHeightKey as String: 160,
//                             ]
//        settings.previewPhotoFormat = previewFormat
//        
//        let photoCaptureDelegate = PhotoCaptureDelegate(with: settings, willCapturePhotoAnimation: {
//            DispatchQueue.main.async { [unowned self] in
//                self.previewLayer?.opacity = 0
//                UIView.animate(withDuration: 0.25) { [unowned self] in
//                    self.previewLayer?.opacity = 1
//                }
//            }
//        }, capturingLivePhoto: { _ in
//        }, completed: { [unowned self] photoCaptureDelegate in
//            // When the capture is complete, remove a reference to the photo capture delegate so it can be deallocated.
//            self.sessionQueue.async { [unowned self] in
//            inProgressPhotoCaptureDelegates[photoCaptureDelegate.requestedPhotoSettings.uniqueID] = nil
//            //print(photoCaptureDelegate.photoData)
//            }
//            }
//        )
//        inProgressPhotoCaptureDelegates[photoCaptureDelegate.requestedPhotoSettings.uniqueID] = photoCaptureDelegate
//        cameraOutput.capturePhoto(with: settings, delegate: photoCaptureDelegate)
        
        //print(photoCaptureDelegate.photoData)
        //print(self.imageView?.frame)
    
    }
    
    func savePhoto(img: UIImage){
        var bottomImage = img
        let topImage = self.imageView!.image
        if captureDevice!.position == .front{
            bottomImage = UIImage(cgImage: img.cgImage!, scale: 1.0, orientation: .leftMirrored)
        }
        
        let screenSize: CGRect = UIScreen.main.bounds
        
        let size = CGSize(width: screenSize.width, height: screenSize.height)
        UIGraphicsBeginImageContext(size)
        
        let areaSize = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        bottomImage.draw(in: areaSize)
        
        let topSize = (self.imageView?.frame)!
        
        topImage?.draw(in: topSize, blendMode: .normal, alpha: 1)
        
        let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        UIImageWriteToSavedPhotosAlbum(newImage, self,nil, nil)
    }
    
}
