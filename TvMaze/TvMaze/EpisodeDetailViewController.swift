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
    ThemeController.registerThemeable(self)
    if let episode = self.episode {
      episodeTitleLabel.text = episode.name
      episodeSeasonLabel.text = "Season - \(episode.season)"
      episodeNumberLabel.text = "Episode - \(episode.episodeNumber)"
      episodeAirdateLabel.text = "Airdate - \(episode.airdate)"
      episodeSummaryLabel.text = episode.summary
    }
    // Do any additional setup after loading the view.
  }
}

extension EpisodeDetailViewController: Themeable {
  func changeTheme() {
    navigationController?.navigationBar.barStyle = ThemeController.shared.barStyle
    
    self.view.backgroundColor = ThemeController.shared.mainColor
    self.view.tintColor = ThemeController.shared.tintColor
    
    episodeTitleLabel.textColor = ThemeController.shared.textColor
    episodeSeasonLabel.textColor = ThemeController.shared.textColor
    episodeNumberLabel.textColor = ThemeController.shared.textColor
    episodeAirdateLabel.textColor = ThemeController.shared.textColor
    episodeSummaryLabel.textColor = ThemeController.shared.textColor
    
    view.setNeedsDisplay()
  }
}
