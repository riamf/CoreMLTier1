//
//  ModelType.swift
//  CoreMLTier1
//
//  Created by Pawel Kowalczuk on 11/07/2017.
//  Copyright © 2017 Pawel Kowalczuk. All rights reserved.
//

import Foundation
import CoreML

protocol PredictionType {
    var classLabel: String { get }
    var classLabelProbs: [String : Double] { get }
}

protocol ModelType {
    associatedtype T: PredictionType
    var model: MLModel { get set }
    var size: Int { get }
    func prediction(image: CVPixelBuffer) throws -> T
    var name: String { get }
}

extension ModelType {
    var name: String {
        return String(describing: self)
    }
}

extension SqueezeNetOutput: PredictionType {}
extension SqueezeNet: ModelType {
    var size: Int {
        return 227
    }
}

extension Inceptionv3Output: PredictionType {}
extension Inceptionv3: ModelType {
    var size: Int {
        return 299
    }
}

extension VGG16Output: PredictionType {}
extension VGG16: ModelType {
    var size: Int {
        return 224
    }
}

extension Resnet50Output: PredictionType {}
extension Resnet50: ModelType {
    var size: Int {
        return 224
    }
}

extension GoogLeNetPlacesOutput: PredictionType {
    var classLabel: String {
        return sceneLabel
    }
    
    var classLabelProbs: [String : Double] {
        return sceneLabelProbs
    }
}

extension GoogLeNetPlaces: ModelType {
    
    var size: Int {
        return 224
    }
    
    func prediction(image: CVPixelBuffer) throws -> GoogLeNetPlacesOutput {
        return try self.prediction(sceneImage: image)
    }
}
