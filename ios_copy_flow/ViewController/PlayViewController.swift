//
//  PlayViewController.swift
//  ios_copy_flow
//
//  Created by 김성욱 on 2021/07/05.
//

import Foundation
import UIKit

import RxSwift
import SnapKit

class PlayViewController: BaseViewController {
    // MARK: Variable

    let topMenu = PlayTopNavigationView()

    @IBAction func TestAction(_ sender: UIButton) {
        self.routeToLyrics()
    }

    // MARK: View LifeCycle

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        print("viewDidLoad")
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }

    // SetupFunction

    func setupSubviews() {
        topMenu.backgroundColor = .systemPink
        self.view.addSubview(topMenu)
    }

    func setupAutoLayout() {
//        let statisBarHeight =
        topMenu.snp.makeConstraints { view in
            view.width.equalToSuperview()
            view.centerX.equalToSuperview()
            view.height.equalTo(45.0)
            // 말도안되는 구형 iOS safeArea 미지원 대응
//            if #available(iOS 11.0, *) {
//                view.top.equalTo(self.additionalSafeAreaInsets.top)
//            } else {
//                view.top.equalToSuperview()
//            }
            view.top.equalTo(self.statusBarHeight)
        }
    }

    func setupRx() {}

    func setup() {
        setupSubviews()
        setupAutoLayout()
        setupRx()
    }

    // MARK: Routers

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {}

    private func routeToLyrics() {
        Log.info("user move to PlayerViewController")
        self.performSegue(withIdentifier: "routeLyrics", sender: nil)
    }
}

extension PlayViewController {
    override var prefersStatusBarHidden: Bool { false }
    
}
