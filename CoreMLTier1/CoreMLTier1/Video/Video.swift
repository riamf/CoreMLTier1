//
//  Video.swift
//  CoreMLTier1
//
//  Created by Pawel Kowalczuk on 10/07/2017.
//  Copyright © 2017 Pawel Kowalczuk. All rights reserved.
//

import Foundation
import AVFoundation

class Video: NSObject {
    
    private let captureSession = AVCaptureSession()
    private var videoDevice: AVCaptureDevice!
    private var videoConnection: AVCaptureConnection!
    private var previewLayer: AVCaptureVideoPreviewLayer!
    
    var videoHandler: ((_ imageBuffer: CMSampleBuffer) -> Void)?
    
    init(camera: CameraType, previewLayer: CALayer) {
        
        super.init()
        
        videoDevice = camera.captureDevice()
        captureSession.sessionPreset = AVCaptureSession.Preset.inputPriority
        
        let videoDataOutput = AVCaptureVideoDataOutput()
        videoDataOutput.videoSettings = [kCVPixelBufferPixelFormatTypeKey as AnyHashable as! String: NSNumber(value: kCVPixelFormatType_32BGRA)]
        videoDataOutput.alwaysDiscardsLateVideoFrames = true
        let queue = DispatchQueue(label: "videoQueue")
        videoDataOutput.setSampleBufferDelegate(self, queue: queue)
        
        guard captureSession.canAddOutput(videoDataOutput) else {
            fatalError("Coud't add video output.")
        }
        captureSession.addOutput(videoDataOutput)
        
        guard let videoDeviceInput = try? AVCaptureDeviceInput(device: videoDevice),
            captureSession.canAddInput(videoDeviceInput) else {
                fatalError("Coud't add sesstion input.")
        }
        captureSession.addInput(videoDeviceInput)
        
        guard let vc = videoDataOutput.connection(with: AVMediaType.video) else {
            fatalError("Coud't initialize Video Connection.")
            
        }
        
        videoConnection = vc
        
        let videoLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        videoLayer.frame = previewLayer.bounds
        videoLayer.contentsGravity = kCAGravityResizeAspectFill
        videoLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        previewLayer.insertSublayer(videoLayer, at: 0)
        self.previewLayer = videoLayer
    }
    
    func start() {
        guard !captureSession.isRunning else { return }
        captureSession.startRunning()
    }
    
    func stop() {
        guard captureSession.isRunning else { return }
        captureSession.stopRunning()
    }
    
    func resizePreview() {
        guard let superlayer = previewLayer.superlayer else {return}
        previewLayer.frame = superlayer.bounds
    }
}

extension Video: AVCaptureVideoDataOutputSampleBufferDelegate {
    
    func captureOutput(_ output: AVCaptureOutput,
                       didOutput sampleBuffer: CMSampleBuffer,
                       from connection: AVCaptureConnection) {
        guard let videoHandler = videoHandler else { return }
        
        if connection.videoOrientation != .portrait {
            connection.videoOrientation = .portrait
            return
        }
        videoHandler(sampleBuffer)
    }
}
