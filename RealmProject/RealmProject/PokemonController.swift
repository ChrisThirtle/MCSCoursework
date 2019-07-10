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
  
  func storePokemon(pokemon: Pokemon, in realm: Realm?) {
    guard let realm = realm else { return }
    DispatchQueue.main.async {
      do {
        try realm.write {
          realm.add(pokemon)
        }
      }
      catch {
        print(error)
      }
    }
  }
  
  func getPokemon(from realm: Realm?) -> [Pokemon] {
    guard let realm = realm else { return [] }
    return Array(realm.objects(Pokemon.self))
  }
}
