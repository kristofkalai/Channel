//
//  ClosureChannel.swift
//
//
//  Created by Kristóf Kálai on 10/03/2024.
//

open class ClosureChannel<Output>: BaseChannel<Output> {
    private let replay: Bool
    private var latestOutput: Output?

    open var receiveOutput: ((Output) -> Void)? {
        didSet {
            if replay, let latestOutput {
                send(value: latestOutput)
            }
        }
    }

    public init(replay: Bool = true, latestOutput: Output? = nil, receiveOutput: ((Output) -> Void)? = nil) {
        self.replay = replay
        self.latestOutput = latestOutput
        self.receiveOutput = receiveOutput
    }

    open override func send(value: Output) {
        super.send(value: value)
        latestOutput = value
        receiveOutput?(value)
    }
}
