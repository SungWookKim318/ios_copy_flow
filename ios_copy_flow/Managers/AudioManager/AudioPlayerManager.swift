//
//  AudioPlayerManager.swift
//  ios_copy_flow
//
//  Created by 김성욱 on 2021/07/10.
//

import AVFoundation
import Foundation
import RxSwift

enum AudioPlayerError: Error {
    case notExistItem
}

protocol AudioPlayerDelegate: AnyObject {
    // is NOT sure in CALL In MAINTHREAD
    func PresentTimerChanged(seconds: Double)
}

class AudioPlayerManager {
    // Sington instance
    static let share = AudioPlayerManager()
    // Public Functions
    func playPlayer() throws {
        if let item = currentAsset {
            if currentTime == nil {
                currentTime = .zero
                player.replaceCurrentItem(with: AVPlayerItem(asset: item))
            }

            player.seek(to: currentTime!, toleranceBefore: .zero, toleranceAfter: .zero) { [weak self] _ in
                self?.player.play()
            }
        } else {
            throw AudioPlayerError.notExistItem
        }
    }

    func pausePlayer() {
        currentTime = player.currentTime()
        player.pause()
    }

    func stopPlayer() {
        currentTime = .zero
        player.pause()
    }

    func seekTo(ratio: Double, needPlay: Bool) {
        guard let asset = currentAsset else {
            Log.warning("asset is not ready")
            return
        }
        let newTime = CMTimeMultiplyByFloat64(asset.duration, multiplier: ratio)
        let tolerance = CMTimeMakeWithSeconds(0.01, preferredTimescale: 600)
        isSeeking = true
        player.seek(to: newTime, toleranceBefore: tolerance, toleranceAfter: tolerance) { [weak self] isFinishedSeek in
            if isFinishedSeek == false {
                self?.isSeeking = true
                return
            }
            Log.info("Seeking is finished")
            self?.currentTime = newTime
            self?.isSeeking = false
            if needPlay {
                self?.player.play()
            }
        }
    }

    // Public Variables
    weak var delegate: AudioPlayerDelegate?
    var duration: Double? { currentAsset?.duration.seconds }
    private var loadedObserver = false
    var isLoaded: Bool {
        if currentAsset != nil {
            return true
        }
        return false
    }
    private(set) var isSeeking: Bool = false
    var currentItem: URL? {
        didSet {
            guard let url = currentItem else {
                currentAsset = nil
                currentTime = nil
                player.pause()
                player.replaceCurrentItem(with: nil)
                return
            }
            let newAsset = AVURLAsset(url: url)
            newAsset.loadValuesAsynchronously(forKeys: ["commonMetadata"]) { [weak self] in
                var error: NSError?
                switch newAsset.statusOfValue(forKey: "commonMetadata", error: &error) {
                case .loaded:
                    // The property successfully loaded. Continue processing.
                    if let audioTrack = newAsset.tracks(withMediaType: .audio).first {
                        if let audioAsset = audioTrack.asset {
                            self?.player.pause()
                            self?.currentAsset = audioAsset
                            print("success audio open")
                            return
                        }
                    }
                    print("fail audio open")
                case .failed:
                    // Examine the NSError pointer to determine the failure.
                    self?.currentItem = nil
                case .cancelled:
                    // The asset canceled loading.
                    self?.currentItem = nil
                default:
                    // Handle all other cases.
                    self?.currentAsset = nil
                    self?.currentItem = nil
                }
            }
        }
    }

    // private nextItem: URL?
    private var currentAsset: AVAsset?
    private var player: AVPlayer = {
        let player = AVPlayer()
//        _ = player.observe(\.status, options: [.old, .new]) { (object, change) in
//            if let newValue = change.newValue {
//                print("player KVO status is change to \(change.newValue)")
//                if newValue == .readyToPlay {
//                    AudioPlayerManager.share.loadedObserver = true
//                }
//            }
//        }
        return player
    }()
    private var currentTime: CMTime?

    private init() {
        player.addPeriodicTimeObserver(forInterval: CMTime(seconds: 0.1, preferredTimescale: 100), queue: DispatchQueue.global(qos: .background)) { [weak self] newTime in
            self?.delegate?.PresentTimerChanged(seconds: newTime.seconds)
        }
    }
}
