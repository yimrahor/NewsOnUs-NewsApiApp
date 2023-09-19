//
//  UIView&Extension.swift
//  NewsOnUs!
//
//  Created by Yaşar Ebru İmrahor on 5.09.2023.
//

import UIKit

extension UIView{
    @IBInspectable var cornerRadius: CGFloat{
        get { return self.cornerRadius }
        set {
            self.layer.cornerRadius = newValue
        }
    }
}
