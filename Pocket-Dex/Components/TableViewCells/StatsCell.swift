//
//  StatsCell.swift
//  Pocket-Dex
//
//  Created by Emira Shano on 6/27/22.
//

import UIKit

class StatsCell: UITableViewCell {

    @IBOutlet weak var sizeView: SizeView!
    @IBOutlet weak var abilitiesView: AbilitiesView!
    
    @IBOutlet var statBars: [StatBar]!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
