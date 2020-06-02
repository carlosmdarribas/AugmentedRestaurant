


//
//  EmotionDetectorViewController.swift
//  AugmentedRestaurant
//
//  Created by Carlos on 02/06/2020.
//  Copyright © 2020 carlosdmarribas. All rights reserved.
//

import UIKit
import AVFoundation

class EmotionDetectorViewController: UIViewController {
    @IBOutlet weak var cameraPreview: UIView!

    private lazy var session: AVCaptureSession = {
        let s = AVCaptureSession()
        s.sessionPreset = .hd1280x720
        return s
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.cameraPreview.backgroundColor = .systemPink

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
    }
    
    
}
extension EmotionDetectorViewController: AVCaptureVideoDataOutputSampleBufferDelegate {}


enum emotions {
    case angry, normal, happy
}
