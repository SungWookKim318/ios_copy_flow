//
//  AppDelegate.swift
//  ios_copy_flow
//
//  Created by 김성욱 on 2021/07/05.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow? = nil
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        if #available(iOS 13.0, *) {
            print("Call in SceneDelegate")
        }
        else {
            self.window = UIWindow(frame: UIScreen.main.bounds)

            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            
            window?.rootViewController = storyBoard.instantiateViewController(withIdentifier: "splashViewController")
            window?.makeKeyAndVisible()
        }

        return true
    }
}
