//
//  CacheFileManaer.swift
//  ios_copy_flow
//
//  Created by 김성욱 on 2021/07/05.
//

import Foundation

class CacheFileManaer {
    static let share = CacheFileManaer()
    private init() {}
    // ------------------------------

    static let userDocuURL: URL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    static let cacheFolderName: String = "musiccache"

//    private(set) let cacheDirectory: URL =
}
