//
//  ViewController.swift
//  June28Test
//
//  Created by Consultant on 6/28/19.
//  Copyright © 2019 Consultant. All rights reserved.
//

import UIKit

class EpisodeViewController: UIViewController {
  
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var searchBar: UISearchBar!
  var seasons: [[Episode]] = []
  var epImages: [[UIImage?]] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.dataSource = self
    tableView.delegate = self
    searchBar.delegate = self
    
    ShowController().getShow(url: "https://api.tvmaze.com/shows/82?embed=seasons&embed=episodes") { (myShow) in
      self.seasons = ShowController().sortEpisodesToSeasons(episodes: myShow.episodes)
      
      self.epImages = [[UIImage]](repeating: [], count: self.seasons.count)
      for (seasonIndex, _) in self.seasons.enumerated() {
        self.epImages[seasonIndex] = [UIImage](repeating: UIImage(),
                                               count: self.seasons[seasonIndex].count)
      }
      
      DispatchQueue.main.async {
        self.navigationItem.title = myShow.name
        self.tableView.reloadData()
      }
      
      for (seasonIndex, season) in self.seasons.enumerated() {
        for (episodeIndex, episode) in season.enumerated() {
          ShowController().getImageData(imageUrl: episode.image?.mediumString ?? "") { (data) in
            guard let data = data,
              let image = UIImage(data: data) else {
                return
            }
            self.epImages[seasonIndex][episodeIndex] = image
            DispatchQueue.main.async {
              self.tableView.reloadData()
            }
          }
        }
      }
    }
  }
}

extension EpisodeViewController: UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    return seasons.count
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return seasons[section].filter(matchesSearchBar).count
  }
  
  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return "Season \(section + 1)"
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "episodeCell", for: indexPath)
    
    let selectedEpisodes = seasons[indexPath.section].filter(matchesSearchBar)
    let episode = selectedEpisodes[indexPath.row]
    cell.imageView?.image = epImages[indexPath.section][indexPath.row]
    cell.textLabel?.text = "E\(episode.episodeNumber) - \(episode.name)"
    return cell
  }
}

extension EpisodeViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    guard let episodeDetailViewController = storyboard?.instantiateViewController(withIdentifier: "EpisodeDetailViewController") as? EpisodeDetailViewController else {
      return
    }
    episodeDetailViewController.episode = seasons[indexPath.section][indexPath.row]
    navigationController?.pushViewController(episodeDetailViewController, animated: true)
  }
  
}

extension EpisodeViewController: UISearchBarDelegate {
  //Actual filtering occurs in UITableViewDataSource
  func matchesSearchBar(_ episode: Episode) -> Bool {
    if searchBar?.text?.trimmingCharacters(in: .whitespaces) == "" {
      return true
    }
    return episode.name.contains(searchBar?.text ?? "")
  }
  
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar){
    tableView.reloadData()
  }
}
