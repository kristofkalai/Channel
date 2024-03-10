//
//  AsyncChannel.swift
//
//
//  Created by Kristóf Kálai on 10/03/2024.
//

open class AsyncChannel<Output>: BaseChannel<Output> {
    private let (stream, continuation) = AsyncStream.makeStream(of: Output.self)

    open var sequence: AsyncStream<Output> {
        stream
    }

    private var latestOutput: Output?

    public init(latestOutput: Output? = nil) {
        super.init()
        if let latestOutput {
            send(value: latestOutput)
        }
    }

    open override func send(value: Output) {
        super.send(value: value)
        continuation.yield(value)
    }
}
