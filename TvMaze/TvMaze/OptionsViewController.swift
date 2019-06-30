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
  let settings = [Setting(.nightMode)]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.dataSource = self
    ThemeController.registerThemeable(self)
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
    cell.settingLabel?.text = settings[indexPath.row].description.rawValue
    cell.settingSwitch?.setOn(settings[indexPath.row].value, animated: false)
    cell.settingSwitch?.tag = indexPath.row
    cell.settingSwitch?.addTarget(self, action: #selector(settingHandler), for: .valueChanged)
    
    //Theming
    cell.backgroundColor = ThemeController.shared.mainColor
    cell.settingLabel?.textColor = ThemeController.shared.textColor
    cell.selectedBackgroundView = {
      let view = UIView()
      view.backgroundColor = ThemeController.shared.highlightColor
      return view
    }()
    
    return cell
  }
}

extension OptionsViewController: Themeable {
  func changeTheme() {
    navigationController?.navigationBar.barStyle = ThemeController.shared.barStyle
    
    self.view.backgroundColor = ThemeController.shared.mainColor
    self.view.tintColor = ThemeController.shared.tintColor
    
    tableView.backgroundColor = ThemeController.shared.mainColor
    
    tableView.reloadData()
    view.setNeedsDisplay()
  }
}
