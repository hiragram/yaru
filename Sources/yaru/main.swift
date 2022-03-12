import Foundation
import Yams

// get arguments
let args = CommandLine.arguments

// get subcommand
guard let subCommand = args.dropFirst().first.flatMap(SubCommand.init) else {
    throw YaruError.invalidSubcommand(args.dropFirst().first ?? "")
}

switch subCommand {
case .current:
    if let item = try Storage.default.load()?.items.first {
        print(item.title)
    }
case .`init`:
    guard try Storage.default.load() == nil else {
        throw YaruError.alreadyInitialized
    }
    Storage.default.initialize()
    let emptyList = YaruList.init(items: [])
    try Storage.default.save(yaruList: emptyList)
case .all:
    if let list = try Storage.default.load() {
        list.items.forEach { item in
            print(item.title)
        }
    }
case .next:
    guard var storedList = try Storage.default.load() else {
        throw YaruError.uninitialized
    }
    storedList.items = Array(storedList.items.dropFirst())
    try Storage.default.save(yaruList: storedList)
case .enqueue:
    guard let title = args.dropFirst(2).first else {
        throw YaruError.argumentMissing
    }
    guard var storedList = try Storage.default.load() else {
        throw YaruError.uninitialized
    }
    storedList.items.append(.init(title: title))
    try Storage.default.save(yaruList: storedList)
case .push:
    guard let title = args.dropFirst(2).first else {
        throw YaruError.argumentMissing
    }
    guard var storedList = try Storage.default.load() else {
        throw YaruError.uninitialized
    }
    storedList.items.insert(.init(title: title), at: 0)
    try Storage.default.save(yaruList: storedList)
}
