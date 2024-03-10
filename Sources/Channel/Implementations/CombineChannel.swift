//
//  CombineChannel.swift
//
//
//  Created by Kristóf Kálai on 10/03/2024.
//

import Combine

open class CombineChannel<Output>: BaseChannel<Output> {
    private let subject = PassthroughSubject<Output, Never>()

    open var publisher: AnyPublisher<Output, Never> {
        subject.eraseToAnyPublisher()
    }

    public override init() {
        super.init()
    }

    open override func send(value: Output) {
        super.send(value: value)
        subject.send(value)
    }
}
