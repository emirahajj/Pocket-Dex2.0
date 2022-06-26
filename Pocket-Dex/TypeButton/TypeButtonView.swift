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
    static let identifier = "TypeButtonView"

    
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
        view.backgroundColor = .clear
        view.layer.masksToBounds = true

        //set background styling etc.
        
            
            addSubview(view)

        }
    
    func configureImageAndText(type : PokeType){
        typeName.text = type.rawValue.uppercased()
        contentView.layer.masksToBounds = true
        contentView.backgroundColor = colorDict[type]
        contentView.tintColor = .white
        contentView.layer.cornerRadius = 12
        //contentView.layer.borderWidth = 1
        //contentView.layer.borderColor = UIColor.white.cgColor
        
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    

}
