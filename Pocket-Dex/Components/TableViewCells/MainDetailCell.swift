//
//  MainDetailCell.swift
//  Pocket-Dex
//
//  Created by Emira Shano on 6/27/22.
//

import UIKit

class MainDetailCell: UITableViewCell {

    @IBOutlet weak var pokeImage: UIImageView!
    
    @IBOutlet weak var type2: UIImageView!
    @IBOutlet weak var type1: UIImageView!
    @IBOutlet weak var dexNumber: UILabel!
    @IBOutlet weak var dexText: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
