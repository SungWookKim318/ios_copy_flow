//
//  SplashViewController.swift
//  ios_copy_flow
//
//  Created by 김성욱 on 2021/07/05.
//

import Foundation
import UIKit

class SplashViewController: BaseViewController {
    override var prefersStatusBarHidden: Bool { false }
    static let limitWaitingTimer: Double = 1.0
    private let image = UIImage(named: "splash")
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Log.debug("request unlogin user Token Key")
        NetworkManager.share.requestToken(id: "", passworkd: "") { result in
            switch result {
            case let .success(tokenKey):
                Log.info("get success unlogin token - \(tokenKey)")
            case let .failure(error):
                Log.warning("fail to get default token - \(error)")
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        #if DEBUG
            let debugIndicator = UIView(frame: CGRect(x: 30, y: 30, width: 30, height: 30))
            debugIndicator.backgroundColor = .yellow
            view.addSubview(debugIndicator)
        #endif
//        if !NetworkManager.share.checkNetwork() {
//            UIControl().sendAction(#selector(URLSessionTask.suspend), to: UIApplication.shared, for: nil)
//        }

        DispatchQueue.global(qos: .background).async {
            let start = DispatchTime.now()
            // DO Downloard
            NetworkManager.share.requestSong { result in
                switch result {
                case let .success(songs):
//                    Log.debug("\(songs.first?.networkModel.singer)")
                    PlayListManager.share.pushBack(songs: songs)
                case let .failure(error):
                    Log.crushOrError("\(error)")
                }
            }
            let waitTime: Double = {
                var diff = DispatchTime.now().seconds() - start.seconds()
                if diff < 0.0 { diff = 0.0 }
                let result = SplashViewController.limitWaitingTimer - diff
                if result < 0.0 { return 0.0 }
                return result
            }()
            print("waitTime - \(waitTime)")
            DispatchQueue.main.asyncAfter(
                deadline: DispatchTime.now() + waitTime) {
                    
                    self.performSegue(withIdentifier: "routePlayer", sender: nil)
            }
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender _: Any?) {
        if segue.identifier == "next" {
            // Nothing to pass
        }
    }

    func routeToPlayer() {
        Log.info("user move to PlayerViewController")
        performSegue(withIdentifier: "routePlayer", sender: nil)
    }
}
