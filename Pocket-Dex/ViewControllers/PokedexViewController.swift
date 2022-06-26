//
//  ViewController.swift
//  Pocket-Dex
//
//  Created by Emira Hajj on 4/21/22.
//

import UIKit

var downloadTask: URLSessionDownloadTask?


class PokeCell: UITableViewCell {
    
    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var pokemonName: UILabel!
    @IBOutlet weak var cellLabel: UILabel!
}

//CELL IMAGES https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/800.png


class PokedexViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    var dictionary = [[String:Any]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        self.navigationController?.navigationBar.scrollEdgeAppearance?.backgroundColor = .clear
        self.navigationController?.navigationBar.standardAppearance.backgroundColor = .clear
//        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
//        UINavigationBar.appearance().shadowImage = UIImage()
//        UINavigationBar.appearance().isTranslucent = true
//        self.tabBarController?.tabBar.itemPositioning = .centered
        
//        //ios 13 and after
//        let appearance = UINavigationBarAppearance()
//        appearance.configureWithTransparentBackground()
//        UINavigationBar.appearance().standardAppearance = appearance
//        UINavigationBar.appearance().scrollEdgeAppearance = appearance

        
        let url = URL(string: "https://pokeapi.co/api/v2/pokedex/1/")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 30)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task: URLSessionDataTask = session.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            if let error = error {
                print(error)
            } else if let data = data,
                      let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary {
                let pokemonList = dataDictionary["pokemon_entries"] as! [[String: Any]]
                self.dictionary = pokemonList
                //                        print(pokemonList)
                self.tableView.reloadData()
            }
        }
        task.resume()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dictionary.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokeCell", for: indexPath) as? PokeCell
        cell?.cellLabel.text = String(indexPath.row + 1)
        let pokemonInCell = dictionary[indexPath.row]["pokemon_species"] as! [String: String]
        let pokemonName = pokemonInCell["name"] as? String
        
        if let imageURL = URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(indexPath.row + 1).png") {
            cell?.cellImage.backgroundColor = .clear
            cell?.cellImage.layer.shadowColor = UIColor.black.cgColor
            cell?.cellImage.layer.shadowOpacity = 0.4
            cell?.cellImage.layer.shadowOffset = CGSize.zero
            cell?.cellImage.layer.shadowRadius = 2

            downloadTask = cell?.cellImage.loadImage(url: imageURL)
            
        }
        
        cell?.pokemonName.text = pokemonName?.capitalized        
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        performSegue(withIdentifier: "toPokeDetail", sender: tableView.cellForRow(at:indexPath))
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? PokemonDetailViewController else {return}
        print("dsd")
        guard let sender = sender as? PokeCell else {return}
        

        print(sender.pokemonName.text!)
        destination.pokename = sender.pokemonName.text!.lowercased()
    }
    
    
    
}

