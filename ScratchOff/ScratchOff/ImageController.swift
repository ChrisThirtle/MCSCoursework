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
  
  func scratch(point: CIVector, radius: Float) -> CIFilter? {
    let newFilter = CIFilter(name: "CIRadialGradient")
    newFilter?.setValue(point, forKey: "inputCenter")
    newFilter?.setValue(radius, forKey: "inputRadius0")
    newFilter?.setValue(radius, forKey: "inputRadius1")
    newFilter?.setValue(CIColor(red: 0, green: 1, blue: 0, alpha: 0), forKey: "inputColor0")
    newFilter?.setValue(CIColor(red: 1, green: 1, blue: 1, alpha: 1), forKey: "inputColor1")
    return newFilter
  }
}
