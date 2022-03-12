//
//  YaruList.swift
//  
//
//  Created by Yuya Hirayama on 2022/03/10.
//

import Foundation

struct YaruList: Codable {
    var items: [YaruItem]
}

struct YaruItem: Codable {
    var title: String
}
