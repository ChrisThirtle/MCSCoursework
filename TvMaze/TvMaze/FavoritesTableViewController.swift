//
//  FavoritesViewController.swift
//  TvMaze
//
//  Created by Consultant on 6/30/19.
//  Copyright © 2019 Consultant. All rights reserved.
//

import UIKit

class FavoritesTableViewController: UIViewController {
  
  @IBOutlet weak var tableView: UITableView!
  
  var favorites = [FavoriteEpisode]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    favorites = CoreDataManager.shared.getFavorites()
    
    navigationController?.title = "Favorites"
    
    tableView.dataSource = self
    tableView.delegate = self
    
    ThemeController.registerThemeable(self)
  }

  @IBAction func editMode(sender: UIBarButtonItem) {
    if tableView.isEditing {
      tableView.setEditing(true, animated: true)
      sender.title = "Done"
    }
    else {
      tableView.setEditing(false, animated: true)
      sender.title = "Edit"
    }
  }
}

extension FavoritesTableViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return favorites.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteCell", for: indexPath)
    cell.textLabel?.text = favorites[indexPath.row].name
    
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
  
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    CoreDataManager.shared.removeFavorite(favorite: favorites[indexPath.row])
    favorites.remove(at: indexPath.row)
    tableView.deleteRows(at: [indexPath], with: .fade)
  }
  
}

extension FavoritesTableViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
    return .delete
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    guard let episodeDetailView = storyboard?.instantiateViewController(withIdentifier: "EpisodeDetailViewController") as? EpisodeDetailViewController else { return }
    episodeDetailView.episode = Episode(from: self.favorites[indexPath.row])
    navigationController?.pushViewController(episodeDetailView, animated: true)
  }
}

extension FavoritesTableViewController: Themeable {
  func changeTheme() {
    view.backgroundColor = ThemeController.shared.mainColor
    view.tintColor = ThemeController.shared.tintColor
    
    tableView.backgroundColor = ThemeController.shared.mainColor
    tableView.reloadData()
  }
}
