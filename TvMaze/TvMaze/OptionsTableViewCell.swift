//
//  OptionsTableViewCell.swift
//  TvMaze
//
//  Created by Consultant on 6/27/19.
//  Copyright © 2019 Consultant. All rights reserved.
//

import UIKit

class OptionsTableViewCell: UITableViewCell {
  
  @IBOutlet weak var settingLabel: UILabel?
  @IBOutlet weak var settingSwitch: UISwitch?
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    // Configure the view for the selected state
  }
}
