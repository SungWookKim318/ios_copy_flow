//
//  lyricTableView.swift
//  ios_copy_flow
//
//  Created by 김성욱 on 2021/07/26.
//

import Foundation
import UIKit

// MARK: - LyricTableCell

class LyricTableCell: UITableViewCell {
    public static let identifier = "LyricTableCell"
    private static let unselectFont: UIFont = .systemFont(ofSize: 18)
    private static let selectFont = UIFont.boldSystemFont(ofSize: 20)
    let lyricLabel = UILabel()
    var lyric: LyricModel! {
        didSet {
            lyricLabel.text = lyric.text
        }
    }
    override var isSelected: Bool {
        didSet {
            if isSelected {
                lyricLabel.font = LyricTableCell.selectFont
                lyricLabel.textColor = ColorManager.share.textDeep
            } else {
                lyricLabel.font = LyricTableCell.unselectFont
                lyricLabel.textColor = ColorManager.share.text
            }
        }
    }
    // MARK: Object LifeCycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    // MARK: Initializer
    private func setup() {
        self.setDebugOutline(1.0, .systemPink)
        lyricLabel.textColor = ColorManager.share.text
        lyricLabel.textAlignment = .center
        lyricLabel.lineBreakMode = .byClipping
        lyricLabel.numberOfLines = 0
        
        addSubview(lyricLabel)
        lyricLabel.snp.makeConstraints { view in
            view.center.width.equalToSuperview()
            view.height.equalToSuperview().offset(-5)
        }
    }
}

// MARK: - LyricTableView

class LyricTableView: UITableView {
    // MARK: Lifecycle

    // MARK: Object LifeCycle

    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    // MARK: Internal

    var currenttime: Double = 0

    var lyrics = [LyricModel]() {
        didSet {
            self.reloadData()
        }
    }

    // MARK: Private

    // MARK: Initailizer

    private func setup() {
        self.separatorStyle = .none
//        self.backgroundColor = .clear
        self.setDebugOutline(2.0, .systemGreen)
        self.keyboardDismissMode = .none
        self.estimatedRowHeight = 20
        self.rowHeight = UITableView.automaticDimension
        self.allowsSelection = true
        self.allowsMultipleSelection = false
        
        self.isScrollEnabled = false
        self.register(LyricTableCell.self, forCellReuseIdentifier: LyricTableCell.identifier)
        if #available(iOS 11.0, *) {
            self.contentInsetAdjustmentBehavior = .never
        }
        self.delegate = self
        self.dataSource = self
        
    }
}

extension LyricTableView: UITableViewDelegate {
    func numberOfSections(in _: UITableView) -> Int {
            return 1
        }

    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return self.lyrics.count
    }
}

extension LyricTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.dequeueReusableCell(withIdentifier: LyricTableCell.identifier, for: indexPath) as? LyricTableCell else{
            fatalError()
        }
        cell.lyric = lyrics[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

