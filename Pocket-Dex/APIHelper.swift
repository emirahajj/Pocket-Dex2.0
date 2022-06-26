//
//  APIHelper.swift
//  Pocket-Dex
//
//  Created by Emira Shano on 6/21/22.
//

import Foundation

//represents server responce at endpoint https://pokeapi.co/api/v2/pokemon/<pokemonName>
struct PokemonEndpointResponse: Decodable {
    
    var base_experience: Int
    var id: Int
    var height: Int
    var weight: Int
    var name: String
    var abilities: [WrapperAbility]
    var types: [WrapperType]
    var stats: [WrapperStat]
    var moves: [PokemonMove]
    
    struct PokemonMove: Decodable {
        var move: InnerMove
        var version_group_details: [VersionGroupDetails]
    }
    struct InnerMove: Decodable {
        var name: String
        var url: String
    }
    
    struct VersionGroupDetails: Decodable {
        var level_learned_at: Int
        var move_learn_method: MoveLearnMethod
        var version_group: VersionGroup
    }
    
    struct VersionGroup: Decodable {
        var name: String
        var url: String
    }
    
    struct MoveLearnMethod: Decodable{
        var name: String
        var url: String
    }
    
    struct WrapperAbility: Decodable {
        var slot: Int
        var is_hidden: Bool
        var ability: Ability
    }
    struct Ability: Decodable {
        var name: String
        var url: String
    }
    struct WrapperType: Decodable {
        var slot: Int
        var type: PokemonType
    }
    struct PokemonType: Decodable {
        var name: String
        var url: String
    }
    struct WrapperStat: Decodable {
        var base_stat: Int
        var effort: Int
        var stat: Stat
    }
    struct Stat : Decodable {
        var name: String
    }
}

enum MoveType: String {
    case machine
    case tutor
    case levelUp = "level-up"
}

struct MachineMove {
    var name: String
    var versionGroup: String
}
struct TutorMove {
    var name: String
    var versionGroup: String
}
struct LevelUpMove {
    var name: String
    var versionGroup: String
    var levelLearned: Int
}

struct Pokemon: Decodable {
    var name: String
    var id: Int
    var abilities: [String] = []
    var types: [PokeType] = []
    var height: Int
    var weight: Int
    var stats: [String:Int] = [:]
    var sprite: String {
        return "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(id).png"
    }
    var machineMoves: [MachineMove] = []
    var tutorMoves: [TutorMove] = []
    var levelUpMoves: [LevelUpMove] = []
    
    // our Pokemon Detail VC is going to display all the moves this pokemon can learn under three categories: machine moves, tutor moves, and level up moves.
    // three separate structs are created with a name and versionGroup so they can be easily be filtered by gameVerision. Creating a generic Move object wastes space since the level learned property will be 0 for all types that are not level up moves.


    
    init(from decoder: Decoder) throws {
        let rawResponse = try! PokemonEndpointResponse(from: decoder)
        for element in rawResponse.abilities {
            abilities.append(element.ability.name)
        }
        //setting the pokemon types
        for element in rawResponse.types{
            if let newType = PokeType(rawValue: element.type.name) {
                types.append(newType)
            }
        }
        //setting the pokemon name
        self.name = rawResponse.name
        self.id = rawResponse.id
        
        //setting pokemon height and weight
        self.height = rawResponse.height
        self.weight = rawResponse.weight
        
        //setting the stats for the pokemon
        for element in rawResponse.stats {
            stats[element.stat.name] = element.base_stat
        }
        
        //setting the moves for the pokemon
        for element in rawResponse.moves {
            for element2 in element.version_group_details{
                let learnMethod = MoveType(rawValue: element2.move_learn_method.name)
                let versionGroup = element2.version_group.name
                let moveName = element.move.name
                switch(learnMethod){
                case .levelUp:
                    let levelLearned = element2.level_learned_at
                    let pokeMove = LevelUpMove(name: moveName, versionGroup: versionGroup, levelLearned: levelLearned)
                    levelUpMoves.append(pokeMove)
                case .machine:
                    let pokeMove = MachineMove(name: moveName, versionGroup: versionGroup)
                    machineMoves.append(pokeMove)
                case .tutor:
                    let pokeMove = TutorMove(name: moveName, versionGroup: versionGroup)
                    tutorMoves.append(pokeMove)
                case .none:
                    return
                }
                
            }
        }
    }
}

