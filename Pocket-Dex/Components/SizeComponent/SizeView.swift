//
//  SizeView.swift
//  Pocket-Dex
//
//  Created by Emira Shano on 6/27/22.
//

import UIKit

@IBDesignable class SizeView: UIView {

    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    
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
    
    func customInit(){
        contentView = loadViewFromNib(nibName: "SizeView")
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        contentView.layer.backgroundColor = UIColor.clear.cgColor

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
