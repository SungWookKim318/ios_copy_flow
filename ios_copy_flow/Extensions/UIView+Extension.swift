//
//  UIView+Extension.swift
//  ios_copy_flow
//
//  Created by 김성욱 on 2021/07/26.
//

import Foundation
import UIKit

extension UIView {
    @discardableResult
    func setBorder(width: CGFloat) -> UIView {
        layer.borderWidth = width
        layer.masksToBounds = true
        return self
    }

    @discardableResult
    func setBorder(_ color: UIColor) -> UIView {
        layer.borderColor = color.cgColor
        layer.masksToBounds = true
        return self
    }

    @discardableResult
    func setBorder(width: CGFloat, color: UIColor) -> UIView {
        layer.borderWidth = width
        layer.borderColor = color.cgColor
        layer.masksToBounds = true
        return self
    }

    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        clipsToBounds = true
        layer.cornerRadius = radius
        if #available(iOS 11.0, *) {
            layer.maskedCorners = CACornerMask(rawValue: corners.rawValue)
        } else {
            // Fallback on earlier versions
            let path = UIBezierPath(roundedRect: bounds,
                                    byRoundingCorners: corners,
                                    cornerRadii: CGSize(width: radius, height: radius))

            let maskLayer = CAShapeLayer()
            maskLayer.frame = bounds
            maskLayer.path = path.cgPath

            layer.mask = maskLayer
        }
    }

    func setDebugOutline(_ width: CGFloat, _ color: UIColor) {
        #if DEBUG
            layer.borderWidth = width
            layer.borderColor = color.cgColor
        #endif
    }
}
