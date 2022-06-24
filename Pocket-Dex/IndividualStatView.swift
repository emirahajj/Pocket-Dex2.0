//
//  IndividualStatView.swift
//  Pocket-Dex
//
//  Created by Emira Shano on 6/21/22.
//

import UIKit

class IndividualStatView: UIStackView {

    @IBOutlet weak var leftLabel: UILabel!
    @IBOutlet weak var rightLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 10
        leftLabel.textColor = .white
        rightLabel.textColor = .white
        self.layer.shadowOpacity = 1.0
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 2, height: 2)
        self.rightLabel.font = UIFont.boldSystemFont(ofSize: 17)
        self.leftLabel.layer.opacity = 0.9

    }
    
    init(blah: String, stat: Int) {
        self.init()

    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
