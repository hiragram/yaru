//
//  YaruError.swift
//  
//
//  Created by Yuya Hirayama on 2022/03/10.
//

import ArgumentParser

enum YaruError {
    static let uninitialized = ValidationError("Uninitialized.")
    static let alreadyInitialized = ValidationError("Already initialized.")
}


