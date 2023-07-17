//
//  Constants.swift
//  Practic15
//
//  Created by Даниил Циркунов on 27.02.2023.
//

import UIKit

enum Constants {
    enum Colors {
        static var gray01: UIColor? {
            #colorLiteral(red: 0.9719485641, green: 0.9719484448, blue: 0.9719484448, alpha: 0.8470588235)
        }
        static var gray03: UIColor? {
            #colorLiteral(red: 0.787740171, green: 0.787740171, blue: 0.787740171, alpha: 0.8470588235)
        }
    }
    
    enum Fonts {
        static var ui16Semi: UIFont? {
            UIFont.systemFont(ofSize: 16, weight: .semibold)
        }
        static var ui14Regular: UIFont? {
            UIFont.systemFont(ofSize: 14, weight: .regular)
        }
    }
}
