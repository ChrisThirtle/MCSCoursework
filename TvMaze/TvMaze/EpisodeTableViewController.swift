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
    ThemeController.registerThemeable(self)
    
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
  
  @IBAction func gotoOptionsMenu(sender: UIBarButtonItem) {
    let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
    guard let optionsMenuView = storyboard.instantiateViewController(withIdentifier: "OptionsViewController") as? OptionsViewController else { return }
    navigationController?.pushViewController(optionsMenuView, animated: true)
  }
  
  @IBAction func gotoFavoritesMenu(sender: UIBarButtonItem) {
    let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
    guard let favoritesMenuView = storyboard.instantiateViewController(withIdentifier: "FavoritesTableViewController") as? FavoritesTableViewController else { return }
    favoritesMenuView.showImage = self.showImageView.image
    navigationController?.pushViewController(favoritesMenuView, animated: true)
  }
  
  @IBAction func addToFavorites(sender: UIButton) {
    guard let cell = sender.superview?.superview as? UITableViewCell,
      let indexPath = tableView.indexPath(for: cell) else {
      return
    }
    CoreDataManager.shared.addFavorite(episode: seasons[indexPath.section][indexPath.row])
  }
}

extension EpisodeTableViewController: UITableViewDataSource {
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return self.seasons.count
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.seasons[section].count
  }
  
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let view = UITableViewHeaderFooterView()
    view.textLabel?.text = "Season \(section + 1)"
    
    //Theming
    view.textLabel?.font = UIFont.systemFont(ofSize: 20)
    view.textLabel?.textColor = ThemeController.shared.textColor.withAlphaComponent(1)
    view.backgroundView?.backgroundColor = ThemeController.shared.secondaryColor
    view.contentView.backgroundColor = ThemeController.shared.secondaryColor
    
    return view
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! EpisodeTableViewCell
    let episode = seasons[indexPath.section][indexPath.row]
    cell.textLabel?.text = "S\(episode.season)E\(episode.episodeNumber) - \(episode.name)"
    cell.favoriteButton.addTarget(self, action: #selector(addToFavorites), for: .touchUpInside)
    
    //Theming
    cell.backgroundColor = ThemeController.shared.mainColor
    cell.textLabel?.textColor = ThemeController.shared.textColor
    cell.selectedBackgroundView = {
      let view = UIView()
      view.backgroundColor = ThemeController.shared.highlightColor
      return view
    }()
    return cell
  }
}

extension EpisodeTableViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    guard let episodeDetailView = storyboard?.instantiateViewController(withIdentifier: "EpisodeDetailViewController") as? EpisodeDetailViewController else { return }
    episodeDetailView.episode = self.seasons[indexPath.section][indexPath.row]
    navigationController?.pushViewController(episodeDetailView, animated: true)
  }
}

extension EpisodeTableViewController: Themeable {
  func changeTheme() {
    navigationController?.navigationBar.barStyle = ThemeController.shared.barStyle
    
    view.backgroundColor = ThemeController.shared.mainColor
    view.tintColor = ThemeController.shared.tintColor
    
    tableView.backgroundColor = ThemeController.shared.mainColor
    tableView.reloadData()
  }
}
