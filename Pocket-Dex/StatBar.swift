//
//  StatBar.swift
//  Pocket-Dex
//
//  Created by Emira Shano on 6/25/22.
//

import UIKit

class StatBar: UIView {

    @IBOutlet var contentView: UIView!
    
    static let identifier = "StatBar"

    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initSubviews()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initSubviews()
    }
    
    func initSubviews() {

        let nib = UINib(nibName: TypeButtonView.identifier, bundle: nil)

            guard let view = nib.instantiate(withOwner: self, options: nil).first as?
                                UIView else {fatalError("Unable to convert nib")}

            view.frame = bounds
            view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            //set background styling etc.
        
            

            addSubview(view)

        }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
