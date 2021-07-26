//
//  AppDelegate.swift
//  ios_copy_flow
//
//  Created by 김성욱 on 2021/07/05.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_: UIApplication, didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        Log.setup(subsystem: "App", level: .trace)

        if #available(iOS 13.0, *) {
            print("Call in SceneDelegate")
            self.window = UIWindow(frame: UIScreen.main.bounds)

            ColorManager.share.isDarkMode = window?.traitCollection.userInterfaceStyle == .dark
        } else {
            window = UIWindow(frame: UIScreen.main.bounds)

            let storyBoard = UIStoryboard(name: "Main", bundle: nil)

            window?.rootViewController = storyBoard.instantiateViewController(withIdentifier: "splashViewController")
            window?.makeKeyAndVisible()
            // Darkmode 대응
            if #available(iOS 12.0, *) {
                ColorManager.share.isDarkMode = window?.traitCollection.userInterfaceStyle == .dark
            } else {
                ColorManager.share.isDarkMode = false
            }
        }

        return true
    }
}
