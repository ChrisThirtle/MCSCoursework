//
//  HamburgerLayer.swift
//  HamburgerAnimation
//
//  Created by Consultant on 7/8/19.
//  Copyright © 2019 Consultant. All rights reserved.
//

import UIKit

class HamburgerLayer {
  static let width = 100.0
  static let height = 10.0
  static let cornerRad = 4.0
  
  
  var buns = [BunSection]()
  let layer: CAShapeLayer
  let rotation: CABasicAnimation
  let translation: CABasicAnimation
  let scalar: CABasicAnimation
  
  init(at x: Double, _ y: Double) {
    let rect = CGRect(x: x, y: y,
                      width: BunSection.width,
                      height: BunSection.height * 5)
    
    self.layer = CAShapeLayer()
    self.layer.bounds = rect
    self.layer.position = CGPoint(x: x, y: y)
    self.layer.anchorPoint = CGPoint(x: -0.5, y: 0.5)
    
    for index in 0..<3 {
      let bun = BunSection(at: x, y + Double(index) * 2.0 * BunSection.height)
      self.layer.addSublayer(bun.layer)
      self.buns.append(bun)
    }
    
    self.rotation = CABasicAnimation(keyPath: "transform.rotation")
    self.rotation.isRemovedOnCompletion = false
    self.rotation.fillMode = .forwards
    
    self.translation = CABasicAnimation(keyPath: "position")
    self.translation.isRemovedOnCompletion = false
    self.translation.fillMode = .forwards
    
    self.scalar = CABasicAnimation(keyPath: "transform.scale")
    self.scalar.isRemovedOnCompletion = false
    self.scalar.fillMode = .forwards
  }
  
  func rotate(by: Float, duration: TimeInterval) {
    rotation.byValue = by
    rotation.duration = duration
    self.layer.add(rotation, forKey: nil)
  }
  
  func translate(byX: Float, byY: Float, duration: TimeInterval) {
    translation.byValue = [byX, byY]
    translation.duration = duration
    self.layer.add(translation, forKey: nil)
  }
  
  func scale(byX: Float, byY: Float, duration: TimeInterval) {
    scalar.byValue = [byX, byY]
    scalar.duration = duration
    self.layer.add(scalar, forKey: nil)
  }
}
