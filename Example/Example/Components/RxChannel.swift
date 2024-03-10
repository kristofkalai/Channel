//
//  RxChannel.swift
//  Example
//
//  Created by Kristóf Kálai on 10/03/2024.
//

import Channel
import RxSwift
import RxRelay

final class RxChannel<Output>: BaseChannel<Output> {
    private let subject = PublishSubject<Output>()

    var observable: Observable<Output> {
        subject
    }

    override init() {
        super.init()
    }

    override func send(value: Output) {
        super.send(value: value)
        subject.onNext(value)
    }
}
