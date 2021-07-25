//
//  CustomLayoutView.swift
//  ios_copy_flow
//
//  Created by 김성욱 on 2021/07/10.
//

import Foundation
import UIKit

class CustomLayoutView: UIView {
    internal func setupSubview() {}

    internal func setupAutoLayout() {}

    internal func setupRXs() {}
    
    internal func setup() {
        setupSubview()
        setupAutoLayout()
        setupRXs()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
}
