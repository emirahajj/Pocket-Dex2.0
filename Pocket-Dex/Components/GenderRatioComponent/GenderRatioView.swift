//
//  GenderRatioView.swift
//  Pocket-Dex
//
//  Created by Emira Shano on 6/27/22.
//

import UIKit

@IBDesignable class GenderRatioView: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var femaleAmount: UILabel!
    @IBOutlet weak var maleAmount: UILabel!
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    //initializer for creating component programmatically
    override init(frame: CGRect) {
        super.init(frame: frame)
        customInit()
    }
    //initializer for creating component in the IB
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        customInit()
    }
    
    func customInit() {
        contentView = loadViewFromNib(nibName: "GenderRatioView")
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
