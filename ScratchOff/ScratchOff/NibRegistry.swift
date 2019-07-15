//
//  AwakeableCell.swift
//  ScratchOff
//
//  Created by Consultant on 7/14/19.
//  Copyright © 2019 Consultant. All rights reserved.
//

import UIKit

protocol NibRegistry {
  static var bundle: Bundle? { get }
  static var identifier: String { get }
}

extension NibRegistry where Self: UICollectionViewCell {
  static var bundle: Bundle? {
    return nil
  }
  
  static var identifier: String {
    return String(describing: self)
  }
}
