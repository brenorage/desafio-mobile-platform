//
//  UIView+Extension.swift
//  desafio
//
//  Created by Fernando Luiz Goulart on 15/04/21.
//

import UIKit

public extension UIView {
    func addRoundedCorners(withColor color: UIColor = UIColor.clear, width: CGFloat, radius : CGFloat) {
        self.layer.cornerRadius = radius
        self.layer.borderWidth = width
        self.layer.masksToBounds = true
        self.layer.borderColor = color.cgColor
    }
}
