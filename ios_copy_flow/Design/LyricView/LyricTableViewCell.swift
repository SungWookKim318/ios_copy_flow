//
//  LyricTableViewCell.swift
//  ios_copy_flow
//
//  Created by 김성욱 on 2021/08/01.
//

import Foundation
import UIKit

// MARK: - LyricTableCell

class LyricTableCell: UITableViewCell {
    // MARK: Lifecycle

    // MARK: Object LifeCycle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    // MARK: Public

    public static let identifier = "LyricTableCell"

    // MARK: Internal

    let lyricLabel = UILabel()

    var lyric: LyricModel! {
        didSet {
            lyricLabel.text = lyric.text
        }
    }

//    override var isSelected: Bool {
//        willSet {
//            lyricLabel.isHighlighted = newValue
//            if newValue {
//                Log.info("Cell is selected")
//                lyricLabel.font = LyricTableCell.selectFont
////                lyricLabel.textColor = ColorManager.share.textDeep
////                lyricLabel.textColor = .systemBlue
////                lyricLabel.highlightedTextColor
////                lyricLabel.setNeedsDisplay()
//                self.setNeedsDisplay()
//            } else {
//                lyricLabel.font = LyricTableCell.unselectFont
////                lyricLabel.textColor = ColorManager.share.text
////                lyricLabel.textColor = .systemGray
//            }
//        }
//    }
    
    func updateLabel() {
        if self.isSelected {
            lyricLabel.font = LyricTableCell.selectFont
            lyricLabel.textColor = .systemBlue
        } else {
            lyricLabel.font = LyricTableCell.unselectFont
            lyricLabel.textColor = .systemGray
        }
    }
    

    // MARK: Private

    private static let unselectFont: UIFont = .systemFont(ofSize: 15)
    private static let selectFont: UIFont = .boldSystemFont(ofSize: 20)

    // MARK: Initializer

    private func setup() {
        self.setDebugOutline(1.0, .systemPink)
        lyricLabel.textColor = ColorManager.share.text
        lyricLabel.textAlignment = .center
        lyricLabel.lineBreakMode = .byClipping
        lyricLabel.numberOfLines = 0
        lyricLabel.textColor = .systemGray
        
        addSubview(lyricLabel)
        lyricLabel.snp.makeConstraints { view in
            view.center.width.equalToSuperview()
            view.height.equalToSuperview().offset(-10)
        }
        self.selectionStyle = .none
    }
}
