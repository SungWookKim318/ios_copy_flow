//
//  ColorManager.swift
//  ios_copy_flow
//
//  Created by 김성욱 on 2021/07/10.
//

import Foundation
import UIKit

class ColorManager {
    static let share = ColorManager()

    var isDarkMode: Bool = false {
        didSet {
            print("change Darkmode, darkmode is \(isDarkMode ? "ON" : "OFF")")
        }
    }

    var textDeep: UIColor {
        if isDarkMode {
            return DarkModeColors.textDeep
        }
        return WhiteModeColors.textDeep
    }

    var text: UIColor {
        if isDarkMode {
            return DarkModeColors.text
        }
        return WhiteModeColors.text
    }

    var textThin: UIColor {
        if isDarkMode {
            return DarkModeColors.textThin
        }
        return WhiteModeColors.textThin
    }
}

private enum DarkModeColors {
    static let textDeep = UIColor(white: 1.0, alpha: 1.0)
    static let text = UIColor(white: 0.75, alpha: 1.0)
    static let textThin = UIColor(white: 0.5, alpha: 1.0)
}

private enum WhiteModeColors {
    static let textDeep = UIColor(white: 0.0, alpha: 1.0)
    static let text = UIColor(white: 0.25, alpha: 1.0)
    static let textThin = UIColor(white: 0.5, alpha: 1.0)
}

// Images
extension ColorManager {
    var playImage: UIImage { return #imageLiteral(resourceName: "play") }
    var pauseImage: UIImage { return #imageLiteral(resourceName: "pause") }
    var forwardImage: UIImage { return #imageLiteral(resourceName: "forward") }
    var forwardFillImage: UIImage { return #imageLiteral(resourceName: "forward_fill") }
    var backwardImage: UIImage { return #imageLiteral(resourceName: "backward") }
    var backwardFillImage: UIImage { return #imageLiteral(resourceName: "backward_fill") }
    var moreImage: UIImage { return #imageLiteral(resourceName: "threedot") }
    var downArrowImage: UIImage { return #imageLiteral(resourceName: "downarrow") }
}
