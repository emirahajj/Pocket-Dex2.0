//
//  TypeButtonView.swift
//  Pocket-Dex
//
//  Created by Emira Shano on 6/23/22.
//

import UIKit

class TypeButtonView: UIView {
    

    @IBOutlet weak var typeName: PaddingLabel!
    
    @IBOutlet var contentView: UIView!

    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        customInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        customInit()
    }
    
    func customInit() {
        contentView = loadViewFromNib(nibName: "TypeButtonView")
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        layer.backgroundColor = UIColor.red.cgColor
        layer.cornerRadius = 6
        layer.shadowOpacity = 1.0
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 2, height: 2)
        layer.masksToBounds = true
        contentView.frame = self.bounds
        addSubview(contentView)
        }
    
    func configureImageAndText(type : PokeType){
        typeName.text = type.rawValue.uppercased()
        layer.backgroundColor = colorDict[type]?.cgColor


        //contentView.layer.borderWidth = 1
        //contentView.layer.borderColor = UIColor.white.cgColor
        
    }
    
    func loadViewFromNib(nibName: String) -> UIView{
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        
        return view
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    

}
