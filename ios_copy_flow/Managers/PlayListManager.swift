//
//  PlayListManager.swift
//  ios_copy_flow
//
//  Created by 김성욱 on 2021/07/10.
//

import Foundation

class PlayListManager {
    static let share = PlayListManager()
    private init() {}

    var musicList = [MusicModel]()
    private var selecteIndex = 0
    var current: MusicModel? {
        if selecteIndex >= musicList.count {
            return nil
        }
        return musicList[selecteIndex]
    }

    func nextSong() -> Bool {
        if selecteIndex + 1 >= musicList.count {
            return false
        }
        selecteIndex += 1
        return true
    }

    func previousSong() -> Bool {
        if selecteIndex - 1 < 0 {
            return false
        }
        selecteIndex -= 1
        return true
    }

    func pushBack(song: MusicModel) {
        musicList.append(song)
    }

    func pushBack(songs: [MusicModel]) {
        musicList.append(contentsOf: songs)
    }

    func pushFront(song: MusicModel) {
        musicList.insert(song, at: 0)
        selecteIndex += 1
    }

    // func popBack()
}
