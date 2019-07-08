//
//  ViewController.swift
//  HamburgerAnimation
//
//  Created by Consultant on 7/7/19.
//  Copyright © 2019 Consultant. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  
  let burger = HamburgerLayer(at: 200, 200)
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.layer.addSublayer(burger.layer)
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    DispatchQueue.global().async {
      self.animation()
    }
    
  }
  
  func animation() {
    
    let duration = 0.5
    let pause = UInt32(ceil(duration * 2))
    
    while true {
      DispatchQueue.main.sync {
        self.burger.rotate(by: Float.pi, duration: duration)
        self.burger.buns[0].rotate(by: Float.pi/4, duration: duration)
        self.burger.buns[0].translate(byX: 0, byY: Float(BunSection.height*2), duration: duration)
        self.burger.buns[0].scale(byX: -0.5, byY: 0.5, duration: duration)
        self.burger.buns[2].rotate(by: -Float.pi/4, duration: duration)
        self.burger.buns[2].translate(byX: 0, byY: Float(-BunSection.height*2), duration: duration)
        self.burger.buns[2].scale(byX: -0.5, byY: 0.5, duration: duration)
      }
      
      sleep(pause)
      
      DispatchQueue.main.sync {
        self.burger.rotate(by: Float.pi, duration: duration)
        self.burger.buns[0].rotate(by: -Float.pi/4, duration: duration)
        self.burger.buns[0].translate(byX: 0, byY: Float(-BunSection.height*2), duration: duration)
        self.burger.buns[0].scale(byX: 0.5, byY: -0.5, duration: duration)
        self.burger.buns[2].rotate(by: Float.pi/4, duration: duration)
        self.burger.buns[2].translate(byX: 0, byY: Float(BunSection.height*2), duration: duration)
        self.burger.buns[2].scale(byX: 0.5, byY: -0.5, duration: duration)
      }
      
      sleep(pause)
    }
  }
}

