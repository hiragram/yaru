//
//  YaruError.swift
//  
//
//  Created by Yuya Hirayama on 2022/03/10.
//

import Foundation

enum YaruError: Error {
    case invalidSubcommand(String)
    case argumentMissing
    case uninitialized
    case alreadyInitialized
}
