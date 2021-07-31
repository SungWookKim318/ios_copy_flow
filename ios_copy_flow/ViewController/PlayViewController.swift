//
//  PlayViewController.swift
//  ios_copy_flow
//
//  Created by 김성욱 on 2021/07/05.
//

import Foundation
import UIKit

import RxCocoa
import RxGesture
import RxSwift
import SnapKit

// MARK: - PlayViewController

class PlayViewController: BaseViewController {
    // MARK: Internal

    // MARK: Variable

    let topMenu = PlayTopNavigationView()
    let menuButton = UIButton()
    let titleInfo = PlayInfoView()
    
    let albumImageView = UIImageView()
    let lyricView = LyricTableView()
    let likeButton = UIView()
    let audioSeekBar = UISlider()
    let audioController = AudioControllerView()
    
    let instaButton = UIButton()
    let similarButton = UIButton()
    let popupPlayListButton = UIButton()
    
    let disposeBag = DisposeBag()

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
        topMenu.setDebugOutline(1.0, .systemPink)
        view.addSubview(topMenu)
        
        menuButton.setDebugOutline(1.0, .blue)
        menuButton.setImage(UIImage(named: "threedot"), for: .normal)
        menuButton.contentMode = .scaleAspectFit
        let affineMatrix = menuButton.layer.affineTransform()
        menuButton.layer.setAffineTransform(affineMatrix.rotated(by: .pi / 2))
        menuButton.imageView?.snp.makeConstraints { imageView in
            imageView.center.equalToSuperview()
            imageView.size.equalToSuperview().multipliedBy(0.75)
        }
        view.addSubview(menuButton)
        
        view.addSubview(titleInfo)
        
        albumImageView.contentMode = .scaleAspectFill
        albumImageView.clipsToBounds = true
        albumImageView.roundCorners(.allCorners, radius: 5)
        albumImageView.setDebugOutline(1.0, .blue)
        view.addSubview(albumImageView)
        
        albumImageView.setDebugOutline(1.0, .blue)
        lyricView.backgroundColor = .systemGreen.withAlphaComponent(0.5)
        lyricView.allowsSelection = false
        view.addSubview(lyricView)
        
        likeButton.setDebugOutline(1.0, .systemPink)
        view.addSubview(likeButton)
        
        audioSeekBar.setDebugOutline(1.0, .systemYellow)
        view.addSubview(audioSeekBar)
        
        audioController.setDebugOutline(1.0, .systemBlue)
        view.addSubview(audioController)
        
        self.view.addSubview(instaButton)
        similarButton.setTitle("유사곡", for: .normal)
        similarButton.titleLabel?.textAlignment = .center
        similarButton.titleLabel?.textColor = ColorManager.share.textDeep
        similarButton.titleLabel?.font = .systemFont(ofSize: 16)
        
        self.view.addSubview(similarButton)
        self.view.addSubview(popupPlayListButton)
        
        instaButton.setDebugOutline(1.0, .systemRed)
        popupPlayListButton.setDebugOutline(1.0, .systemRed)
        
