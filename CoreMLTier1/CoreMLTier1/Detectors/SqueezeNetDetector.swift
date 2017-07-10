//
//  SqueezeNetDetector.swift
//  CoreMLTier1
//
//  Created by Pawel Kowalczuk on 10/07/2017.
//  Copyright © 2017 Pawel Kowalczuk. All rights reserved.
//

import Foundation
import CoreMedia

class SqueezeNetDetector: Detector {
    
    private let model = SqueezeNet()
    private let size = 227
    
    func handleDetection(_ buffer: CMSampleBuffer, completion: @escaping ((String,Double) -> Void)) {
        guard let pixelBuffer = CMSampleBufferGetImageBuffer(buffer),
        let prediction = try? model.prediction(image: pixelBuffer.resize(size)) else { return }
        
        var resultString = prediction.classLabel + " "
        var probability = 0.0
        if let prob = prediction.classLabelProbs[prediction.classLabel] {
            resultString += String(describing: prob)
            probability = prob
        }
        
        DispatchQueue.main.async {
            completion(resultString, probability)
        }
    }
}
