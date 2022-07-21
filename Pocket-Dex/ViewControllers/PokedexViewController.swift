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

extension UserDefaults {
    static func exists(key: String) -> Bool {
        return UserDefaults.standard.object(forKey: key) != nil
    }

}

//CELL IMAGES https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/800.png


class PokedexViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    var dictionary = [[String:Any]]()
    var isMenuActive = false
    var defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        if !UserDefaults.exists(key: "versionGroup"){
            defaults.set("red", forKey: "versionGroup")
        } else {
            defaults.set("red", forKey: "versionGroup")
        }
//        self.navigationController?.navigationBar.scrollEdgeAppearance?.backgroundColor = .clear
//        self.navigationController?.navigationBar.standardAppearance.backgroundColor = .clear
//        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
//        UINavigationBar.appearance().shadowImage = UIImage()
//        UINavigationBar.appearance().isTranslucent = true
//        self.tabBarController?.tabBar.itemPositioning = .centered
//
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
        performSegue(withIdentifier: "toNewDetail", sender: tableView.cellForRow(at:indexPath))
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let sender = sender as? UIBarButtonItem {
            let destination = segue.destination as? SettingsViewController
//            print(destination)
//            destination?.versionGroupie = defaults.object(forKey: "versionGroup") as! String
        }
        if let sender = sender as? PokeCell{
            let destination = segue.destination as? PokeDetailVC
            destination?.pokename = sender.pokemonName.text!.lowercased()

        }
        

        //print(sender.pokemonName.text!)
    }
    
    @IBAction func showsFilter(_ sender: Any) {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut) {
            let screenWidth: Double = (self.tabBarController?.view.frame.width)! * 0.5
            let offset: Double = self.isMenuActive ? -screenWidth : screenWidth
            self.tabBarController?.view.frame.origin.x += offset
            
        } completion: { (finished) in
            self.isMenuActive = !self.isMenuActive
        }
    }

    
    
    
}

