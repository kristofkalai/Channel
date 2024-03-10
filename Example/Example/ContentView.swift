//
//  ContentView.swift
//  Example
//
//  Created by Kristóf Kálai on 10/03/2024.
//

import Channel
import Combine
import SwiftUI
import RxSwift

struct ContentView: View {
    var body: some View {
        VStack {
            BasicChannelExample()
            OddChannelExample()
            OldProducerAdapterExample()
            RxChannelExample()
        }
        .monospaced()
    }
}

struct BasicChannelExample: View {
    private let channel = ClosureChannel<Int>()
    private let producer: Producer

    @State private var number = -1

    init() {
        self.producer = .init(channel: channel)
    }

    var body: some View {
        Text("BasicChannelExample \(number)")
            .task  {
                producer.start()
                channel.receiveOutput = {
                    number = $0
                }
            }
    }
}

struct OddChannelExample: View {
    private let channel = OddChannel()
    private let producer: Producer

    @State private var number = -1

    init() {
        self.producer = .init(channel: channel)
    }

    var body: some View {
        Text("OddChannelExample \(number)")
            .task  {
                producer.start()
                for await item in channel.sequence {
                    number = item
                }
            }
    }
}

struct OldProducerAdapterExample: View {
    private let channel = ClosureChannel<Int>()
    private let producer: OldProducerAdapter // OldProducer doesn't work here

    @State private var number = -1

    init() {
        self.producer = .init(channel: channel)
    }

    var body: some View {
        Text("OldProducerAdapterExample \(number)")
            .task  {
                producer.start()
                channel.receiveOutput = {
                    number = $0
                }
            }
    }
}

struct RxChannelExample: View {
    private let channel = RxChannel<Int>()
    private let producer: Producer

    @State private var number = -1
    @State private var disposeBag = DisposeBag()

    init() {
        self.producer = .init(channel: channel)
    }

    var body: some View {
        Text("RxChannelExample \(number)")
            .task  {
                producer.start()
                channel.observable
                    .subscribe(onNext: { number = $0 })
                    .disposed(by: disposeBag)
            }
    }
}

#Preview {
    ContentView()
}
