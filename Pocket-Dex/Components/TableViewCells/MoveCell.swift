//
//  MoveCellTableViewCell.swift
//  Pocket-Dex
//
//  Created by Emira Shano on 6/26/22.
//

import UIKit

class MoveCell: UITableViewCell {

    @IBOutlet weak var levelLabel: UILabel!
    
    @IBOutlet weak var nameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
