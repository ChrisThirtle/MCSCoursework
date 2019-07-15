//
//  CollectionDeque.swift
//  ScratchOff
//
//  Created by Consultant on 7/14/19.
//  Copyright © 2019 Consultant. All rights reserved.
//

import UIKit

extension UICollectionView {
  func register<T: UICollectionViewCell & NibRegistry>(cell: T.Type) {
    let nib = UINib(nibName: cell.identifier, bundle: cell.bundle)
    self.register(nib, forCellWithReuseIdentifier: cell.identifier)
  }
  
  func dequeue<T: UICollectionViewCell & NibRegistry>(cell: T.Type, for indexPath: IndexPath) -> T {
    let collectionCell = self.dequeueReusableCell(withReuseIdentifier: cell.identifier, for: indexPath)
    guard let unwrappedCollectionCell = collectionCell as? T else {
      fatalError("Could not dequeue cell, was of incorrect type. Programmer error")
    }
    return unwrappedCollectionCell
  }
}
