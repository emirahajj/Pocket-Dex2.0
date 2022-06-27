//
//  AbilitiesView.swift
//  Pocket-Dex
//
//  Created by Emira Hajj on 6/23/22.
//

import UIKit

@IBDesignable class AbilitiesView: UIView {

    @IBOutlet weak var ability2Lbael: UILabel!
    @IBOutlet weak var ability1Label: UILabel!
    @IBOutlet var contentView: UIView!
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    //initializer for code
    override init(frame: CGRect) {
        super.init(frame: frame)
        customInit()
    }
    //storyboard initializer
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        customInit()
    }
    
    func customInit() {
        contentView = loadViewFromNib(nibName: "AbilitiesView")
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        contentView.layer.backgroundColor = UIColor.black.cgColor
        layer.cornerRadius = 7
        layer.shadowOpacity = 1.0
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 2, height: 2)
        layer.masksToBounds = true
        contentView.frame = self.bounds
        addSubview(contentView)
    }
    
    func loadViewFromNib(nibName: String) -> UIView{
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        return view
    }


}
