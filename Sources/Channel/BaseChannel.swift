//
//  BaseChannel.swift
//
//
//  Created by Kristóf Kálai on 10/03/2024.
//

open class BaseChannel<Output>: Channel {
    public init() {}

    open func send(value: Output) {}
}

extension BaseChannel {
    public static var empty: BaseChannel {
        .init()
    }
}
