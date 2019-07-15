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
  var imageMask = CIFilter(name: "CIMultiplyCompositing")
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    self.contentView.autoresizingMask.insert(.flexibleHeight)
    self.contentView.autoresizingMask.insert(.flexibleWidth)
  }
}

extension ScratchCollectionViewCell {
  @objc func handlePanGesture(_ gesture: UIPanGestureRecognizer) {
    let location = CIVector(cgPoint: gesture.location(in: self))
    guard let image = scratchOverlay.image?.ciImage else { return }
    let imageSizedLocation: CIVector = {
      let x = location.x * (scratchOverlay.image?.size.width ?? 0) / scratchOverlay.frame.size.width
      let y = (scratchOverlay.image?.size.height ?? 0) - location.y * (scratchOverlay.image?.size.height ?? 0) / scratchOverlay.frame.size.height
      return CIVector(x: x, y: y)
    }()
    
    guard let imageMask = self.imageMask,
      let newFilter = ImageController.shared.scratch(point: imageSizedLocation, radius: 5),
      let newFilterImage = newFilter.outputImage
        else { return }
    imageMask.setValue(image, forKey: "inputImage")
    imageMask.setValue(newFilterImage, forKey: "inputBackgroundImage")
    
    guard let outputImage = imageMask.outputImage else { return }
    scratchOverlay.image = UIImage(ciImage: outputImage)
  }
}