        guard let currentMusic = PlayListManager.share.current else {
            return
        }
        lyricView.lyrics = currentMusic.lyrics
        titleInfo.title = currentMusic.networkModel.title
        titleInfo.singer = currentMusic.networkModel.singer
        AudioPlayerManager.share.currentItem = URL(string: currentMusic.networkModel.file)
        if let imageURI = URL(string: currentMusic.networkModel.image),
           let imageData = try? Data(contentsOf: imageURI)
        {
            DispatchQueue.global(qos: .background).async { [weak self, imageData] in
                if let image = UIImage(data: imageData) {
                    DispatchQueue.main.async { [weak self] in
                        self?.albumImageView.image = image
                    }
                }
            }
        }
    }

    override func viewSafeAreaInsetsDidChange() {}

    func setupAutoLayout() {
        //        let statisBarHeight =
        topMenu.snp.makeConstraints { view in
            view.width.equalToSuperview()
            view.centerX.equalToSuperview()
            view.height.equalTo(45.0)
            // 말도안되는 구형 iOS safeArea 미지원 대응
            if #available(iOS 11.0, *) {
                view.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            } else {
                view.top.equalTo(self.statusBarHeight)
            }
        }
        
        menuButton.snp.makeConstraints { view in
            view.right.equalToSuperview().offset(-20)
            view.width.height.equalTo(30)
            view.top.equalTo(topMenu.snp.bottom).offset(5)
        }
        
        titleInfo.snp.makeConstraints { view in
            view.left.equalToSuperview()
            view.right.equalToSuperview()
            view.top.equalTo(menuButton.snp.bottom).offset(5)
            view.height.equalTo(65)
        }
        
        albumImageView.snp.makeConstraints { view in
            view.top.equalTo(titleInfo.snp.bottom).offset(10)
            view.bottom.equalTo(lyricView.snp.top).offset(-10)
            view.centerX.equalToSuperview()
            view.width.equalTo(albumImageView.snp.height)
        }
        
        lyricView.snp.makeConstraints { view in
            view.left.right.equalToSuperview()
            view.bottom.equalTo(likeButton.snp.top).offset(-10)
            view.height.equalTo(55)
        }
        
        likeButton.snp.makeConstraints { view in
            view.centerX.equalToSuperview()
            view.bottom.equalTo(audioSeekBar.snp.top).offset(-35)
            view.width.equalTo(120)
            view.height.equalTo(40)
        }
        
        audioSeekBar.snp.makeConstraints { view in
            view.bottom.equalTo(audioController.snp.top)
            view.left.right.equalToSuperview()
            view.height.equalTo(40)
        }
        
        audioController.snp.makeConstraints { view in
            view.bottom.equalTo(popupPlayListButton.snp.top).offset(-10)
            view.left.right.equalToSuperview()
            view.height.equalTo(60)
        }
        
        instaButton.snp.makeConstraints { view in
            view.bottom.equalTo(popupPlayListButton.snp.bottom)
            view.left.equalToSuperview().offset(20)
            view.height.width.equalTo(40)
        }
        
        var boxSize = similarButton.sizeThatFits(.zero)
        let lineWidth: CGFloat = 2.0
        let roundRadius: CGFloat = (boxSize.height + lineWidth * 2) / 2.0
        boxSize.width += roundRadius * 2
        boxSize.height += lineWidth * 2
        similarButton.setBorder(width: lineWidth, color: ColorManager.share.textDeep)
        similarButton.roundCorners(.allCorners, radius: roundRadius)
        
        similarButton.snp.makeConstraints { view in
            view.bottom.equalTo(popupPlayListButton.snp.bottom)
            view.centerX.equalToSuperview()
            view.size.equalTo(boxSize)
        }
        
        popupPlayListButton.snp.makeConstraints { view in
            if #available(iOS 11.0, *) {
                view.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(-10)
            } else {
                view.bottom.equalToSuperview().offset(-10)
            }
            view.right.equalToSuperview().offset(-20)
            view.height.width.equalTo(40)
        }
    }
    
    func setupRx() {
        lyricView.rx.gesture(.tap())
            .when(.recognized)
            .withUnretained(self)
            .asDriver(onErrorDriveWith: .never())
            .drive { vc, _ in
                vc.performSegue(withIdentifier: "routeLyrics", sender: self)
            }.disposed(by: disposeBag)
        
        audioController.playButton.rx
            .tapGesture().when(.recognized)
            .withUnretained(audioController.playButton)
            .subscribe { button, _ in
                let globalPlayer = AudioPlayerManager.share
                if !button.isSelected { // Play
                    guard (try? globalPlayer.playPlayer()) != nil else {
                        return
                    }
                    button.isSelected = true
                } else {
                    globalPlayer.pausePlayer()
                    button.isSelected = false
                }
            }.disposed(by: disposeBag)
        audioController.previousButton.rx
            .tapGesture().when(.recognized)
            .withUnretained(audioController.playButton)
            .subscribe { playButton, _ in
                let globalPlayer = AudioPlayerManager.share
                globalPlayer.stopPlayer()
                if playButton.isSelected {
                    guard (try? AudioPlayerManager.share.playPlayer()) != nil else {
                        fatalError()
                    }
                }
            }.disposed(by: disposeBag)
        audioController.nextButton.rx.tapGesture().when(.recognized)
            .withUnretained(audioController.playButton)
            .subscribe { playButton, _ in
                // Songlist.last != current { }

                AudioPlayerManager.share.stopPlayer()
                playButton.isSelected = false
            }.disposed(by: disposeBag)
        audioSeekBar.rx.value
                    .asDriver()
                    .distinctUntilChanged()
                    .throttle(.milliseconds(500))
                    .filter { _ in
                        !AudioPlayerManager.share.isSeeking
                    }
                    .drive(with: audioController.playButton, onNext: { playButton, newValue in
                        AudioPlayerManager.share.seekTo(ratio: Double(newValue), needPlay: playButton.isSelected)
                    }).disposed(by: disposeBag)
    }
    
    func setup() {
        setupSubviews()
        setupAutoLayout()
        setupRx()
        
        AudioPlayerManager.share.delegate = self
    }
    
    // MARK: Routers
    
    override func prepare(for _: UIStoryboardSegue, sender _: Any?) {}

    // MARK: Private

    private func routeToLyrics() {
        Log.info("user move to PlayerViewController")
        performSegue(withIdentifier: "routeLyrics", sender: nil)
    }
}

extension PlayViewController {
    override var prefersStatusBarHidden: Bool { false }
}


extension PlayViewController: AudioPlayerDelegate {
    func PresentTimerChanged(seconds: Double) {
        if let duration = AudioPlayerManager.share.duration {
            DispatchQueue.main.async { [weak self] in
                let newPTS = Float(seconds / duration)
                self?.audioSeekBar.value = Float(seconds / duration)
                Log.trace("Audio Player new pts = \(newPTS)")
            }
        } else {
            audioSeekBar.rx.value.on(.next(0))
            audioController.playButton.isSelected = false
        }
    }
}
