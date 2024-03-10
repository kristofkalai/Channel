//
//  Producer.swift
//  Example
//
//  Created by Kristóf Kálai on 10/03/2024.
//

import Channel
import Combine
import Foundation

final class Producer {
    private let channel: BaseChannel<Int>
    private let startDate = Date()
    private var cancellables = Set<AnyCancellable>()

    init(channel: BaseChannel<Int>) {
        self.channel = channel
    }

    func start() {
        cancellables.forEach { $0.cancel() }
        cancellables = .init()

        Timer.publish(every: 1, on: .main, in: .default)
            .autoconnect()
            .map { [unowned self] in Int($0.timeIntervalSince(startDate)) }
            .sink { [unowned self] in channel.send(value: $0) }
            .store(in: &cancellables)
    }
}
