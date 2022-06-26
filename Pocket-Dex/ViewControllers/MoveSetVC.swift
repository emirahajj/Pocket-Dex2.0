//
//  MoveSetVC.swift
//  Pocket-Dex
//
//  Created by Emira Shano on 6/25/22.
//

import UIKit


class MoveSetVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return levelUpMoves.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MoveCell", for: indexPath) as? MoveCell
        cell?.levelLabel.text = "Lv. \(levelUpMoves[indexPath.row].levelLearned)"
        cell?.nameLabel.text = levelUpMoves[indexPath.row].name.replacingOccurrences(of: "-", with: " ").capitalized
        return cell!
    }
    
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    
    var levelUpMoves: [LevelUpMove]!
    var filteredLevel: [LevelUpMove]!
    var machineMoves: [MachineMove]!
    var filteredMachine: [MachineMove]!
    var tutorMoves: [TutorMove]!
    var filteredTutor: [TutorMove]!
    var pokemon: Pokemon!
    @IBOutlet weak var moveTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(levelUpMoves)
        filteredLevel = levelUpMoves.filter({$0.versionGroup == "red-blue"}).sorted(by: {$0.levelLearned < $1.levelLearned})
        //print(levelUpMoves.filter({$0.versionGroup == "red-blue"}))
//        print(pokemon)
        moveTableView.delegate = self
        moveTableView.dataSource = self
        moveTableView.reloadData()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func changeMoves(_ sender: Any) {
        guard let sender = sender as? UISegmentedControl else { return}
        switch (sender.selectedSegmentIndex){
        case 0:
            //level up
            print("level up")
            return
        case 1:
            //machine
            print("machine")
            return
        default:
            //tutor
            print("tutor")
            return
        }
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
