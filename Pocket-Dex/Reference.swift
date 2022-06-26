//
//  PokeType.swift
//  Pocket-Dex
//
//  Created by Emira Shano on 6/18/22.
//

import Foundation
import UIKit

enum PokeType: String {
    case normal, fire, water, grass, electric, ice, poison, ground, flying, psychic, bug, rock, ghost, dark, dragon, steel, fairy, fighting
}

enum GameVersion {
    case red, blue, yellow, gold, silver, crystal, ruby, sapphire, emerald, heartgold, soulsilver, diamond, pearl, platinum, black, white, black2, white2, x, y, omegaruby, alphasapphire, sun, moon, ultrasun, ultramoon
}
enum VersionGroup: String{
    case redBlue = "red-blue"
    case yellow
    case goldSilver = "gold-silver"
}

extension UIImageView {
    
    func loadImage(url: URL) -> URLSessionDownloadTask {
        let session = URLSession.shared
        let downloadTask = session.downloadTask(with: url) {
            [weak self] url, _, error in
            if error == nil, let url = url, let data = try? Data(contentsOf: url), // 3
               let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        if let weakSelf = self {
                            weakSelf.image = image
                        }
                    }
                }
            }
            downloadTask.resume()
            return downloadTask
    }
}


let colorDict: [PokeType: UIColor] = [
    .normal: .normal,
    .fire: .fire,
    .water: .water,
    .grass: .grass,
    .electric: .electric,
    .ice: .ice,
    .fighting: .fighting,
    .poison: .poison,
    .ground: .ground,
    .flying: .flying,
    .psychic: .psychic,
    .bug: .bug,
    .rock: .rock,
    .ghost: .ghost,
    .dark: .dark,
    .dragon: .dragon,
    .steel: .steel,
    .fairy: .fairy,
    
]

func styleDexNumber(num: Int) -> String {
    switch num {
    case 0..<10:
        return "#00\(num)"
    case 10..<100:
        return "#0\(num)"
    default:
        return "#\(num)"
    }
}

extension UIColor {
    static var normal: UIColor {return UIColor(red: 160/255, green: 158/255, blue: 113/255, alpha: 1.0)}
    static var fire: UIColor {return UIColor(red: 251/255, green: 117/255, blue: 52/255, alpha: 1.0)}
    static var water: UIColor {return UIColor(red: 79/255, green: 134/255, blue: 233/255, alpha: 1.0)}
    static var grass: UIColor {return UIColor(red: 99/255, green: 191/255, blue: 82/255, alpha: 1.0)}
    static var electric: UIColor {return UIColor(red: 255/255, green: 201/255, blue: 66/255, alpha: 1.0)}
    static var ice: UIColor {return UIColor(red: 129/255, green: 201/255, blue: 210/255, alpha: 1.0)}
    static var fighting: UIColor {return UIColor(red: 195/255, green: 43/255, blue: 38/255, alpha: 1.0)}
    static var poison: UIColor {return UIColor(red: 155/255, green: 58/255, blue: 146/255, alpha: 1.0)}
    static var ground: UIColor {return UIColor(red: 226/255, green: 183/255, blue: 102/255, alpha: 1.0)}
    static var flying: UIColor {return UIColor(red: 157/255, green: 135/255, blue: 233/255, alpha: 1.0)}
    static var psychic: UIColor {return UIColor(red: 255/255, green: 78/255, blue: 124/255, alpha: 1.0)}
    static var bug: UIColor {return UIColor(red: 158/255, green: 174/255, blue: 52/255, alpha: 1.0)}
    static var rock: UIColor {return UIColor(red: 179/255, green: 149/255, blue: 60/255, alpha: 1.0)}
    static var ghost: UIColor {return UIColor(red: 100/255, green: 80/255, blue: 138/255, alpha: 1.0)}
    static var dark: UIColor {return UIColor(red: 104/255, green: 78/255, blue: 64/255, alpha: 1.0)}
    static var dragon: UIColor {return UIColor(red: 95/255, green: 56/255, blue: 240/255, alpha: 1.0)}
    static var steel: UIColor {return UIColor(red: 175/255, green: 175/255, blue: 200/255, alpha: 1.0)}
    static var fairy: UIColor {return UIColor(red: 244/255, green: 173/255, blue: 180/255, alpha: 1.0)}
    func lighter(by percentage: CGFloat = 30.0) -> UIColor? {
        return self.adjust(by: abs(percentage) )
    }

    func darker(by percentage: CGFloat = 30.0) -> UIColor? {
        return self.adjust(by: -1 * abs(percentage) )
    }

    func adjust(by percentage: CGFloat = 30.0) -> UIColor? {
        var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, alpha: CGFloat = 0
        if self.getRed(&red, green: &green, blue: &blue, alpha: &alpha) {
            return UIColor(red: min(red + percentage/100, 1.0),
                           green: min(green + percentage/100, 1.0),
                           blue: min(blue + percentage/100, 1.0),
                           alpha: alpha)
        } else {
            return nil
        }
    }
}

var StatLookup = [
    "HP": "hp",
    "ATK" : "attack",
    "DEF": "defense",
    "S.ATK":"special-attack" ,
    "S.DEF":"special-defense" ,
    "SP":"speed",
]
var statOrder = ["hp", "attack", "defense", "special-attack", "special-defense", "speed"]

extension UIView {
func addBottomShadow() {
    layer.masksToBounds = false
    layer.shadowRadius = 4
    layer.shadowOpacity = 1
    layer.cornerRadius = 20;
    layer.shadowColor = UIColor.black.cgColor
    layer.shadowOffset = CGSize(width: 0 , height: 2)
    layer.shadowPath = UIBezierPath(rect: CGRect(x: 0,
                                                 y: bounds.maxY - layer.shadowRadius,
                                                 width: bounds.width,
                                                 height: layer.shadowRadius)).cgPath
}
}
