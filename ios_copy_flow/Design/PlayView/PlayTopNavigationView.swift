//
//  PlayTopNavigationView.swift
//  ios_copy_flow
//
//  Created by 김성욱 on 2021/07/10.
//

import Foundation
import RxGesture
import RxSwift
import UIKit

class PlayTopNavigationView: CustomLayoutView {
    let setupButton = UIButton()
    let eqButton = UIButton()
    let moreButton = UIButton()
    
    override internal func setupSubview() {}

    override internal func setupAutoLayout() {}

    override internal func setupRXs() {}
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
