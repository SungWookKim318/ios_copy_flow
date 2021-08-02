//
//  lyricTableView.swift
//  ios_copy_flow
//
//  Created by 김성욱 on 2021/07/26.
//

import Foundation
import UIKit

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

    var currentTime: Double = 0 {
        didSet {
            let indexPath = foundLyricIndex(second: currentTime)
            self.selectRow(at: indexPath, animated: true, scrollPosition: .top)

            
//            if let cell = self.cellForRow(at: indexPath) as? LyricTableCell {
//                self.selectRow(at: indexPath, animated: true, scrollPosition: .top)
//            } else {
//                fatalError()
//            }
        }
    }
    
    func foundLyricIndex(second: Double) -> IndexPath {
        let index: Int = {
            if second <= 0.0 {
                return 0
            }
            for lyric in lyrics.enumerated() {
                if lyric.element.startSeconds > second {
                    if lyric.offset - 1 <= 0 { return 0 }
                    return lyric.offset - 1
                }
            }
            return lyrics.count - 1
        }()
        
        return IndexPath(row: index, section: 0)
    }
    
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

// MARK: UITableViewDelegate

extension LyricTableView: UITableViewDelegate {
    func numberOfSections(in _: UITableView) -> Int {
        1
    }

    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        self.lyrics.count
    }
    // Select row
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? LyricTableCell else {
            fatalError()
        }
        cell.setSelected(true, animated: true)
        scrollToNearestSelectedRow(at: .top, animated: true)
    }
    
    // unslect row
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? LyricTableCell else {
            fatalError()
        }
        cell.setSelected(false, animated: true)
//        cell.updateLabel()
    }
}

// MARK: UITableViewDataSource

extension LyricTableView: UITableViewDataSource {
    func tableView(_: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.dequeueReusableCell(withIdentifier: LyricTableCell.identifier, for: indexPath) as? LyricTableCell else {
            fatalError()
        }
        cell.lyric = lyrics[indexPath.row]
        return cell
    }

    func tableView(_: UITableView, heightForRowAt _: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}
