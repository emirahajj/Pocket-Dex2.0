//
//  PokemonDetailViewController.swift
//  Pocket-Dex
//
//  Created by Emira Shano on 6/19/22.
//

import UIKit

class PokemonDetailViewController: UIViewController {
    
    var pokename: String = ""
    var pokemon: Pokemon!
    var pokemonSpecies: PokemonSpecies!
    var pokemonEndpointURL: String {
        return "https://pokeapi.co/api/v2/pokemon/\(pokename)"
    }
    var pokemonSpeciesEndpointURL: String {
        return "https://pokeapi.co/api/v2/pokemon-species/\(pokename)"
    }
    
    @IBOutlet weak var abilitiesView: UIView!
    
    @IBOutlet weak var outerStack: UIStackView!
    @IBOutlet weak var pokeball: UIImageView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var pokeImage: UIImageView!
    
    @IBOutlet weak var dexNumber: UILabel!
    @IBOutlet weak var type1: TypeButtonView!
    @IBOutlet weak var type2: TypeButtonView!
    @IBOutlet weak var dexEntryText: PaddingLabel!
    @IBOutlet var statStackViews: [IndividualStatView]!
    
    @IBOutlet weak var typesStackView: UIStackView!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = pokename.capitalized
        topView.layer.cornerRadius = 20;
//        topView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        pokeball.transform = pokeball.transform.rotated(by: .pi / 6)

        fetchPokemonSpecies(self.pokemonSpeciesEndpointURL, successCallBack: {response in
            guard let response = response else {
                return
            }
            self.pokemonSpecies = response
            
            let dexEntries = response.dexEntries.filter{$0.language == "en"}
            self.dexEntryText.text = dexEntries[0].text.replacingOccurrences(of: "\\s", with: " ", options: .regularExpression)

        }, errorCallBack: {error in
            guard let error = error else {
                return
            }
            print(error)
        })

        fetchSinglePokemon(self.pokemonEndpointURL, successCallBack: {response in
            guard let response = response else {
                return
            }
            self.pokemon = response
            let firstType = response.types[0] //extracting the color for the view using PokeType
            
            self.dexNumber.text = styleDexNumber(num: response.id)
            
            //configure main view background
            self.view.backgroundColor = colorDict[firstType]?.adjust(by: -20)
            
            //configure type buttons
            self.type1.configureImageAndText(type: response.types[0])
            switch response.types.count{
            case 1:
                self.type2.removeFromSuperview()
                break
            case 2:
                self.type2.configureImageAndText(type: response.types[1])
            default:
                return
            }
            
            //setting up the main pokemon image w/ styling
            if let imageURL = URL(string: response.sprite) {
                downloadTask = self.pokeImage.loadImage(url: imageURL)
                self.pokeImage.layer.magnificationFilter = CALayerContentsFilter.nearest
                self.pokeImage.layer.shadowOpacity = 1.0
                self.pokeImage.layer.shadowRadius = 10
                self.pokeImage.layer.shadowColor = UIColor.black.cgColor
                self.pokeImage.layer.shadowOffset = CGSize(width: 2, height: 2)
            }
            
            //configure the statStackview labels
            for i in 0..<self.statStackViews.count {
                let convertedStat = StatLookup[self.statStackViews[i].leftLabel.text!] //turns HP -> hp so we can look up in dctionary
                let statAmount = response.stats[convertedStat!]
                self.statStackViews[i].rightLabel.text = String(statAmount!) //in parenthesis is an Integer
                self.statStackViews[i].layer.backgroundColor = colorDict[response.types[0]]?.cgColor
                self.statStackViews[i].spacing = CGFloat(statAmount!/3)
            }
            
            //configure middle view
            self.topView.backgroundColor = colorDict[firstType]?.adjust(by: -20)
//            self.topView.addBottomShadow()
            self.topView.layer.shadowRadius = 0.5
            self.topView.layer.shadowColor = UIColor.black.cgColor
            self.topView.layer.shadowOffset = CGSize(width: 0, height: 5)
            self.topView.layer.masksToBounds = false
            //self.topView.layer.shadowOpacity = 0.5
            //            self.outerStack.layer.shadowOpacity = 0.5


        }, errorCallBack: {error in
            guard let error = error else {
                return
            }
            print(error)
        })

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let destination = segue.destination as? MoveSetVC else {return}
        print(pokemon.machineMoves)
        destination.machineMoves = pokemon.machineMoves
        destination.tutorMoves = pokemon.tutorMoves
        destination.levelUpMoves = pokemon.levelUpMoves
        
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}

