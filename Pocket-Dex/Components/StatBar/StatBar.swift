//
//  StatBar.swift
//  Pocket-Dex
//
//  Created by Emira Shano on 6/25/22.
//

import UIKit

@IBDesignable class StatBar: UIView {

    @IBOutlet var contentView: UIView!
    
    static let identifier = "StatBar"

    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var statNameLabel: UILabel!
    @IBOutlet weak var statAmountLabel: UILabel!
    
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
        contentView = loadViewFromNib(nibName: "StatBar")
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

    
    func configureInfo(stat: String, amount: Int, type: PokeType){
        statAmountLabel.text = String(amount)
        statNameLabel.text = stat
        statNameLabel.textColor = .white
        statAmountLabel.textColor = .white
        contentView.layer.backgroundColor = colorDict[type]?.adjust(by: -20)?.cgColor

        self.statAmountLabel.font = UIFont.boldSystemFont(ofSize: 17)
        self.statNameLabel.layer.opacity = 0.9
        self.stackView.spacing = CGFloat(amount/2)

    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
