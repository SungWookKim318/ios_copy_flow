//
//  LyricViewController.swift
//  ios_copy_flow
//
//  Created by 김성욱 on 2021/07/05.
//

import Foundation
import UIKit

import RxCocoa
import RxGesture
import RxSwift

class LyricViewController: BaseViewController {
    // MARK: Internal

    // MARK: Variable

    let titleInfo = PlayInfoView()
    let backButton = UIButton()
    let lyricView = LyricTableView()
    let magnifierButton = UIButton()
    let audioSeekBar = UIView()
    let audioController = UIView()

    let disposeBag = DisposeBag()

    // MARK: View LifeCycle

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        guard let currentMusic = PlayListManager.share.current else {
            Log.crushOrError("no exist any music impossible by logic")
            return
        }
        lyricView.lyrics = currentMusic.lyrics
        titleInfo.title = currentMusic.networkModel.title
        titleInfo.singer = currentMusic.networkModel.singer
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }

    // MARK: Private

    // MARK: Init Function

    private func setup() {
        setComponent()
        setAutoLayout()
        setRxFunction()
    }

    private func setComponent() {
        titleInfo.backgroundColor = .systemRed.withAlphaComponent(0.5)
        self.view.addSubview(titleInfo)

        backButton.backgroundColor = .systemBlue.withAlphaComponent(0.5)
        self.view.addSubview(backButton)

        lyricView.allowsSelection = true
        lyricView.isScrollEnabled = true
        lyricView.backgroundColor = .systemYellow.withAlphaComponent(0.5)
        self.view.addSubview(lyricView)

        magnifierButton.backgroundColor = .systemBlue.withAlphaComponent(0.5)
        self.view.addSubview(magnifierButton)

        audioSeekBar.backgroundColor = .systemRed.withAlphaComponent(0.5)
        self.view.addSubview(audioSeekBar)

        audioController.backgroundColor = .systemGreen.withAlphaComponent(0.5)
        self.view.addSubview(audioController)
    }

    private func setAutoLayout() {
        titleInfo.snp.makeConstraints { view in
            view.left.equalToSuperview()
            view.right.equalTo(backButton.snp.left).offset(-10)
            view.height.equalTo(55)
            if #available(iOS 11.0, *) {
                view.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(20)
            } else {
                view.top.equalTo(self.statusBarHeight).offset(20)
            }
        }
        backButton.snp.makeConstraints { view in
            view.right.equalToSuperview().offset(-10)
            view.centerY.equalTo(titleInfo.snp.centerY)
            view.width.height.equalTo(40)
        }
        
        lyricView.snp.makeConstraints { view in
            view.top.equalTo(titleInfo.snp.bottom).offset(10)
            view.left.equalToSuperview()
            view.right.equalTo(magnifierButton.snp.left).offset(-10)
            view.bottom.equalTo(audioSeekBar.snp.top).offset(-10)
        }
        
        magnifierButton.snp.makeConstraints { view in
            view.right.equalTo(backButton)
            view.width.height.equalTo(backButton)
            view.top.equalTo(titleInfo.snp.bottom).offset(10)
        }
        
        audioSeekBar.snp.makeConstraints { view in
            view.bottom.equalTo(audioController.snp.top)
            view.left.right.equalToSuperview()
            view.height.equalTo(30)
        }
        audioController.snp.makeConstraints { view in
            view.left.right.equalToSuperview()
            view.height.equalTo(55)
            if #available(iOS 11.0, *) {
                view.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
            } else {
                view.bottom.equalToSuperview()
            }
        }
    }

    private func setRxFunction() {
        backButton.rx
            .tap
            .withUnretained(self)
            .asDriver(onErrorDriveWith: .never())
            .drive { vc, _ in
                vc.dismiss(animated: true, completion: nil)
            }.disposed(by: disposeBag)
    }
}
