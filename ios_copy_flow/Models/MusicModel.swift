//
//  File.swift
//  ios_copy_flow
//
//  Created by 김성욱 on 2021/07/10.
//

import Foundation

class MusicModel {
    let networkModel: NetworkMusicModel
    var savedMusic: URL?
    var lyrics = [LyricModel]()

    init?(model: NetworkMusicModel) {
        networkModel = model
        switch LyricModel.convert(to: model.lyrics as NSString) {
        case .success(let lyrics):
            self.lyrics = lyrics
        case .failure(let error):
            print("convert lyric error - \(error)")
            return nil
        }
//        lyrics = LyricModel.convert(to: model.lyrics as NSString)
    }
}
