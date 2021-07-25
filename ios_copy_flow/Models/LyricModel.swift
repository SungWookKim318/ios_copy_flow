//
//  LyricModel.swift
//  ios_copy_flow
//
//  Created by 김성욱 on 2021/07/10.
//

import Foundation

enum LyricParseError: Error {
    case regularExpressPatterIncorrect,
         parseStringIncorrect,
         parseSubStringIncorrect
}

struct LyricModel {
    let startSeconds: Double
    let text: String
}

extension LyricModel {
    static func convert(to text: NSString) -> Result<[LyricModel], LyricParseError> {
        let regexp: NSRegularExpression
        do {
            let regexPattern = "\\[([0-9]+):([0-9]+):([0-9]+)\\]([\\w\\W][^\n]+)"
            regexp = try NSRegularExpression(pattern: regexPattern, options: [])
        } catch {
            return .failure(.regularExpressPatterIncorrect)
        }
        let matches = regexp.matches(in: text as String, options: [], range: NSMakeRange(0, text.length))
        var result = [LyricModel]()
        for items in matches {
            if items.numberOfRanges != 5 {
                return .failure(.parseStringIncorrect)
            }
            var seconds: Double = 0.0
            guard let min = Double(text.substring(with: items.range(at: 1))) else {
                return .failure(.parseSubStringIncorrect)
            }
            seconds += min * 60.0
            guard let sec = Double(text.substring(with: items.range(at: 2))) else {
                return .failure(.parseSubStringIncorrect)
            }
            seconds += sec
            guard let underSec = Double(text.substring(with: items.range(at: 3))) else {
                return .failure(.parseSubStringIncorrect)
            }
            seconds += underSec * 0.01
            let lyrics = text.substring(with: items.range(at: 4))
            result.append(LyricModel(startSeconds: seconds, text: lyrics))
        }
        if result.count == 0 {
            // Default Returning
            return .success([LyricModel(startSeconds: 0.0, text: "연주곡")])
        }
        return .success(result)
    }
}
