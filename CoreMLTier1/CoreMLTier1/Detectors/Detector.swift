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
    var name: String { get }
    func handleDetection(_ buffer: CMSampleBuffer, completion: @escaping ((String, Double) -> Void))
}

class AbstractDetector<M: ModelType>: Detector {
    var model: M
    var name: String {
        return model.name
    }
    
    init(_ model: M) {
        self.model = model
    }
    
    func handleDetection(_ buffer: CMSampleBuffer, completion: @escaping ((String, Double) -> Void)) {
        guard let pixelBuffer = CMSampleBufferGetImageBuffer(buffer),
            let prediction = try? model.prediction(image: pixelBuffer.resize(model.size)) else { return }
        
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

enum DetectorType: String {
    case squeezeNet
    case inceptionV3
    case vgg16
    case resnet50
    case googleNetPlaces
    
    var detector: Detector {
        switch self {
        case .squeezeNet:
            return AbstractDetector(SqueezeNet())
        case .inceptionV3:
            return AbstractDetector(Inceptionv3())
        case .vgg16:
            return AbstractDetector(VGG16())
        case .resnet50:
            return AbstractDetector(Resnet50())
        case .googleNetPlaces:
            return AbstractDetector(GoogLeNetPlaces())
        }
    }
    
    static var allValues: [DetectorType] {
        return [DetectorType.squeezeNet,
                DetectorType.inceptionV3,
                DetectorType.vgg16,
                DetectorType.resnet50,
                DetectorType.googleNetPlaces]
    }
    
    var description: String {
        switch self {
        case .squeezeNet:
            return String(describing: SqueezeNet().model.modelDescription)
        case .inceptionV3:
            return String(describing: Inceptionv3().model.modelDescription)
        case .vgg16:
            return String(describing: VGG16().model.modelDescription)
        case .resnet50:
            return String(describing: Resnet50().model.modelDescription)
        case .googleNetPlaces:
            return String(describing: GoogLeNetPlaces().model.modelDescription)
        }
    }
}
