//
//  ViewController.swift
//  TvMaze
//
//  Created by Consultant on 6/26/19.
//  Copyright © 2019 Consultant. All rights reserved.
//

import UIKit

class EpisodeTableViewController: UIViewController {
  
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var showImageView: UIImageView!
  
  var seasons = [[Episode]]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    //tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    tableView.dataSource = self
    tableView.delegate = self
    
    ShowController().getShow(urlString: "https://api.tvmaze.com/shows/4631?embed=seasons&embed=episodes") { (show) in
      //print(show ?? "There is no show")
      guard let myShow = show else {
        return
      }
      self.seasons = ShowController().sortShowBySeasons(show: myShow)
      ShowController().getImage(imageString: myShow.image?.originalString ?? "", completionHandler: { (image, error) in
        guard let image = image else {
          return
        }
        DispatchQueue.main.async {
          self.showImageView.image = image
        }
      })
      
      DispatchQueue.main.async {
        //Main dispatch queue, all display related actions go here
        self.navigationItem.title = myShow.name
        self.tableView.reloadData()
      }
    }
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    for cell in tableView.visibleCells {
      cell.textLabel?.textColor = ThemeController.currentTheme?.textColor
    }
  }
  
  @IBAction func gotoOptionsMenu(sender: UIBarButtonItem) {
    let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
    guard let optionsMenuView = storyboard.instantiateViewController(withIdentifier: "OptionsViewController") as? OptionsViewController else { return }
    navigationController?.pushViewController(optionsMenuView, animated: true)
  }
}

extension EpisodeTableViewController: UITableViewDataSource {
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return self.seasons.count
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.seasons[section].count
  }
  
  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return "Season \(section + 1)"
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    let episode = seasons[indexPath.section][indexPath.row]
    cell.textLabel?.text = "S\(episode.season)E\(episode.episodeNumber) - \(episode.name)"
    cell.textLabel?.textColor = ThemeController.currentTheme?.textColor
    cell.accessoryType = .detailDisclosureButton
    return cell
  }
}

extension EpisodeTableViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    guard let episodeDetailView = storyboard?.instantiateViewController(withIdentifier: "EpisodeDetailViewController") as? EpisodeDetailViewController else { return }
    episodeDetailView.episode = self.seasons[indexPath.section][indexPath.row]
    navigationController?.pushViewController(episodeDetailView, animated: true)
  }
  
  func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    cell.textLabel?.textColor = ThemeController.currentTheme?.textColor
  }
}
