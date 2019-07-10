//
//  ViewController.swift
//  RealmProject
//
//  Created by Consultant on 7/9/19.
//  Copyright © 2019 Consultant. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController {

  @IBOutlet weak var pokeTable: UITableView!
  
  var pokemonArray = [Pokemon]()
  let realm = try? Realm()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    pokeTable.dataSource = self
    
    self.pokemonArray = PokemonController().getPokemon(from: realm) 
    
    PokemonController().getRandomPokemon { (pokemon) in
      guard let pokemon = pokemon else { return }
      self.pokemonArray.append(pokemon)
      PokemonController().storePokemon(pokemon: pokemon, in: self.realm)
      DispatchQueue.main.async {
        self.pokeTable.reloadData()
      }
    }
    
    
  }
}

extension ViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return pokemonArray.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "pokeCell", for: indexPath)
    cell.textLabel?.text = pokemonArray[indexPath.row].name.capitalized
    return cell
  }
  
  
}
