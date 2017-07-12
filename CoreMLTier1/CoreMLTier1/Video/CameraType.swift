//
//  CameraType.swift
//  CoreMLTier1
//
//  Created by Pawel Kowalczuk on 10/07/2017.
//  Copyright © 2017 Pawel Kowalczuk. All rights reserved.
//

import AVFoundation

enum CameraType : Int {
    case back
    case front
    
    func captureDevice() -> AVCaptureDevice {
        switch self {
        case .front:
            let devices = AVCaptureDevice.DiscoverySession(deviceTypes: [], mediaType: AVMediaType.video, position: .front).devices
            print("devices:\(devices)")
            for device in devices where device.position == .front {
                return device
            }
        default:
            break
        }
        return AVCaptureDevice.default(for: AVMediaType.video)!
    }
}



