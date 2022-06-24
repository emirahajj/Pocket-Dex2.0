//
//  PokemonDetailVC.swift
//  Pocket-Dex
//
//  Created by Emira Shano on 6/22/22.
//

import UIKit

class PokemonDetailVC: UIViewController {
    
    var pokename: String = ""
    var pokemon: Pokemon!
    var pokemonSpecies: PokemonSpecies!
    var pokemonEndpointURL: String {
        return "https://pokeapi.co/api/v2/pokemon/\(pokename)"
    }
    var pokemonSpeciesEndpointURL: String {
        return "https://pokeapi.co/api/v2/pokemon-species/\(pokename)"
    }
    
    
    @IBOutlet weak var pokeballImageView: UIImageView!
    @IBOutlet weak var mainDetailView: UIView!
    
    @IBOutlet weak var type1: PaddingLabel!
    @IBOutlet weak var pokeImage: UIImageView!
    
    @IBOutlet weak var dexEntryText: UILabel!
    @IBOutlet var statStackViews: [IndividualStatView]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

//        
    }
    
    //this is s a comment lmfao jdjfhdjhdffjhsfg
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
