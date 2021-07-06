//
//  LyricViewController.swift
//  ios_copy_flow
//
//  Created by 김성욱 on 2021/07/05.
//

import Foundation
import UIKit
class LyricViewController: UIViewController {
    @IBAction func goBackTestAction(_ sender: UIButton) {
        self.dismiss(animated: true) {
            Log.info("Ohhhh Yes")
        }
    }
}
