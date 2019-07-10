//
//  PokemonController.swift
//  RealmProject
//
//  Created by Consultant on 7/9/19.
//  Copyright © 2019 Consultant. All rights reserved.
//

import Foundation
import RealmSwift

class PokemonController {
  let apiRootUrl = "https://pokeapi.co/api/v2/pokemon/"
  
  
  func getPokemon(using networkController: NetworkProtocol = NetworkController(),
                  from urlString: String,
                  completion: @escaping (Pokemon?) -> Void) {
    networkController.getData(for: urlString) { (data, error) in
      guard error == nil,
            let data = data,
            let pokemon = try? JSONDecoder().decode(Pokemon.self, from: data)
        else {
        completion(nil)
        return
      }
      completion(pokemon)
    }
  }
  
  func getRandomPokemon(completion: @escaping (Pokemon?) -> Void) {
    let pokedexNumber = Int(arc4random_uniform(151))
    self.getPokemon(from: apiRootUrl + "\(pokedexNumber)") { (pokemon) in
      completion(pokemon)
    }
  }
  
  func storePokemonInRealm(pokemon: Pokemon, completion: () -> Void) {
    RealmController.shared.addToRealm(pokemon)
    completion()
  }
  
  func getRealmPokemon() -> [Pokemon] {
    return RealmController.shared.getFromRealm(objectType: Pokemon.self)
      as? [Pokemon] ?? []
  }
  
  func getRealmPokemonUnconfined() -> [Pokemon] {
    let pokemonArray = RealmController.shared.getFromRealm(objectType: Pokemon.self)
      as? [Pokemon] ?? []
    let resultArray = pokemonArray.compactMap { Pokemon(pokemon: $0) }
    return resultArray
  }
}
