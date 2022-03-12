//
//  Storage.swift
//  
//
//  Created by Yuya Hirayama on 2022/03/10.
//

import Foundation
import Yams

class Storage {
    static let `default` = Storage.init(fileURL: URL.init(fileURLWithPath: "~/.yaru.yml"))
    
    private let fileURL: URL
    
    private init(fileURL: URL) {
        self.fileURL = fileURL
    }
    
    func load() throws -> YaruList? {
        guard let data = try? Data.init(contentsOf: fileURL) else {
            return nil
        }
        
        let decoder = YAMLDecoder.init()
        
        return try decoder.decode(YaruList.self, from: data, userInfo: [:])
    }
    
    func save(yaruList: YaruList) throws {
        let encoder = YAMLEncoder.init()
        let data = try encoder.encode(yaruList)
        
        try data.write(to: fileURL, atomically: true, encoding: .utf8)
    }
}
