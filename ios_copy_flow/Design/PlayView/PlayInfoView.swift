//
//  PlayInfoView.swift
//  ios_copy_flow
//
//  Created by 김성욱 on 2021/07/26.
//

import Foundation
import UIKit


class PlayInfoView: UIView {
    private let titleLabel = UILabel()
    private let singerLabel = UILabel()
    
    var alignmentText: NSTextAlignment = .center {
        didSet {
            titleLabel.textAlignment = alignmentText
            singerLabel.textAlignment = alignmentText
        }
    }
    var title: String {
        get { titleLabel.text ?? ""}
        set { titleLabel.text = newValue }
    }
    var singer: String {
        get { singerLabel.text ?? ""}
        set { singerLabel.text = newValue }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        setupComponent()
        setAutoLayout()
    }
    
    private func setupComponent() {
        titleLabel.setDebugOutline(1.0, .systemRed)
        singerLabel.setDebugOutline(1.0, .systemBlue)
        
        alignmentText = .center
        title = ""
        singer = ""
        
        self.addSubview(titleLabel)
        self.addSubview(singerLabel)
    }
    
    private func setAutoLayout() {
        titleLabel.snp.makeConstraints { view in
            view.left.top.right.equalToSuperview()
            view.bottom.equalTo(self.snp.centerY)
        }
        singerLabel.snp.makeConstraints { view in
            view.top.equalTo(titleLabel.snp.bottom).offset(5)
            view.left.right.bottom.equalToSuperview()
        }
    }
    
}
