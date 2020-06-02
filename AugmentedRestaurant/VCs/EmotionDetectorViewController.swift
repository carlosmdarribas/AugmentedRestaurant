


//
//  EmotionDetectorViewController.swift
//  AugmentedRestaurant
//
//  Created by Carlos on 02/06/2020.
//  Copyright © 2020 carlosdmarribas. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

class EmotionDetectorViewController: UIViewController {
    @IBOutlet weak var cameraPreview: UIView!
    @IBOutlet weak var emotionImage: UIImageView!
    
    @IBOutlet weak var activityIV: UIActivityIndicatorView!
    
    @IBOutlet weak var goToPlateButton: UIButton!
    
    private lazy var session: AVCaptureSession = {
        let s = AVCaptureSession()
        s.sessionPreset = .hd1280x720
        return s
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.activityIV.startAnimating()
        self.emotionImage.image = (Int.random(in: 0..<3) == 0) ? #imageLiteral(resourceName: "happy") : #imageLiteral(resourceName: "normal")
        self.emotionImage.alpha = 0

         do {
            guard let captureDevice = AVCaptureDevice.default(AVCaptureDevice.DeviceType.builtInWideAngleCamera, for: .video, position: AVCaptureDevice.Position.front) else { return }
                                    
            let deviceInput = try AVCaptureDeviceInput(device: captureDevice)

            if self.session.canAddInput(deviceInput){
                self.session.addInput(deviceInput)
            }

            let videoDataOutput = AVCaptureVideoDataOutput()
            videoDataOutput.alwaysDiscardsLateVideoFrames=true
            let videoDataOutputQueue = DispatchQueue(label: "VideoDataOutputQueue")
            videoDataOutput.setSampleBufferDelegate(self, queue: videoDataOutputQueue)

            if session.canAddOutput(videoDataOutput){ session.addOutput(videoDataOutput) }

            videoDataOutput.connection(with: .video)?.isEnabled = true
            

            let previewLayer = AVCaptureVideoPreviewLayer(session: self.session)
            previewLayer.frame = self.view.bounds
            previewLayer.videoGravity = .resizeAspectFill
            previewLayer.connection?.videoOrientation = .portrait
           self.cameraPreview.layer.insertSublayer(previewLayer, at: 0)
            
            session.startRunning()
         } catch let error as NSError {
            print("error: \(error.localizedDescription)")
        }
        
        Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false) { (_) in
            UIView.animate(withDuration: 1.0) {
                self.emotionImage.alpha = 1
                self.goToPlateButton.alpha = 1
                self.goToPlateButton.isEnabled = true
                self.activityIV.stopAnimating()
            }
        }
    }
    
    @IBAction func goToPlate(_ sender: Any) {
        
    }
}
extension EmotionDetectorViewController: AVCaptureVideoDataOutputSampleBufferDelegate {}


enum emotions {
    case angry, normal, happy, newTry
}
