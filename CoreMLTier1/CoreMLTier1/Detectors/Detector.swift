//
//  Detector.swift
//  CoreMLTier1
//
//  Created by Pawel Kowalczuk on 10/07/2017.
//  Copyright © 2017 Pawel Kowalczuk. All rights reserved.
//

import Foundation
import CoreMedia
import AVFoundation

protocol Detector {
    func handleDetection(_ buffer: CMSampleBuffer, completion: @escaping ((String, Double) -> Void))
}
