//
//  BaseViewController.swift
//  ios_copy_flow
//
//  Created by 김성욱 on 2021/07/10.
//

import Foundation
import UIKit

class BaseViewController: UIViewController {
    // Darkmode 변경 대응
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if #available(iOS 12.0, *) {
            ColorManager.share.isDarkMode = previousTraitCollection?.userInterfaceStyle != .dark
        } else {
            ColorManager.share.isDarkMode = false
        }
    }

    var statusBarHeight: CGFloat {
        if #available(iOS 13.0, *) {
            let window = UIApplication.shared.windows.filter { $0.isKeyWindow }.first
            return window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        } else {
            return UIApplication.shared.statusBarFrame.height
        }
    }
}
