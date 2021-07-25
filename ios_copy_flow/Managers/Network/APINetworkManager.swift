//
//  APIManager.swift
//  ios_copy_flow
//
//  Created by 김성욱 on 2021/07/06.
//

import Foundation

enum APINetworkManager {
    private enum Develop {
        static let base = "https://grepp-programmers-challenges.s3.ap-northeast-2.amazonaws.com/2020-flo"
    }
    private enum Production {
        static let base = "https://grepp-programmers-challenges.s3.ap-northeast-2.amazonaws.com/2020-flo"
    }
    static let base: String = {
        #if DEBUG
        return Develop.base
        #else
        return Production
        #endif
    }()
    static let getSongs = base + "/song.json"
}
