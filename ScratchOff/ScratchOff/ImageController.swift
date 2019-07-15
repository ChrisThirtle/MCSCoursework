//
//  ImageController.swift
//  ScratchOff
//
//  Created by Consultant on 7/14/19.
//  Copyright © 2019 Consultant. All rights reserved.
//

import UIKit
import CoreImage

class ImageController {
  static let shared = ImageController()
  private init() { }
  
  let context = CIContext(options: nil)
  
  lazy var baseScratchImage: CIImage? = {
    guard let baseScratchImageUrl = Bundle.main.url(forResource: "GreySquare", withExtension: ".png") else {
      return nil
    }
    return CIImage(contentsOf: baseScratchImageUrl)
  }()
  
  func scratchImage(image: UIImage, point: CGPoint, velocity: Float = 3.0) -> UIImage {
    let point = CIVector(cgPoint: point)
    let scratchFilter = getScratchFilter(at: point, radius: velocity)
    if let compositer = CIFilter(name: "CIMultiplyCompositing"),
      let scratchFilterImage = scratchFilter.outputImage {
      compositer.setValue(image.ciImage, forKey: "inputImage")
      compositer.setValue(scratchFilterImage, forKey: "inputBackgroundImage")
      
      if let outputImage = compositer.outputImage {
        return UIImage(ciImage: outputImage)
      }
    }
    return image
  }
  
  func getScratchFilter(at point: CIVector, radius: Float) -> CIFilter {
    if let newFilter = CIFilter(name: "CIRadialGradient") {
      newFilter.setValue(point, forKey: "inputCenter")
      newFilter.setValue(radius, forKey: "inputRadius0")
      newFilter.setValue(radius, forKey: "inputRadius1")
      newFilter.setValue(CIColor(red: 0, green: 1, blue: 0, alpha: 0), forKey: "inputColor0")
      newFilter.setValue(CIColor(red: 1, green: 1, blue: 1, alpha: 1), forKey: "inputColor1")
      return newFilter
    }
    return CIFilter()
  }
}
