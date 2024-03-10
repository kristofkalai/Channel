//
//  OldProducerAdapter.swift
//  Example
//
//  Created by Kristóf Kálai on 10/03/2024.
//

import Channel

final class OldProducerAdapter {
    private let oldProducer: OldProducer

    init(channel: BaseChannel<Int>) {
        oldProducer = .init {
            channel.send(value: $0)
        }
    }

    func start() {
        oldProducer.start()
    }
}
