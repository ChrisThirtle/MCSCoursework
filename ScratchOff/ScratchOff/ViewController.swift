//
//  ViewController.swift
//  ScratchOff
//
//  Created by Consultant on 7/14/19.
//  Copyright © 2019 Consultant. All rights reserved.
//

import UIKit
import CoreImage

class ViewController: UIViewController {
  
  @IBOutlet weak var collectionView: UICollectionView!
  @IBOutlet weak var newCardButton: UIButton!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    collectionView.register(cell: ScratchCollectionViewCell.self)
    collectionView.dataSource = self
    collectionView.delegate = self
    newCardButton.addTarget(self, action: #selector(newCard), for: .touchUpInside)
    
    let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(ViewController.handlePanGesture))
    self.view.addGestureRecognizer(panGestureRecognizer)
  }
  
  override func viewDidLayoutSubviews()
  {
    super.viewDidLayoutSubviews()
    collectionView.collectionViewLayout.invalidateLayout()
  }
  
  @objc func newCard() {
    //Gets a new scratch card by just getting a new set of collection cells, it's that easy.
    collectionView.reloadData()
  }
}

extension ViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 16
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeue(cell: ScratchCollectionViewCell.self, for: indexPath)
    cell.textLabel?.text = cell.isWinner ? "Win" : "Lose"
    if let scratchImage = ImageController.shared.baseScratchImage {
      cell.scratchOverlay.image = UIImage(ciImage: scratchImage)
    }
    return cell
  }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let x = collectionView.frame.width / 5.0
    let y = collectionView.frame.height / 5.0
    return CGSize(width: x, height: y)
  }
}

extension ViewController {
  @objc func handlePanGesture(_ gesture: UIPanGestureRecognizer) {
    if gesture.state != .began,
      gesture.state != .changed,
      gesture.state != .ended {
      return
    }
    let point = gesture.location(in: self.collectionView)
    guard let indexPath = self.collectionView.indexPathForItem(at: point),
      let cell = self.collectionView.cellForItem(at: indexPath) as? ScratchCollectionViewCell else { return }
    cell.handlePanGesture(gesture)
  }
}
