//
//  BreedingCell.swift
//  Pocket-Dex
//
//  Created by Emira Shano on 6/27/22.
//

import UIKit

class BreedingCell: UITableViewCell {

    @IBOutlet weak var genderView: GenderRatioView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
