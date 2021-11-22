//
//  Cardview.swift
//  Helf Trainer
//
//  Created by Techeniac Services on 08/02/21.
//

import Foundation
import UIKit

 
// TODO: Custom ui componet cardview
class Cardview: UIView {
    var radius = 5
    @IBInspectable var cornerRadius2: CGFloat {
        get {
            return self.layer.cornerRadius
        }set {
            radius = Int(newValue)
            self.layer.cornerRadius = CGFloat(radius)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let shadowPath = UIBezierPath(rect: self.bounds)
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0.3, height: 0.6)
        layer.shadowOpacity = 0.2
        layer.shadowPath = shadowPath.cgPath
        layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.layer.cornerRadius).cgPath
        layer.cornerRadius = CGFloat(radius)
        
    }
}
extension UIView {
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}
