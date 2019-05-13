//
//  InCache.swift
//  Inspire
//
//  Created by xaoxuu on 2019/3/28.
//  Copyright © 2019 Titan Studio. All rights reserved.
//

import UIKit

// MARK: - 缓存主题
public extension Inspire {
    
    /// 缓存路径
    ///
    /// - Parameter file: 文件名
    /// - Returns: 路径
    internal static func cachePath(for file: String = "theme.json") -> String {
        if let docPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first {
            let path = docPath + "/Inspire"
            if FileManager.default.fileExists(atPath: path) == false {
                do {
                    try FileManager.default.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
                } catch {
                    print(error.localizedDescription)
                }
            }
            return NSString.init(string: path).appendingPathComponent(file) as String
        } else {
            print("获取文档路径失败！")
            return ""
        }
    }
    
    /// 缓存当前主题
    ///
    /// - Parameter named: 主题名
    func cache(named: String = "theme"){
        do {
            let data = try JSONSerialization.data(withJSONObject: export(), options: .prettyPrinted)
            let url = URL.init(fileURLWithPath: Inspire.cachePath(for: named+".json"))
            try data.write(to: url, options: .atomic)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    /// 从缓存中恢复主题
    ///
    /// - Parameter named: 主题名
    static func restore(_ named: String = "theme"){
        Inspire.apply(Inspire(named))
    }
    
    /// 根据缓存的主题名创建主题
    ///
    /// - Parameter named: 缓存的主题名
    init(_ named: String = "theme") {
        do {
            let data = try Data.init(contentsOf: URL.init(fileURLWithPath: Inspire.cachePath(for: named+".json")))
            let dict = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
            if let d = dict as? [String: Any] {
                self.init(d)
            } else {
                self.init()
            }
        } catch {
            print(error.localizedDescription)
            self.init()
        }
    }
    
}
