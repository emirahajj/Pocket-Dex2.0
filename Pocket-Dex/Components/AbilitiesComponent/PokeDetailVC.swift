//
//  PokeDetailVC.swift
//  Pocket-Dex
//
//  Created by Emira Shano on 6/27/22.
//

import UIKit

class PokeDetailVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var pokename: String = ""
    var pokemon: Pokemon?
    var pokemonSpecies: PokemonSpecies!
    var pokemonEndpointURL: String {
        return "https://pokeapi.co/api/v2/pokemon/\(pokename)"
    }
    var pokemonSpeciesEndpointURL: String {
        return "https://pokeapi.co/api/v2/pokemon-species/\(pokename)"
    }
    @IBOutlet weak var moveSetButton: UIBarButtonItem!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = pokename.capitalized
        tableView.separatorColor = .clear


        // Do any additional setup after loading the view.

        
        //make API calls
        fetchPokemonSpecies(self.pokemonSpeciesEndpointURL, successCallBack: {response in
            guard let response = response else {
                return
            }
            self.pokemonSpecies = response
            //print(self.pokemonSpecies)
            print()
            self.tableView.reloadData()

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
            self.view.backgroundColor = colorDict[self.pokemon!.types[0]]?.adjust(by: -30)
            self.tableView.backgroundColor = colorDict[self.pokemon!.types[0]]?.adjust(by: -30)
            self.tableView.reloadData()
            
        }, errorCallBack: {error in
            guard let error = error else {
                return
            }
            print(error)
        })
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
    }
    @IBAction func moveSetPressed(_ sender: Any) {
        performSegue(withIdentifier: "toMoves", sender: self)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let pkmn = pokemon else {
            let cell = (tableView.dequeueReusableCell(withIdentifier: "MainDetailCell", for: indexPath) as? MainDetailCell)!

            //perhaps creaete a buffer one here
            return cell
        }
        guard let pkmnSpecies = pokemonSpecies else {
            //perhaps creaete a buffer one here
            let cell = (tableView.dequeueReusableCell(withIdentifier: "MainDetailCell", for: indexPath) as? MainDetailCell)!

            //perhaps creaete a buffer one here
            return cell
        }
        switch indexPath.row{
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "MainDetailCell", for: indexPath) as? MainDetailCell

            //setting MainDetailCell outlets
            cell?.dexNumber.text = styleDexNumber(num: pokemon!.id)
            if let imageURL = URL(string: pokemon!.sprite) {
                downloadTask = cell!.pokeImage.loadImage(url: imageURL)
            }
            let dexEntries = pokemonSpecies.dexEntries.filter{$0.language == "en"}
            cell?.dexText.text = dexEntries[0].text.replacingOccurrences(of: "\\s", with: " ", options: .regularExpression)
            //cell?.dexText.sha

            let typey1 = pokemon?.types[0].rawValue
            cell?.type1.image = UIImage(named: typey1!)
            cell?.type1.layer.cornerRadius = 5

            if pokemon?.types.count == 1 {
                cell?.type2.removeFromSuperview()
//                cell?.typeStackView.con
            }
            if pokemon?.types.count == 2 {
                let type2 = pokemon?.types[1].rawValue
                cell?.type2.image = UIImage(named: type2!)
                cell?.type2.layer.cornerRadius = 5

            }
            
            cell?.sizeView.weight.tintColor = colorDict[self.pokemon!.types[0]]?.adjust(by: 0)
            cell?.sizeView.ruler.tintColor = colorDict[self.pokemon!.types[0]]?.adjust(by: 0)
//            let type2 = pokemon?.types[0].rawValue
            cell?.contentView.backgroundColor = colorDict[self.pokemon!.types[0]]?.adjust(by: -30)
            
            
            
            return cell!
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "StatsCell", for: indexPath) as? StatsCell
            
            cell?.abilitiesView.ability1Label.text = pokemon?.abilities[0].capitalized
            if (pkmn.abilities.count) > 1 {
                cell?.abilitiesView.ability2Lbael.text = pkmn.abilities[1].replacingOccurrences(of: "-", with: " ").capitalized
            }
                        
            //statbar setup
            print(pkmn.stats)
            
            for i in 0..<statOrder.count{
//                cell?.statBars[i].statNameLabel.text = statOrder[i] //HP
//                cell?.statBars[i].statAmountLabel.text = String(amount!)
                let nameLookup = StatLookup[statOrder[i]]! //hp

                let amount = (pkmn.stats[nameLookup])!
                cell?.statBars[i].configureInfo(stat: statOrder[i], amount: amount, type: pkmn.types.first!)
            }
            
//            cell?.sizeView.heightLabel.text = String(pkmn.height)
//            cell?.sizeView.weightLabel.text = String(pkmn.weight)
//            cell?.sizeView.weight.tintColor = colorDict[pkmn.types[0]]
//            cell?.sizeView.ruler.tintColor = colorDict[pkmn.types[0]]

            
            return cell!
            
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "BreedingCell", for: indexPath) as? BreedingCell
            let femaleAmount = Double(pkmnSpecies.genderRate)/8*100
            cell?.genderView.femaleAmount.text = String("\(femaleAmount)%")
            //print(Double(pkmnSpecies.genderRate/8))
//            cell?.genderView.maleAmount.text =
            cell?.genderView.maleAmount.text = String("\(100-femaleAmount)%")
            
            cell?.genderView.progressView.progress = Float(femaleAmount/100)
            return cell!
        }

    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        if indexPath.row == 0 {
//        } else {
//            cell.contentView.layer.masksToBounds = false
//        }
        cell.contentView.layer.masksToBounds = true

        
    }
    
    
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let destination = segue.destination as? MoveSetVC else {return}
        print(pokemon!.machineMoves)
        destination.machineMoves = pokemon!.machineMoves
        destination.tutorMoves = pokemon!.tutorMoves
        destination.levelUpMoves = pokemon!.levelUpMoves
        
    }

}
