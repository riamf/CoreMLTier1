//
//  CVPixelBuffer+Resize.swift
//  CoreMLTier1
//
//  Created by Pawel Kowalczuk on 10/07/2017.
//  Copyright © 2017 Pawel Kowalczuk. All rights reserved.
//

import Foundation
import CoreImage

extension CVPixelBuffer {
    
    func resize(_ size: Int) -> CVPixelBuffer {
        let imageSide = size
        var ciImage = CIImage(cvPixelBuffer: self, options: nil)
        let transform = CGAffineTransform(scaleX: CGFloat(imageSide) / CGFloat(CVPixelBufferGetWidth(self)), y: CGFloat(imageSide) / CGFloat(CVPixelBufferGetHeight(self)))
        ciImage = ciImage.applying(transform).cropping(to: CGRect(x: 0, y: 0, width: imageSide, height: imageSide))
        let ciContext = CIContext()
        var resizeBuffer: CVPixelBuffer?
        CVPixelBufferCreate(kCFAllocatorDefault, imageSide, imageSide, CVPixelBufferGetPixelFormatType(self), nil, &resizeBuffer)
        ciContext.render(ciImage, to: resizeBuffer!)
        return resizeBuffer!
    }
}
