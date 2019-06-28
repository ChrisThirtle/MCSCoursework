//
//  EpisodeDetailViewController.swift
//  June28Test
//
//  Created by Consultant on 6/28/19.
//  Copyright © 2019 Consultant. All rights reserved.
//

import UIKit

class EpisodeDetailViewController: UIViewController {
  
  var episode: Episode?
  
  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var seasonLabel: UILabel!
  @IBOutlet weak var episodeLabel: UILabel!
  @IBOutlet weak var premiereLabel: UILabel!
  @IBOutlet weak var airtimeLabel: UILabel!
  @IBOutlet weak var summaryLabel: UILabel!
  override func viewDidLoad() {
    super.viewDidLoad()
    
    guard let episode = episode else {
      return
    }
    
    titleLabel.text?.append(episode.name)
    seasonLabel.text?.append(String(episode.season))
    episodeLabel.text?.append(String(episode.episodeNumber))
    premiereLabel.text?.append(episode.airdate)
    airtimeLabel.text?.append(episode.airtime)
    
    summaryLabel.text = ShowController().stripHtmlFromSummary(summary: episode.summary ?? "No summary for this episode")
    
    if let imageUrlString = episode.image?.originalString {
      ShowController().getImageData(imageUrl: imageUrlString) { (data) in
        guard let data = data,
          let image = UIImage(data: data) else {
          return
        }
        DispatchQueue.main.async {
          self.imageView.image = image
        }
      }
    }
  }
}
