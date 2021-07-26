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
    // MARK: Lifecycle

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    // MARK: Internal

    let setupButton = UIButton()
    let eqButton = UIButton()
    let moreButton = UIButton()

    override internal func setupSubview() {
        setupButton.backgroundColor = .systemBlue
        self.addSubview(setupButton)
        eqButton.backgroundColor = .systemGreen
        self.addSubview(eqButton)
        moreButton.setImage(UIImage(named: "downarrow"), for: .normal)
        self.addSubview(moreButton)
    }

    override internal func setupAutoLayout() {
        let gapOfButton: CGFloat = 10
        setupButton.snp.makeConstraints { view in
            view.centerY.equalToSuperview()
            view.height.equalToSuperview().offset(-gapOfButton)
            view.left.equalToSuperview().offset(gapOfButton)
            view.width.equalTo(setupButton.snp.height)
        }
        eqButton.snp.makeConstraints { view in
            view.centerY.equalToSuperview()
            view.height.equalToSuperview().offset(-gapOfButton)
            view.left.equalTo(setupButton.snp.right).offset(gapOfButton)
            view.width.equalTo(eqButton.snp.height)
        }
        moreButton.snp.makeConstraints { view in
            view.centerY.equalToSuperview()
            view.height.equalToSuperview().offset(-gapOfButton)
            view.right.equalToSuperview().offset(-gapOfButton)
            view.width.equalTo(moreButton.snp.height)
        }
        moreButton.imageView?.snp.makeConstraints { imageView in
            imageView.center.equalToSuperview()
            imageView.size.equalToSuperview().offset(-gapOfButton)
        }
    }

    override internal func setupRXs() {}

}
