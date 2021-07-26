//
//  CustomLog.swift
//  MelchiMediaEditor
//
//  Created by SungWook Kim on 2021/07/06.
//  Copyright © 2020 김성욱. All rights reserved.
//

import Logging
import LoggingOSLog

// 로그
public final class Log {
    public static var `default` = Logger(label: "com.swkim.app", factory: LoggingOSLog.init)

    public class func setup(subsystem: String, level: Logger.Level = .debug) {
        `default` = Logger(label: subsystem, factory: LoggingOSLog.init)
        `default`.logLevel = level
    }
}

public extension Log {
    static func trace(_ message: Logger.Message, functionName: String = #function, fileName: String = #file) {
        let className = fileName.extractClassName()
        `default`.trace("\(className):\(functionName) \(message)")
    }

    static func debug(_ message: Logger.Message, functionName: String = #function, fileName: String = #file) {
        let className = fileName.extractClassName()
        `default`.debug("\(className):\(functionName) \(message)")
    }

    static func info(_ message: Logger.Message, functionName: String = #function, fileName: String = #file) {
        let className = fileName.extractClassName()
        `default`.info("\(className):\(functionName) \(message)")
    }

    static func notice(_ message: Logger.Message, functionName: String = #function, fileName: String = #file) {
        let className = fileName.extractClassName()
        `default`.notice("\(className):\(functionName) \(message)")
    }

    static func warning(_ message: Logger.Message, functionName: String = #function, fileName: String = #file) {
        let className = fileName.extractClassName()
        `default`.warning("\(className):\(functionName) \(message)")
    }

    static func error(_ message: Logger.Message, functionName: String = #function, fileName: String = #file) {
        let className = fileName.extractClassName()
        `default`.error("\(className):\(functionName) \(message)")
    }

    static func critical(_ message: Logger.Message, functionName: String = #function, fileName: String = #file) {
        let className = fileName.extractClassName()
        `default`.critical("\(className):\(functionName) \(message)")
    }

    static func crushOrError(_ message: Logger.Message, functionName: String = #function, fileName: String = #file) {
        let className = fileName.extractClassName()
        #if DEBUG
            fatalError("\(className):\(functionName) \(message)")
        #else
            `default`.error("\(className):\(functionName) \(message)")
        #endif
    }
}
