//
//  PlayViewController.swift
//  ios_copy_flow
//
//  Created by 김성욱 on 2021/07/05.
//

import Foundation
import UIKit
class PlayViewController: UIViewController {
    // MARK: Variable
    var playerControllers = UIStackView()
    @IBAction func TestAction(_ sender: UIButton) {
        self.routeToLyrics()
    }
    
    // MARK: View LifeCycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    
    // MARK: Routers
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    private func routeToLyrics() {
        Log.info("user move to PlayerViewController")
        self.performSegue(withIdentifier: "routeLyrics", sender: nil)
    }
}
