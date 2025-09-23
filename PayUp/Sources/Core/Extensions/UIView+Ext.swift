//
//  UIView+Ext.swift
//  PayUp
//
//  Created by Arthur Rios on 23/04/25.
//

import Foundation
import UIKit

extension UIView {
    func animateMoveOut(to point: CGPoint, duration: TimeInterval) {
        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseInOut) {
            self.center = point
            self.alpha = 0
        }
    }
    
    func parentViewController() -> UIViewController? {
        var responder: UIResponder? = self
        while let r = responder {
            if let vc = r as? UIViewController {
                return vc
            }
            responder = r.next
        }
        return nil
    }
}
