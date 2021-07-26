//
//  String+Extension.swift
//  ios_copy_flow
//
//  Created by 김성욱 on 2021/07/06.
//

import Foundation

extension String {
    func extractClassName() -> String {
        guard let fileName = components(separatedBy: "/").last,
              let className = fileName.components(separatedBy: ".").first
        else {
            return "No FilePath"
        }

        return className
    }
}
