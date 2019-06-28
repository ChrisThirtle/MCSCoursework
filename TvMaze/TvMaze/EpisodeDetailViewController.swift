//
//  EpisodeDetailViewController.swift
//  TvMaze
//
//  Created by Consultant on 6/27/19.
//  Copyright © 2019 Consultant. All rights reserved.
//

import UIKit

class EpisodeDetailViewController: UIViewController {
  
  @IBOutlet weak var episodeImageView: UIImageView!
  
  @IBOutlet weak var episodeTitleLabel: UILabel!
  @IBOutlet weak var episodeSeasonLabel: UILabel!
  @IBOutlet weak var episodeNumberLabel: UILabel!
  @IBOutlet weak var episodeAirdateLabel: UILabel!
  @IBOutlet weak var episodeSummaryLabel: UILabel!
  
  var episode: Episode?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    if let episode = self.episode {
      episodeTitleLabel.text = episode.name
      episodeSeasonLabel.text = "Season - \(episode.season)"
      episodeNumberLabel.text = "Episode - \(episode.episodeNumber)"
      episodeAirdateLabel.text = "Airdate - \(episode.airdate)"
      episodeSummaryLabel.text = episode.summary
    }
    // Do any additional setup after loading the view.
  }
  
  
  /*
   // MARK: - Navigation
   
   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   // Get the new view controller using segue.destination.
   // Pass the selected object to the new view controller.
   }
   */
  
}
