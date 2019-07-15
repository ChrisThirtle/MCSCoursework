//
//  ScratchCollectionViewCell.swift
//  ScratchOff
//
//  Created by Consultant on 7/14/19.
//  Copyright © 2019 Consultant. All rights reserved.
//

import UIKit
import CoreImage

class ScratchCollectionViewCell: UICollectionViewCell, NibRegistry {
  @IBOutlet weak var textLabel: UILabel!
  @IBOutlet weak var scratchOverlay: UIImageView!
  
  let isWinner: Bool = { Bool.random() }()
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    self.contentView.autoresizingMask.insert(.flexibleHeight)
    self.contentView.autoresizingMask.insert(.flexibleWidth)
  }
}

extension ScratchCollectionViewCell {
  @objc func handlePanGesture(_ gesture: UIPanGestureRecognizer) {
    let location = gesture.location(in: self)
    guard let image = scratchOverlay?.image else { return }
    let imageSizedLocation: CGPoint = {
      let x = location.x * (scratchOverlay.image?.size.width ?? 0) / scratchOverlay.frame.size.width
      let y = (scratchOverlay.image?.size.height ?? 0) - location.y * (scratchOverlay.image?.size.height ?? 0) / scratchOverlay.frame.size.height
      return CGPoint(x: x, y: y)
    }()
    scratchOverlay.image = ImageController.shared.scratchImage(image: image, point: imageSizedLocation)
  }
}
