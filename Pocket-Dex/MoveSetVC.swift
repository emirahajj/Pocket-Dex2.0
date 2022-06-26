//
//  MoveSetVC.swift
//  Pocket-Dex
//
//  Created by Emira Shano on 6/25/22.
//

import UIKit

class MoveSetVC: UIViewController {
    
    var levelUpMoves: [LevelUpMove]!
    var machineMoves: [MachineMove]!
    var tutorMoves: [TutorMove]!
    var pokemon: Pokemon!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(levelUpMoves.filter({$0.versionGroup == "red-blue"}))
//        print(pokemon)

        // Do any additional setup after loading the view.
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
