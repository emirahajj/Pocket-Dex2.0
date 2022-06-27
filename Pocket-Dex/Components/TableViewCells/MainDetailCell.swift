//
//  MainDetailCell.swift
//  Pocket-Dex
//
//  Created by Emira Shano on 6/27/22.
//

import UIKit

class MainDetailCell: UITableViewCell {

    @IBOutlet weak var pokeImage: UIImageView!
    
    @IBOutlet weak var wrapperView: UIView! //shadow on this one
    //    @IBOutlet weak var type2: UIImageView!
//    @IBOutlet weak var type1: UIImageView!
    @IBOutlet weak var dexNumber: UILabel!
    @IBOutlet weak var dexText: UILabel!
    
//    @IBOutlet weak var pokeball: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        backgroundColor = .clear
        layer.masksToBounds = false
        layer.shadowOpacity = 0.6
        layer.shadowRadius = 4
        layer.shadowOffset = CGSize(width: 0, height: 8)
        layer.shadowColor = UIColor.black.cgColor
        
//        contentView.backgroundColor = .clear
        contentView.layer.cornerRadius = 30


    }

    override func setSelected(_ selected: Bool, animated: Bool) {
       // super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let margins = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
        contentView.frame = contentView.frame.inset(by: margins)
    }

}
