import Foundation
import Yams
import ArgumentParser

@main
struct Yaru: ParsableCommand {
    static var configuration = CommandConfiguration(
        subcommands: [Init.self, Current.self, Push.self, Enq.self, Next.self, All.self]
    )
}

extension Yaru {
    struct Init: ParsableCommand {
        mutating func run() throws {
            guard (try? Storage.default.load()) == nil else {
                throw YaruError.alreadyInitialized
            }
            Storage.default.initialize()
            let emptyList = YaruList.init(items: [])
            try Storage.default.save(yaruList: emptyList)
        }
    }
    
    struct Current: ParsableCommand {
        mutating func run() throws {
            if let item = try Storage.default.load().items.first {
                print(item.title)
            }
        }
    }
    
    struct Push: ParsableCommand {
        @Argument
        var title: String
        
        mutating func run() throws {
            var storedList = try Storage.default.load()
            storedList.items.insert(.init(title: title), at: 0)
            try Storage.default.save(yaruList: storedList)
        }
    }
    
    struct Enq: ParsableCommand {
        @Argument
        var title: String
        
        mutating func run() throws {
            var storedList = try Storage.default.load()
            storedList.items.append(.init(title: title))
            try Storage.default.save(yaruList: storedList)
        }
    }
    
    struct Next: ParsableCommand {
        mutating func run() throws {
            var storedList = try Storage.default.load()
            storedList.items = Array(storedList.items.dropFirst())
            try Storage.default.save(yaruList: storedList)
        }
    }
    
    struct All: ParsableCommand {
        mutating func run() throws {
            let list = try Storage.default.load()
            list.items.forEach { item in
                print(item.title)
            }
        }
    }
}
