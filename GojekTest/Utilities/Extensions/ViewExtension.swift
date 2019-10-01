//
//  ViewExtension.swift
//  GojekTest
//
//  Created by Sourav on 29/09/19.
//  Copyright © 2019 matic. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func getViewController() -> UIViewController? {
        if let nextResponder = self.next as? UIViewController {
            return nextResponder
        } else if let nextResponder = self.next as? UIView {
            return nextResponder.getViewController()
        } else {
            return nil
        }
    }
    
    func applyGradient(colours: [UIColor], startPoint:CGPoint, endPoint:CGPoint) -> Void {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = colours.map { $0.cgColor }
        gradient.startPoint = startPoint
        gradient.endPoint = endPoint
        gradient.name = "green"
        gradient.removeFromSuperlayer()
        self.layer.insertSublayer(gradient, at: 0)
    }
}
