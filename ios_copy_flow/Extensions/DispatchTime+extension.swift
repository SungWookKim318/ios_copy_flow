//
//  DispatchTime+extension.swift
//  ios_copy_flow
//
//  Created by 김성욱 on 2021/07/06.
//

import Foundation

extension DispatchTime {
    func seconds() -> Double {
        return Double(self.uptimeNanoseconds) / 1e9
    }
    static func makeDispatchTime(bySecond: Double) -> DispatchTime {
        return DispatchTime(uptimeNanoseconds: UInt64(bySecond * 1e9))
    }
}
