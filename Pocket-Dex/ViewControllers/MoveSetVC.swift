//
//  MoveSetVC.swift
//  Pocket-Dex
//
//  Created by Emira Shano on 6/25/22.
//

import UIKit


class MoveSetVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            return levelUpMoves.count
        case 1:
            return machineMoves.count
        default:
            return tutorMoves.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            let levelUpCell = tableView.dequeueReusableCell(withIdentifier: "MoveCell", for: indexPath) as? MoveCell
            levelUpCell?.levelLabel.text = "Lv. \(levelUpMoves[indexPath.row].levelLearned)"
            levelUpCell?.nameLabel.text = levelUpMoves[indexPath.row].name.replacingOccurrences(of: "-", with: " ").capitalized
            return levelUpCell!
        case 1:
            let machineTutorCell = tableView.dequeueReusableCell(withIdentifier: "MachineTutorCell", for: indexPath) as? MachineTutorCell
            machineTutorCell?.moveLabel.text = machineMoves[indexPath.row].name
            return machineTutorCell!
        default:
            let machineTutorCell = tableView.dequeueReusableCell(withIdentifier: "MachineTutorCell", for: indexPath) as? MachineTutorCell
            machineTutorCell?.moveLabel.text = tutorMoves[indexPath.row].name
            return machineTutorCell!
        }
        
       
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
        print(machineMoves)
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
            moveTableView.reloadData()
            return
        case 1:
            //machine
            print("machine")
            moveTableView.reloadData()
            return
        default:
            //tutor
            print("tutor")
            moveTableView.reloadData()
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
