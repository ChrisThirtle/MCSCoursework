//
//  OptionsViewController.swift
//  TvMaze
//
//  Created by Consultant on 6/27/19.
//  Copyright © 2019 Consultant. All rights reserved.
//

import UIKit

class OptionsViewController: UIViewController {
  
  @IBOutlet weak var tableView: UITableView!
  let settings = [Setting("Night Mode")]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.dataSource = self
  }
 
  @IBAction func settingHandler(sender: UISwitch) {
    settings[sender.tag].value = sender.isOn
    view.setNeedsDisplay()
  }
}

extension OptionsViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return settings.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "optionCell", for: indexPath) as! OptionsTableViewCell
    cell.settingLabel?.text = settings[indexPath.row].description
    cell.settingSwitch?.setOn(settings[indexPath.row].value, animated: false)
    cell.settingSwitch?.tag = indexPath.row
    cell.settingSwitch?.addTarget(self, action: #selector(settingHandler), for: .valueChanged)
    return cell
  }
}
