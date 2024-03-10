//
//  Channel+Extensions.swift
//
//
//  Created by Kristóf Kálai on 10/03/2024.
//

import Foundation

extension Channel {
    public static func closure(replay: Bool = true, latestOutput: Output? = nil, receiveOutput: ((Output) -> Void)? = nil) -> ClosureChannel<Output> {
        ClosureChannel(replay: replay, latestOutput: latestOutput, receiveOutput: receiveOutput)
    }

    public static var closure: ClosureChannel<Output> {
        .closure()
    }
}

extension Channel {
    public static var combine: CombineChannel<Output> {
        CombineChannel()
    }
}

extension Channel {
    public static func async(latestOutput: Output? = nil) -> AsyncChannel<Output> {
        AsyncChannel(latestOutput: latestOutput)
    }

    public static var async: AsyncChannel<Output> {
        .async()
    }
}
