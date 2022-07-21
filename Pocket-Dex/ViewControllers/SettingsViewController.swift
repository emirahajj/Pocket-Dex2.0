//
//  SettingsViewController.swift
//  Pocket-Dex
//
//  Created by Emira Shano on 7/20/22.
//

import UIKit

class SettingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    let versionCases = GameVersion.allCases
    let currentVersion = UserDefaults.standard.string(forKey: "versionGroup")!
    
    @IBOutlet weak var versionImage: UIImageView!
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return versionCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VersionCell", for: indexPath) as? VersionCell
        cell?.versionLabel.text = versionCases[indexPath.row].rawValue.capitalized
//        if versionCases[indexPath.row].rawValue == UserDefaults.standard.string(forKey: "versionGroup"){
//            cell?.backgroundColor = .red
//        }
//        print(versionCases[indexPath.row].rawValue)
        return cell!
    }
    
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(currentVersion)
        let num = versionMascots[GameVersion(rawValue: currentVersion)!]!
        if let imageURL = URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(num).png") {
            downloadTask = versionImage.loadImage(url: imageURL)
        }
        tableView.delegate = self
        tableView.dataSource = self
        
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as? VersionCell
        //print(cell?.versionLabel.text)
        UserDefaults.standard.set(cell?.versionLabel.text?.lowercased(), forKey: "versionGroup")
        print(UserDefaults.standard.string(forKey: "versionGroup"))
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
