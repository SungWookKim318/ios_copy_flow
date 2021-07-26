//
//  AudioControllerView.swift
//  ios_copy_flow
//
//  Created by 김성욱 on 2021/07/26.
//

import Foundation
import UIKit
class AudioControllerView: CustomLayoutView {
    // MARK: Lifecycle

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    // MARK: Internal

    let stackView = UIStackView()
    let repeatButton = createButton()
    let previousButton = createButton(imageNamed: "backward")
    let playButton = createButton(imageNamed: "play")
    let nextButton = createButton(imageNamed: "forward")
    let randomButton = createButton()

    override internal func setupSubview() {
        stackView.setDebugOutline(1.0, .purple)
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.axis = .horizontal
        stackView.spacing = 10.0
        self.addSubview(stackView)

        if let pauseImage = UIImage(named: "pause") {
            playButton.setImage(pauseImage, for: .selected)
        } else { Log.crushOrError("play highlighenImage(pause) is not exist") }
        stackView.addArrangedSubview(repeatButton)
        stackView.addArrangedSubview(previousButton)
        stackView.addArrangedSubview(playButton)
        stackView.addArrangedSubview(nextButton)
        stackView.addArrangedSubview(randomButton)
    }

    override internal func setupAutoLayout() {
        let gap: CGFloat = 10.0
        stackView.snp.makeConstraints { view in
            view.center.equalToSuperview()
            view.height.equalToSuperview().offset(-gap * 2)
            view.width.equalToSuperview().offset(-gap * 4)
        }
        repeatButton.snp.makeConstraints { view in
            view.width.height.equalTo(stackView.snp.height).multipliedBy(0.8)
        }
        previousButton.snp.makeConstraints { view in
            view.width.height.equalTo(stackView.snp.height).multipliedBy(0.9)
        }
        playButton.snp.makeConstraints { view in
            view.width.height.equalTo(stackView.snp.height)
        }
        nextButton.snp.makeConstraints { view in
            view.width.height.equalTo(stackView.snp.height).multipliedBy(0.9)
        }
        randomButton.snp.makeConstraints { view in
            view.width.height.equalTo(stackView.snp.height).multipliedBy(0.8)
        }
    }

    override internal func setupRXs() {}

    // MARK: Private

    private static func createButton(imageNamed: String? = nil) -> UIButton {
        let button = UIButton()
        if let named = imageNamed {
            guard let normalImage = UIImage(named: named) else { fatalError() }
            button.setImage(normalImage, for: .normal)
            if let hightlightenImage = UIImage(named: "\(named)_fill") {
                button.setImage(hightlightenImage, for: .highlighted)
            }
            button.contentMode = .scaleAspectFit
            button.clipsToBounds = true
            button.layer.masksToBounds = true
            button.imageView?.snp.makeConstraints { imageView in
                imageView.center.size.equalToSuperview()
            }
        } else {
            button.backgroundColor = .purple
        }
        
        button.setDebugOutline(1.0, .orange)
        return button
    }
}
