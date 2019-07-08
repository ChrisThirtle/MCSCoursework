//
//  BunSection.swift
//  HamburgerAnimation
//
//  Created by Consultant on 7/7/19.
//  Copyright © 2019 Consultant. All rights reserved.
//

import UIKit

class BunSection {
  static let width = 100.0
  static let height = 10.0
  static let cornerRad = 4.0
  
  let layer: CAShapeLayer
  let path: UIBezierPath
  let rotation: CABasicAnimation
  let translation: CABasicAnimation
  let scalar: CABasicAnimation
  
  init(at x: Double, _ y: Double) {
    let rect = CGRect(x: x, y: y,
                      width: BunSection.width,
                      height: BunSection.height)
    
    self.path = UIBezierPath(roundedRect: rect,
                             cornerRadius: CGFloat(BunSection.cornerRad))
    
    self.layer = CAShapeLayer()
    self.layer.fillColor = UIColor.black.cgColor
    self.layer.bounds = rect
    self.layer.path = self.path.cgPath
    self.layer.position = CGPoint(x: x, y: y)
    self.layer.anchorPoint = CGPoint(x: 1.0,y: 0.5)
    
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
  
  func setAnchor(to: CGPoint) {
    self.layer.anchorPoint = to
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