struct PokemonSpeciesEndpointResponse: Decodable {
    var egg_groups: [EggGroup] // A list of egg groups this species belongs to.
    var color: PokemonColor // The color of this pokemon
    var flavor_text_entries: [PokedexTextEntry]
    var gender_rate: Int // The chance of this Pokémon being female, in eighths; or -1 for genderless.
    var is_baby: Bool
    var is_legendary: Bool
    var is_mythical: Bool
    var capture_rate: Int // The base capture rate; up to 255. The higher the number, the easier the catch.
    var forms_switchable: Bool
    var varieties: [PokemonVariety]
    var evolution_chain: EvoChain
    
    struct EggGroup: Decodable {
        var name: String
        var url: String
    }
    
    struct PokemonColor: Decodable {
        var name: String
        var url: String
    }
    
    struct PokedexTextEntry: Decodable {
        var flavor_text: String
        var language: DexLanguage
        var version: VersionGroup
    }
    struct DexLanguage: Decodable {
        var name: String
        var url: String
    }
    struct VersionGroup: Decodable {
        var name: String
        var url: String
    }
    struct PokemonVariety: Decodable {
        var is_default: Bool
        var pokemon: InnerVariety
    }
    struct InnerVariety: Decodable {
        var name: String
        var url: String
    }
    struct EvoChain: Decodable {
        var url: String
    }
}

struct PokemonSpecies: Decodable {
    var color: String
    var genderRate: Int // The chance of this Pokémon being female, in eighths; or -1 for genderless.
    var isBaby: Bool
    var isLegendary: Bool
    var isMythical: Bool
    var captureRate: Int // The base capture rate; up to 255. The higher the number, the easier the catch.
    var canSwitchForms: Bool
    var evoChain: String
    var eggGroups: [String] = []
    var dexEntries: [PokedexTextEntry] = []
    
    struct PokedexTextEntry{
        var text: String
        var language: String
        var gameVersion: String
    }
    
    init(from decoder: Decoder) throws {
        let rawResponse = try! PokemonSpeciesEndpointResponse(from: decoder)
        self.color = rawResponse.color.name
        self.genderRate = rawResponse.gender_rate
        self.isBaby = rawResponse.is_baby
        self.isLegendary = rawResponse.is_legendary
        self.isMythical = rawResponse.is_mythical
        self.captureRate = rawResponse.capture_rate
        self.canSwitchForms = rawResponse.forms_switchable
        self.evoChain = rawResponse.evolution_chain.url
        for element in rawResponse.egg_groups{
            self.eggGroups.append(element.name)
        }
        for element in rawResponse.flavor_text_entries {
            let dexEntry = PokedexTextEntry(text: element.flavor_text, language: element.language.name, gameVersion: element.version.name)
            self.dexEntries.append(dexEntry)
        }
       

    }
    
}

func fetchSinglePokemon(_ pokemonEndpointURL: String, successCallBack: @escaping (Pokemon?) -> (), errorCallBack: ((Error?) -> ())?) {
    let url = URL(string: pokemonEndpointURL)!
    let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 30)
    let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
    let task: URLSessionDataTask = session.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
        if let error = error {
            errorCallBack?(error)
        } else if let data = data,
                  let pokemonResponse = try! JSONDecoder().decode(Pokemon?.self, from: data) {
            successCallBack(pokemonResponse)
        }
    }
    task.resume()
}

func fetchPokemonSpecies(_ pokemonSpeciesEndpointURL: String, successCallBack: @escaping (PokemonSpecies?) -> (), errorCallBack: ((Error?) -> ())?) {
    let url = URL(string: pokemonSpeciesEndpointURL)!
    let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 30)
    let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
    let task: URLSessionDataTask = session.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
        if let error = error {
            errorCallBack?(error)
        } else if let data = data,
                  let pokemonResponse = try! JSONDecoder().decode(PokemonSpecies?.self, from: data) {
            successCallBack(pokemonResponse)
        }
    }
    task.resume()
}
