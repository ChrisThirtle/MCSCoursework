import UIKit

class Ability {
    let name: String
    let descriptionUrlString: String
    let isHidden: Bool
    let slot: Int
    init?(with dictionary: [String:Any] ) {
        guard let ability = dictionary["ability"] as? [String:Any],
            let name = ability["name"] as? String,
            let descriptionUrlString = ability["url"] as? String,
            let isHidden = dictionary["is_hidden"] as? Bool,
            let slot = dictionary["slot"] as? Int
            else {
                return nil
        }
        self.name = name
        self.descriptionUrlString = descriptionUrlString
        self.isHidden = isHidden
        self.slot = slot
    }
}

class GameIndex {
    let versionName: String
    let versionDescriptionUrlString: String
    let index: Int
    
    init?(with dictionary: [String:Any] ) {
        guard let version = dictionary["version"] as? [String:Any],
            let versionName = version["name"] as? String,
            let versionDescriptionUrlString = version["url"] as? String,
            let index = dictionary["game_index"] as? Int
            else {
                return nil
        }
        self.versionName = versionName
        self.versionDescriptionUrlString = versionDescriptionUrlString
        self.index = index
    }
}

class Pokemon {
    let name: String
    let identifier: UInt
    let height: UInt
    let weight: UInt
    let abilities: [Ability]
    let gameIndices: [GameIndex]
    
    init() {
        self.name = ""
        self.identifier = 0
        self.height = 0
        self.weight = 0
        self.abilities = []
        self.gameIndices = []
    }
    init?(with dictionary: [String:Any] ) {
        guard let name = dictionary["name"] as? String,
            let identifier = dictionary["id"] as? UInt,
            let height = dictionary["height"] as? UInt,
            let weight = dictionary["weight"] as? UInt,
            let abilities = dictionary["abilities"] as? [[String: Any]],
            let gameIndices = dictionary["game_indices"] as? [[String: Any]] else {
            return nil
        }
        self.name = name
        self.identifier = identifier
        self.height = height
        self.weight = weight
        self.abilities = abilities.compactMap { Ability(with: $0) }
        self.gameIndices = gameIndices.compactMap { GameIndex(with: $0) }
    }
}

if let url = Bundle.main.url(forResource: "PokemonExample", withExtension: "json"),
    let data = try? Data(contentsOf: url),
    let jsonObject = try? JSONSerialization.jsonObject(with: data, options: []),
    let jsonDict = jsonObject as? [String: Any],
    let pocketMonster = Pokemon(with: jsonDict) {
    /* Previous print statements
    print(pocketMonster)
    print(pocketMonster.name)
    print(pocketMonster.identifier)
    for abl in pocketMonster.abilities {
        print(abl.name)
    }*/
    //Game Indices print demonstration, result is the Pokemon games with this pokemon printed in sequential order
    for gi in pocketMonster.gameIndices.reversed() {
        print(gi.versionName.capitalized)
    }
}
else { print("Something broke") }




