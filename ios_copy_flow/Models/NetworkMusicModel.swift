//
//  NetworkMusicModel.swift
//  testProject
//
//  Created by 김성욱 on 2021/07/06.
//

import Foundation

struct NetworkMusicModel: Codable {
    var singer: String
    var album: String
    var title: String
    var duration: Int
    var image: String
    var file: String
    var lyrics: String
}
