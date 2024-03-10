//
//  CombinedChannels.swift
//
//
//  Created by Kristóf Kálai on 10/03/2024.
//

open class CombinedChannels<Output>: BaseChannel<Output> {
    private var channels: [BaseChannel<Output>]

    public init(channels: [BaseChannel<Output>] = []) {
        self.channels = channels
        super.init()
    }

    open func add(channel: BaseChannel<Output>) {
        channels.append(channel)
    }

    open override func send(value: Output) {
        super.send(value: value)
        channels.forEach {
            $0.send(value: value)
        }
    }
}
